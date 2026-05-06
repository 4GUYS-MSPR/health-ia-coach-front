import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health_ia_care/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:health_ia_care/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:health_ia_care/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:health_ia_care/features/auth/domain/repositories/auth_repository.dart';
import 'package:health_ia_care/features/auth/domain/usecases/login_usecase.dart';
import 'package:health_ia_care/features/auth/domain/usecases/auth_check_usecase.dart';
import 'package:health_ia_care/features/auth/domain/usecases/register_usecase.dart';
import 'package:health_ia_care/features/auth/presentation/bloc/auth_bloc.dart';

void registerAuth(GetIt sl) {
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerFactory<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(secureStorage: sl()),
  );
  sl.registerFactory(
    () => AuthRemoteDataSource(
      dio: Dio(),
      baseUrl: dotenv.get('BASE_URL'),
      localDataSource: sl<AuthLocalDataSource>(),
    ),
  );
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerFactory(
    () => RegisterUseCase(sl()),
  );
  sl.registerFactory(
    () => LoginUseCase(sl()),
  );
  sl.registerFactory(() => AuthCheckUseCase(sl()));
  sl.registerLazySingleton(() => AuthBloc(register: sl(), login: sl(), authCheck: sl()));
}
