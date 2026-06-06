import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../core/logging/logger_mixin.dart';
import '../models/dish_analysis_model.dart';

abstract interface class RecommendationsRemoteDatasource {
  Future<DishAnalysisModel> analyzeDish({
    required PlatformFile image,
  });
  Future<String> recommendationsRequest();
}

class RecommendationsRemoteDatasourceImpl
    with LoggerMixin
    implements RecommendationsRemoteDatasource {
  final Dio dio;

  RecommendationsRemoteDatasourceImpl({
    required this.dio,
  });

  @override
  String get loggerName => 'Recommendations.Data.Datasources.RecommendationsRemoteDatasourceImpl';

  @override
  Future<DishAnalysisModel> analyzeDish({
    required PlatformFile image,
  }) async {
    MultipartFile file;
    if (image.bytes != null) {
      file = MultipartFile.fromBytes(image.bytes!, filename: image.name);
    } else if (image.path != null) {
      file = await MultipartFile.fromFile(image.path!, filename: image.name);
    } else {
      throw Exception('Fichier image invalide');
    }

    final formData = FormData();
    formData.files.add(MapEntry('image', file));

    final response = await dio.post(
      '/api/recommendations/analyze',
      data: formData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return DishAnalysisModel.fromMap(response.data as Map<String, dynamic>);
    }

    throw Exception('Erreur lors de l\'analyse: ${response.statusCode}');
  }

  @override
  Future<String> recommendationsRequest() async {
    final response = await dio.get('/api/ia/recommendation/');

    if (response.statusCode == 200) {
      return response.data;
    }

    throw Exception('Erreur lors de l\'analyse: ${response.statusCode}');
  }
}
