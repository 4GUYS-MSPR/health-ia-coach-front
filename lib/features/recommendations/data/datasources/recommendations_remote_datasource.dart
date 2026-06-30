import 'package:dio/dio.dart';

import '../../../../core/logging/logger_mixin.dart';
import '../models/recommendation_model.dart';

abstract interface class RecommendationsRemoteDatasource {
  Future<RecommendationModel> recommendationsRequest();
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
  Future<RecommendationModel> recommendationsRequest() async {
    final response = await dio.get('/api/ia/recommendation/');

    if (response.statusCode == 200) {
      return RecommendationModel.fromJson(response.data as Map<String, dynamic>);
    }

    throw Exception('Erreur lors de la récupération des recommandations: ${response.statusCode}');
  }
}
