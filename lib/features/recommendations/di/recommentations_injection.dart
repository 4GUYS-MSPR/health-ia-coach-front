import 'package:get_it/get_it.dart';

import '../data/datasources/recommendations_remote_datasource.dart';
import '../data/repositories/recommendations_repository_impl.dart';
import '../domain/repositories/recommendations_repository.dart';
import '../domain/usecases/analyze_dish_usecase.dart';
import '../presentation/blocs/recommendations/recommendations_bloc.dart';

Future<void> registerRecommendations(GetIt sl) async {
  // DataSource
  sl.registerLazySingleton<RecommendationsRemoteDatasource>(
    () => RecommendationsRemoteDatasourceImpl(
      dio: sl(),
    ),
  );

  sl.registerLazySingleton<RecommendationsRepository>(
    () => RecommendationsRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // UseCase
  sl.registerLazySingleton(
    () => AnalyzeDishUsecase(
      repository: sl<RecommendationsRepository>(),
    ),
  );

  // Bloc
  sl.registerLazySingleton(
    () => RecommendationsBloc(
      analyzeDishUsecase: sl<AnalyzeDishUsecase>(),
    ),
  );
}
