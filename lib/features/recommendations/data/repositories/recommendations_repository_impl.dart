import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/logging/logger_mixin.dart';
import '../../../../errors/failure.dart';
import '../../domain/entities/dish_analysis.dart';
import '../../domain/repositories/recommendations_repository.dart';
import '../datasources/recommendations_local_datasource.dart';

class RecommendationsRepositoryImpl
    with LoggerMixin
    implements RecommendationsRepository {

  RecommendationsRepositoryImpl({
    required this.localDataSource,
  });

  final RecommendationsLocalDatasource localDataSource;

  @override
  String get loggerName =>
      'Recommendations.Data.RecommendationsRepositoryImpl';

  @override
  Future<Either<Failure, DishAnalysis>> analyzeDish({
    required PlatformFile image,
  }) async {
    try {
      final result = await localDataSource.analyzeDish(image: image);
      return right(result);
    } on Exception catch (e) {
      logger.severe('Erreur lors de l\'analyse IA : $e');
      return left(AiFailure(message: e.toString()));
    }
  }
}