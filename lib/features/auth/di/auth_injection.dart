import 'package:get_it/get_it.dart';

import '../data/datasources/auth_local_datasource.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/get_session_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/logout_usecase.dart';
import '../domain/usecases/register_usecase.dart';
import '../presentation/blocs/auth_bloc/auth_bloc.dart';
import '../presentation/cubits/login_cubit/login_cubit.dart';
import '../presentation/cubits/register_cubit/register_cubit.dart';

void registerAuth(GetIt sl) {
  _registerDatasources(sl);
  _registerRepositories(sl);
  _registerUsecases(sl);
  _registerBlocsAndCubits(sl);
}

void _registerDatasources(GetIt sl) {
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      secureStorage: sl(),
    ),
  );

  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      dio: sl(),
    ),
  );
}

void _registerRepositories(GetIt sl) {
  sl.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      localDatasource: sl(),
      remoteDatasource: sl(),
    ),
  );
}

void _registerUsecases(GetIt sl) {
  sl.registerLazySingleton(
    () => RegisterUsecase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => LoginUsecase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetSessionUsecase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => LogoutUsecase(
      repository: sl(),
    ),
  );
}

void _registerBlocsAndCubits(GetIt sl) {
  sl.registerLazySingleton(
    () => AuthBloc(
      getSessionUsecase: sl(),
      logoutUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => LoginCubit(
      loginWithPasswordUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => RegisterCubit(
      registerUsecase: sl(),
    ),
  );
}
