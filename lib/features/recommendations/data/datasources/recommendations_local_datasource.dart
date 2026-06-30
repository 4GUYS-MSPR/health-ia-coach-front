import 'dart:io';
import 'dart:math' as math;

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
  // Taille d'entrée du modèle ONNX (224x224, conforme à l'entraînement PyTorch)
  static const int _inputSize = 224;
  // Taille intermédiaire de redimensionnement avant recadrage central
  // Reproduit transforms.Resize(256) utilisé en validation côté Python
  static const int _resizeTarget = 256;
  static const List<double> _mean = [0.485, 0.456, 0.406];
  static const List<double> _std = [0.229, 0.224, 0.225];
  static const int _topK = 5;

  static const String _tableName = 'aliments';
  static const String _labelColumn = 'label';

  // Dictionnaire complet de traduction (Clé: Français, Valeur: Label Anglais du modèle)
  static const Map<String, String> _labelTranslations = {
    'tarte_aux_pommes': 'apple_pie',
    'travers_de_porc': 'baby_back_ribs',
    'baklava': 'baklava',
    'carpaccio_de_boeuf': 'beef_carpaccio',
    'tartare_de_boeuf': 'beef_tartare',
    'salade_de_betteraves': 'beet_salad',
    'beignets': 'beignets',
    'bibimbap': 'bibimbap',
    'pudding_au_pain': 'bread_pudding',
    'burrito_de_petit_dejeuner': 'breakfast_burrito',
    'bruschetta': 'bruschetta',
    'salade_cesar': 'caesar_salad',
    'cannoli': 'cannoli',
    'salade_caprese': 'caprese_salad',
    'gateau_aux_carottes': 'carrot_cake',
    'ceviche': 'ceviche',
    'plateau_de_fromages': 'cheese_plate',
    'cheesecake': 'cheesecake',
    'curry_de_poulet': 'chicken_curry',
    'quesadilla_au_poulet': 'chicken_quesadilla',
    'ailes_de_poulet': 'chicken_wings',
    'gateau_au_chocolat': 'chocolate_cake',
    'mousse_au_chocolat': 'chocolate_mousse',
    'churros': 'churros',
    'chaudree_de_clovisses': 'clam_chowder',
    'club_sandwich': 'club_sandwich',
    'croquettes_de_crabe': 'crab_cakes',
    'creme_brulee': 'creme_brulee',
    'croque_madame': 'croque_madame',
    'cupcakes': 'cup_cakes',
    'oeufs_mimosas': 'deviled_eggs',
    'donuts': 'donuts',
    'raviolis_asiatiques': 'dumplings',
    'edamame': 'edamame',
    'oeufs_benedicte': 'eggs_benedict',
    'escargots': 'escargots',
    'falafel': 'falafel',
    'filet_mignon': 'filet_mignon',
    'fish_and_chips': 'fish_and_chips',
    'foie_gras': 'foie_gras',
    'frites': 'french_fries',
    'soupe_a_l_oignon': 'french_onion_soup',
    'pain_perdu': 'french_toast',
    'calamars_frits': 'fried_calamari',
    'riz_frit': 'fried_rice',
    'yaourt_glace': 'frozen_yogurt',
    'pain_a_l_ail': 'garlic_bread',
    'gnocchi': 'gnocchi',
    'salade_grecque': 'greek_salad',
    'sandwich_au_fromage_fondu': 'grilled_cheese_sandwich',
    'saumon_grille': 'grilled_salmon',
    'guacamole': 'guacamole',
    'gyoza': 'gyoza',
    'hamburger': 'hamburger',
    'soupe_aigre_douce': 'hot_and_sour_soup',
    'hot_dog': 'hot_dog',
    'huevos_rancheros': 'huevos_rancheros',
    'houmous': 'hummus',
    'glace': 'ice_cream',
    'lasagnes': 'lasagna',
    'bisque_de_homard': 'lobster_bisque',
    'lobster_roll': 'lobster_roll_sandwich',
    'macaroni_au_fromage': 'macaroni_and_cheese',
    'macarons': 'macarons',
    'soupe_miso': 'miso_soup',
    'moules': 'mussels',
    'nachos': 'nachos',
    'omelette': 'omelette',
    'oignon_rings': 'onion_rings',
    'huitres': 'oysters',
    'pad_thai': 'pad_thai',
    'paella': 'paella',
    'pancakes': 'pancakes',
    'panna_cotta': 'panna_cotta',
    'canard_laque': 'peking_duck',
    'pho': 'pho',
    'pizza': 'pizza',
    'cote_de_porc': 'pork_chop',
    'poutine': 'poutine',
    'cote_de_boeuf': 'prime_rib',
    'sandwich_au_porc_effiloche': 'pulled_pork_sandwich',
    'ramen': 'ramen',
    'ravioli': 'ravioli',
    'red_velvet_cake': 'red_velvet_cake',
    'risotto': 'risotto',
    'samosa': 'samosa',
    'sashimi': 'sashimi',
    'coquilles_saint_jacques': 'scallops',
    'salade_d_algues': 'seaweed_salad',
    'shrimp_and_grits': 'shrimp_and_grits',
    'spaghetti_bolognese': 'spaghetti_bolognese',
    'spaghetti_carbonara': 'spaghetti_carbonara',
    'nems': 'spring_rolls',
    'steak': 'steak',
    'fraisier': 'strawberry_shortcake',
    'sushi': 'sushi',
    'tacos': 'tacos',
    'takoyaki': 'takoyaki',
    'tiramisu': 'tiramisu',
    'tartare_de_thon': 'tuna_tartare',
    'gaufres': 'waffles',
  };

  OrtSession? _session;
  Database? _database;
  List<String> _labels = [];
  bool _isInitialized = false;
  late final String _inputName;
  late final String _outputName;

  @override
  String get loggerName => 'Recommendations.Data.Datasources.RecommendationsLocalDatasourceImpl';

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
      'assets/ml/best_model.onnx',
    );
    _inputName = _session!.inputNames[0];
    _outputName = _session!.outputNames[0];
    _labels = await _loadLabels('assets/ml/labels.txt');
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
    final dbFile = File('${docsDir.path}/health_detector.db');

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

    final inputData = _preprocessImage(bytes);
    final inputTensor = await OrtValue.fromList(
      inputData,
      [1, 3, _inputSize, _inputSize],
    );

    final outputs = await _session!.run({_inputName: inputTensor});
    inputTensor.dispose();

    final rawScores = await _extractScores(outputs);
    for (final t in outputs.values) {
      t.dispose();
    }
    final probabilities = _softmax(rawScores);

    final topFoods = _buildTopFoods(probabilities);

    final nutrition = await _fetchNutrition(topFoods.first.name);

    logger.info(
      'Analyse terminée : ${topFoods.first.name} '
      '(${(topFoods.first.confidence * 100).toStringAsFixed(1)}%) — '
      '${nutrition.calories} kcal',
    );

    return DishAnalysisModel(
      foods: topFoods,
      nutrition: nutrition,
      reliability: topFoods.first.confidence,
      recommendation: null,
    );
  }

  Future<NutritionValuesModel> _fetchNutrition(String labelEn) async {
    final db = _database!;
    final cleanLabelEn = labelEn.trim().toLowerCase();

    String labelFr = _labelTranslations.entries
        .firstWhere(
          (e) => e.value.toLowerCase().trim() == cleanLabelEn,
          orElse: () => MapEntry(labelEn, labelEn),
        )
        .key;

    logger.info('Recherche SQL pour : En="$cleanLabelEn" | Fr="$labelFr"');

    List<Map<String, dynamic>> rows = await db.query(
      _tableName,
      where:
          '$_labelColumn = ? OR $_labelColumn = ? OR $_labelColumn LIKE ? OR $_labelColumn LIKE ?',
      whereArgs: [cleanLabelEn, labelFr, '%$cleanLabelEn%', '%$labelFr%'],
      limit: 1,
    );

    if (rows.isEmpty) {
      logger.warning(
        '❌ Aucune donnée nutritionnelle trouvée dans SQLite pour "$cleanLabelEn" / "$labelFr"',
      );
      return NutritionValuesModel.empty();
    }

    logger.info('✅ Données nutritionnelles trouvées avec succès !');
    return NutritionValuesModel.fromMap(rows.first);
  }

  @override
  Future<void> dispose() async {
    await _session?.close();
    await _database?.close();
    _session = null;
    _database = null;
    _isInitialized = false;
    logger.info('Ressources ONNX + SQLite libérées');
  }

  Future<List<String>> _loadLabels(String assetPath) async {
    final content = await rootBundle.loadString(assetPath);
    return content.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty).toList();
  }

  Future<Uint8List> _getBytesFromPlatformFile(PlatformFile file) async {
    if (file.bytes != null) return file.bytes!;
    if (file.path != null) return await File(file.path!).readAsBytes();
    throw Exception('PlatformFile invalide');
  }

  // PRÉTRAITEMENT D'IMAGE — reproduit exactement val_transforms de PyTorch :
  // transforms.Resize(256) puis transforms.CenterCrop(224)
  List<double> _preprocessImage(Uint8List bytes) {
    img.Image? originalImage = img.decodeImage(bytes);
    if (originalImage == null) throw Exception('Impossible de décoder l\'image');

    // Étape 1 : Resize en conservant le ratio d'aspect (plus petit côté = 256)
    img.Image resized;
    if (originalImage.width < originalImage.height) {
      final newHeight = (originalImage.height * _resizeTarget / originalImage.width).round();
      resized = img.copyResize(originalImage, width: _resizeTarget, height: newHeight);
    } else {
      final newWidth = (originalImage.width * _resizeTarget / originalImage.height).round();
      resized = img.copyResize(originalImage, width: newWidth, height: _resizeTarget);
    }

    // Étape 2 : Recadrage central en 224x224
    final cropX = ((resized.width - _inputSize) / 2).round();
    final cropY = ((resized.height - _inputSize) / 2).round();
    img.Image cropped = img.copyCrop(
      resized,
      x: cropX,
      y: cropY,
      width: _inputSize,
      height: _inputSize,
    );

    // Force la conversion en format 8-bit standardisé par canal (RGBA)
    final image = cropped.convert(numChannels: 4);

    final input = List<double>.filled(1 * 3 * _inputSize * _inputSize, 0.0);
    final int channelStride = _inputSize * _inputSize;

    for (int y = 0; y < _inputSize; y++) {
      for (int x = 0; x < _inputSize; x++) {
        final pixel = image.getPixel(x, y);

        // Extraction explicite et normalisation ImageNet RGB
        double r = (pixel.r / 255.0 - _mean[0]) / _std[0];
        double g = (pixel.g / 255.0 - _mean[1]) / _std[1];
        double b = (pixel.b / 255.0 - _mean[2]) / _std[2];

        // Rangement planaire standard pour PyTorch/ONNX [Channels, Height, Width]
        int pixelIdx = y * _inputSize + x;
        input[pixelIdx] = r;
        input[pixelIdx + channelStride] = g;
        input[pixelIdx + 2 * channelStride] = b;
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
    if (raw.isNotEmpty && raw.first is List) {
      return List<double>.from(raw.first as List);
    }
    return List<double>.from(raw);
  }

  List<double> _softmax(List<double> logits) {
    final maxVal = logits.reduce((a, b) => a > b ? a : b);
    final exps = logits.map((v) => math.exp(v - maxVal)).toList();
    final sumExp = exps.reduce((a, b) => a + b);
    return exps.map((e) => e / sumExp).toList();
  }

  List<DetectedFoodModel> _buildTopFoods(List<double> probabilities) {
    final indexed = List.generate(
      probabilities.length,
      (i) => (index: i, score: probabilities[i]),
    )..sort((a, b) => b.score.compareTo(a.score));

    return indexed.take(_topK).map((entry) {
      final label = entry.index < _labels.length ? _labels[entry.index] : 'Inconnu';
      return DetectedFoodModel(name: label, confidence: entry.score);
    }).toList();
  }
}
