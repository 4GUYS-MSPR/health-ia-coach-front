import 'package:get_it/get_it.dart';

import '../data/datasources/recommendations_local_datasource.dart';
import '../data/datasources/recommendations_remote_datasource.dart';
import '../data/repositories/recommendations_repository_impl.dart';
import '../domain/repositories/recommendations_repository.dart';
import '../domain/usecases/analyze_dish_usecase.dart';
import '../domain/usecases/recommendations_request.dart';
import '../presentation/blocs/recommendations/recommendations_bloc.dart';

Future<void> registerRecommendations(GetIt sl) async {
  sl.registerLazySingleton<RecommendationsLocalDatasource>(
    () => RecommendationsLocalDatasourceImpl(),
  );
  sl.registerLazySingleton<RecommendationsRemoteDatasource>(
    () => RecommendationsRemoteDatasourceImpl(dio: sl()),
  );

  sl.registerLazySingleton<RecommendationsRepository>(
    () => RecommendationsRepositoryImpl(
      localDataSource: sl(),
      remoteDatasource: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => AnalyzeDishUsecase(
      repository: sl<RecommendationsRepository>(),
    ),
  );
  sl.registerLazySingleton(
    () => RecommendationsRequestUsecase(
      repository: sl<RecommendationsRepository>(),
    ),
  );

  sl.registerLazySingleton(
    () => RecommendationsBloc(
      analyzeDishUsecase: sl<AnalyzeDishUsecase>(),
      recommendationsRequestUsecase: sl<RecommendationsRequestUsecase>(),
    ),
  );

  await sl<RecommendationsLocalDatasource>().initialize();
}