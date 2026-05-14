import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health_ia_care/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:health_ia_care/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:health_ia_care/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:health_ia_care/features/profile/domain/repositories/profile_repository.dart';
import 'package:health_ia_care/features/profile/domain/usecases/update_info_profile_usecase.dart';
import 'package:health_ia_care/features/profile/presentation/bloc/profile_bloc.dart';


void registerProfile(GetIt sl) {
  sl.registerFactory(() => ProfileBloc(updateProfile: sl()));

  sl.registerFactory(() => UpdateInfoProfileUsecase(sl()));

  sl.registerFactory<ProfileRepository>(
    () => ProfileRepositoryImpl(
      sl(), 
      sl(),
      sl(),
    ),
  );

  sl.registerFactory<ProfileLocalDatasource>(
    () => ProfileLocalDatasourceImpl(secureStorage: sl()),
  );

  sl.registerFactory(() => ProfileRemoteDatasource(
    dio: sl(),
    baseUrl: dotenv.get('BASE_URL'),
    localDataSource: sl(),
  ));

  sl.registerLazySingleton(() => Dio());
}