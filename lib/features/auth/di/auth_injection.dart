import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../profile/data/datasources/profile_local_datasource.dart';
import '../data/datasources/auth_local_datasource.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/auth_check_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/logout_usecase.dart';
import '../domain/usecases/register_usecase.dart';
import '../domain/usecases/update_avatar.dart';
import '../presentation/bloc/auth_bloc.dart';

void registerAuth(GetIt sl) {
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerFactory<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(secureStorage: sl()),
  );
  sl.registerFactory(
    () => AuthRemoteDataSource(
      dio: sl(),
      localDataSource: sl<AuthLocalDataSource>(),
      profileLocalDatasource: sl<ProfileLocalDatasource>(),
    ),
  );
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  sl.registerFactory(
    () => RegisterUseCase(sl()),
  );
  sl.registerFactory(
    () => LoginUseCase(sl()),
  );
  sl.registerFactory(
    () => UpdateAvatar(sl()),
  );
  sl.registerFactory(() => GetUser(sl()));
  sl.registerFactory(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(
    () => AuthBloc(
      register: sl(),
      login: sl(),
      getUser: sl(),
      logout: sl(),
      updateAvatar: sl(),
    ),
  );
}
