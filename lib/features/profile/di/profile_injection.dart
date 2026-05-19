import 'package:get_it/get_it.dart';
import 'package:health_ia_care/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:health_ia_care/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:health_ia_care/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:health_ia_care/features/profile/domain/repositories/profile_repository.dart';
import 'package:health_ia_care/features/profile/domain/usecases/display_user_traning_info_usecase.dart';
import 'package:health_ia_care/features/profile/domain/usecases/update_info_profile_usecase.dart';
import 'package:health_ia_care/features/profile/domain/usecases/update_info_member_usecase.dart';
import 'package:health_ia_care/features/profile/presentation/bloc/profile_bloc.dart';

void registerProfile(GetIt sl) {
  sl.registerFactory(() => ProfileBloc(
    updateProfile: sl(),
    displayTraningStats: sl(),
    updateMemberProfile: sl(),
    ));

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
