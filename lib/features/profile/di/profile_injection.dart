import 'package:get_it/get_it.dart';

import '../data/datasources/profile_remote_datasource.dart';
import '../data/repositories/profile_repository_impl.dart';
import '../domain/repositories/profile_repository.dart';
import '../domain/usecases/get_profile_usecase.dart';
import '../domain/usecases/update_avatar_usecase.dart';
import '../domain/usecases/update_profile_usecase.dart';
import '../presentation/bloc/profile_bloc.dart';

void registerProfile(GetIt sl) {
  _registerDatasources(sl);
  _registerRepositories(sl);
  _registerUsecases(sl);
  _registerBlocsAndCubits(sl);
}

void _registerDatasources(GetIt sl) {
  sl.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasourceImpl(
      dio: sl(),
    ),
  );
}

void _registerRepositories(GetIt sl) {
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDatasource: sl(),
    ),
  );
}

void _registerUsecases(GetIt sl) {
  sl.registerLazySingleton(
    () => GetProfileUsecase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => UpdateAvatarUsecase(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => UpdateProfileUsecase(
      repository: sl(),
    ),
  );
}

void _registerBlocsAndCubits(GetIt sl) {
  sl.registerFactory(
    () => ProfileBloc(
      getProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      updateAvatarUseCase: sl(),
    ),
  );
}
