import 'package:get_it/get_it.dart';

import '../data/datasources/profile_local_datasource.dart';
import '../data/datasources/profile_remote_datasource.dart';
import '../data/repositories/profile_repository_impl.dart';
import '../domain/repositories/profile_repository.dart';
import '../domain/usecases/display_user_traning_info_usecase.dart';
import '../domain/usecases/update_info_member_usecase.dart';
import '../domain/usecases/update_info_profile_usecase.dart';
import '../presentation/bloc/profile_bloc.dart';

void registerProfile(GetIt sl) {
  sl.registerFactory(
    () => ProfileBloc(
      updateProfile: sl(),
      displayTraningStats: sl(),
      updateMemberProfile: sl(),
    ),
  );

  sl.registerFactory(() => UpdateInfoProfileUsecase(sl()));
  sl.registerFactory(() => UpdateInfoMemberUsecase(sl()));
  sl.registerFactory(() => DisplayUserTrainingUsecase(sl()));

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

  sl.registerFactory(
    () => ProfileRemoteDatasource(
      dio: sl(),
      localDataSource: sl(),
    ),
  );
}
