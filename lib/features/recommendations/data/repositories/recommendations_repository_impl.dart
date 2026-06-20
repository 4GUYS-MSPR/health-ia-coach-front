import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/logging/logger_mixin.dart';
import '../../domain/entities/dish_analysis.dart';
import '../../domain/failures/recommendations_failures.dart';
import '../../domain/repositories/recommendations_repository.dart';
import '../datasources/recommendations_local_datasource.dart';
import '../datasources/recommendations_remote_datasource.dart';

class RecommendationsRepositoryImpl
    with LoggerMixin
    implements RecommendationsRepository {

  RecommendationsRepositoryImpl({
    required this.localDataSource,
    required this.remoteDatasource,
  });

  final RecommendationsLocalDatasource localDataSource;
  final RecommendationsRemoteDatasource remoteDatasource;

  @override
  String get loggerName =>
      'Recommendations.Data.RecommendationsRepositoryImpl';

  @override
  TaskEither<Failure, DishAnalysis> analyzeDish({
    required PlatformFile image,
  }) {
    return TaskEither.tryCatch(
      () async => await localDataSource.analyzeDish(image: image),
      (error, stackTrace) {
        logger.severe('Erreur lors de l\'analyse IA : $error', error, stackTrace);
        return AiFailure(debugMessage: error.toString());
      },
    );
  }

  @override
  TaskEither<Failure, String> recommendationsRequest() {
    return TaskEither.tryCatch(
      () async => await remoteDatasource.recommendationsRequest(),
      (error, stackTrace) {
        logger.severe('Erreur lors de l\'analyse IA : $error', error, stackTrace);
        return AiFailure(debugMessage: error.toString());
      },
    );
  }
}