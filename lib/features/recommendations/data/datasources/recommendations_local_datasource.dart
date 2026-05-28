import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_onnxruntime/flutter_onnxruntime.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/logging/logger_mixin.dart';
import '../models/detected_food_model.dart';
import '../models/dish_analysis_model.dart';
import '../models/nutrition_values_model.dart';

abstract interface class RecommendationsLocalDatasource {
  Future<void> initialize();
  Future<DishAnalysisModel> analyzeDish({required PlatformFile image});
  Future<void> dispose();
}

class RecommendationsLocalDatasourceImpl
    with LoggerMixin
    implements RecommendationsLocalDatasource {

  static const int _inputSize = 224;
  static const List<double> _mean = [0.485, 0.456, 0.406];
  static const List<double> _std  = [0.229, 0.224, 0.225];
  static const int _topK = 5;

  static const String _tableName   = 'aliments';
  static const String _labelColumn = 'label';

  static const Map<String, String> _labelTranslations = {
    'riz':            'rice',
    'pates':          'carbonara',
    'poulet':         'cock',
    'steak':          'steak',
    'oeuf':           'hen',
    'salade':         'salad',
    'tomate':         'tomato',
    'brocoli':        'broccoli',
    'pain':           'bagel',
    'fromage':        'cheese',
    'frites':         'french loaf',
    'pomme_de_terre': 'butternut squash',
    'saumon':         'coho',
    'banane':         'banana',
    'yaourt':         'custard apple',
  };

  OrtSession?  _session;
  Database?    _database;
  List<String> _labels = [];
  bool         _isInitialized = false;
  late final String _inputName;
  late final String _outputName;

  @override
  String get loggerName =>
      'Recommendations.Data.Datasources.RecommendationsLocalDatasourceImpl';


  @override
  Future<void> initialize() async {
    if (_isInitialized) return;

    logger.info('Initialisation ONNX + SQLite...');

    await Future.wait([
      _initOnnx(),
      _initDatabase(),
    ]);

    _isInitialized = true;
    logger.info('Initialisation complète');
  }

  Future<void> _initOnnx() async {
    final ort = OnnxRuntime();
    _session = await ort.createSessionFromAsset(
      'assets/ml/food_model_single.onnx',
    );
    _inputName  = _session!.inputNames[0];
    _outputName = _session!.outputNames[0];
    _labels = await _loadLabels('assets/ml/label.txt');
    logger.info('ONNX prêt — ${_labels.length} classes');
    logger.info('Tenseur entrée  : $_inputName');
    logger.info('Tenseur sortie  : $_outputName');
  }

  Future<void> _initDatabase() async {
    final dbPath = await _copyDatabaseToDocuments();
    _database = await openDatabase(dbPath, readOnly: true);
    logger.info('SQLite ouvert : $dbPath');
  }

  Future<String> _copyDatabaseToDocuments() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbFile  = File('${docsDir.path}/health_detector.db');

    if (!await dbFile.exists()) {
      logger.info('Copie de la base SQLite depuis les assets...');
      final data = await rootBundle.load('assets/db/health_detector.db');
      await dbFile.writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      );
      logger.info('Base SQLite copiée vers : ${dbFile.path}');
    }

    return dbFile.path;
  }


  @override
  Future<DishAnalysisModel> analyzeDish({required PlatformFile image}) async {
    if (!_isInitialized || _session == null || _database == null) {
      throw Exception('Datasource non initialisé');
    }

    final bytes = await _getBytesFromPlatformFile(image);

    final inputData   = _preprocessImage(bytes);
    final inputTensor = await OrtValue.fromList(
      inputData,
      [1, 3, _inputSize, _inputSize],
    );

    final outputs = await _session!.run({_inputName: inputTensor});
    inputTensor.dispose();

    final rawScores     = await _extractScores(outputs);
    for (final t in outputs.values) { t?.dispose(); }
    final probabilities = _softmax(rawScores);

    final topFoods = _buildTopFoods(probabilities);

    final nutrition = await _fetchNutrition(topFoods.first.name);

    logger.info(
      'Analyse terminée : ${topFoods.first.name} '
      '(${(topFoods.first.confidence * 100).toStringAsFixed(1)}%) — '
      '${nutrition.calories} kcal',
    );

    return DishAnalysisModel(
      foods:          topFoods,
      nutrition:      nutrition,
      reliability:    topFoods.first.confidence,
      recommendation: null,
    );
  }

  String _translateLabel(String labelFr) {
    final translated = _labelTranslations[labelFr.toLowerCase()];
    if (translated == null) {
      logger.warning('Pas de traduction pour "$labelFr" — utilisation du label brut');
    }
    return translated ?? labelFr;
  }

  Future<NutritionValuesModel> _fetchNutrition(String labelFr) async {
    final db = _database!;

    final labelEn = _translateLabel(labelFr);
    logger.fine('Traduction : "$labelFr" → "$labelEn"');

    List<Map<String, dynamic>> rows = await db.query(
      _tableName,
      where: '$_labelColumn = ?',
      whereArgs: [labelEn],
      limit: 1,
    );

    if (rows.isEmpty) {
      logger.warning(
        'Label "$labelEn" non trouvé — tentative recherche partielle',
      );
      rows = await db.query(
        _tableName,
        where: '$_labelColumn LIKE ?',
        whereArgs: ['%$labelEn%'],
        limit: 1,
      );
    }

    if (rows.isEmpty) {
      logger.warning(
        'Aucune donnée nutritionnelle trouvée pour "$labelFr" (→ "$labelEn")',
      );
      return NutritionValuesModel.empty();
    }

    logger.fine('Données trouvées pour "$labelFr" (→ "$labelEn")');
    return NutritionValuesModel.fromMap(rows.first);
  }


  @override
  Future<void> dispose() async {
    await _session?.close();
    await _database?.close();
    _session       = null;
    _database      = null;
    _isInitialized = false;
    logger.info('Ressources ONNX + SQLite libérées');
  }


  Future<List<String>> _loadLabels(String assetPath) async {
    final content = await rootBundle.loadString(assetPath);
    return content
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();
  }

  Future<Uint8List> _getBytesFromPlatformFile(PlatformFile file) async {
    if (file.bytes != null) return file.bytes!;
    if (file.path != null) return await File(file.path!).readAsBytes();
    throw Exception('PlatformFile invalide');
  }

  List<double> _preprocessImage(Uint8List bytes) {
    img.Image? image = img.decodeImage(bytes);
    if (image == null) throw Exception('Impossible de décoder l\'image');
    image = img.copyResize(image, width: _inputSize, height: _inputSize);

    final input = List<double>.filled(1 * 3 * _inputSize * _inputSize, 0.0);
    int idx = 0;

    for (int c = 0; c < 3; c++) {
      for (int y = 0; y < _inputSize; y++) {
        for (int x = 0; x < _inputSize; x++) {
          final pixel = image.getPixel(x, y);
          final double raw = switch (c) {
            0 => pixel.r / 255.0,
            1 => pixel.g / 255.0,
            _ => pixel.b / 255.0,
          };
          input[idx++] = (raw - _mean[c]) / _std[c];
        }
      }
    }
    return input;
  }

  Future<List<double>> _extractScores(Map<String, OrtValue?> outputs) async {
    final outputTensor = outputs[_outputName];
    if (outputTensor == null) {
      throw Exception('Tenseur de sortie "$_outputName" introuvable');
    }
    final raw = await outputTensor.asList();
    if (raw is List && raw.isNotEmpty && raw.first is List) {
      return List<double>.from(raw.first as List);
    }
    if (raw is List) return List<double>.from(raw);
    throw Exception('Format de sortie inattendu : ${raw.runtimeType}');
  }

  List<double> _softmax(List<double> logits) {
    final maxVal = logits.reduce((a, b) => a > b ? a : b);
    final exps   = logits.map((v) {
      final x = v - maxVal;
      if (x < -88) return 0.0;
      return x >= 0
          ? 1 + x + x*x/2 + x*x*x/6 + x*x*x*x/24
          : 1 / (1 - x + x*x/2 - x*x*x/6 + x*x*x*x/24);
    }).toList();
    final sumExp = exps.reduce((a, b) => a + b);
    return exps.map((e) => e / sumExp).toList();
  }

  List<DetectedFoodModel> _buildTopFoods(List<double> probabilities) {
    final indexed = List.generate(
      probabilities.length,
      (i) => (index: i, score: probabilities[i]),
    )..sort((a, b) => b.score.compareTo(a.score));

    return indexed.take(_topK).map((entry) {
      final label = entry.index < _labels.length
          ? _labels[entry.index]
          : 'Inconnu';
      return DetectedFoodModel(name: label, confidence: entry.score);
    }).toList();
  }
}