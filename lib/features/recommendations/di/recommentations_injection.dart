import 'package:get_it/get_it.dart';

import '../data/datasources/recommendations_local_datasource.dart';
import '../data/repositories/recommendations_repository_impl.dart';
import '../domain/repositories/recommendations_repository.dart';
import '../domain/usecases/analyze_dish_usecase.dart';
import '../presentation/blocs/recommendations/recommendations_bloc.dart';

Future<void> registerRecommendations(GetIt sl) async {
  sl.registerLazySingleton<RecommendationsLocalDatasource>(
    () => RecommendationsLocalDatasourceImpl(),
  );

  sl.registerLazySingleton<RecommendationsRepository>(
    () => RecommendationsRepositoryImpl(
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => AnalyzeDishUsecase(
      repository: sl<RecommendationsRepository>(),
    ),
  );

  sl.registerLazySingleton(
    () => RecommendationsBloc(
      analyzeDishUsecase: sl<AnalyzeDishUsecase>(),
    ),
  );

  await sl<RecommendationsLocalDatasource>().initialize();
}