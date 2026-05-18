import 'package:get_it/get_it.dart';
import 'package:health_ia_care/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:health_ia_care/features/publication/data/datasources/publication_remote_datasource.dart';
import 'package:health_ia_care/features/publication/data/repositories/publication_repository_impl.dart';
import 'package:health_ia_care/features/publication/domain/repositories/publication_repository.dart';
import 'package:health_ia_care/features/publication/domain/usecases/add_publication_usecase.dart';
import 'package:health_ia_care/features/publication/presentation/bloc/publication_bloc.dart';

Future<void> registerPublication(GetIt sl) async {
  // DataSource
  sl.registerFactory<PublicationRemoteDataSource>(
    () => PublicationRemoteDataSourceImpl(
      dio: sl(),
      localDataSource: sl<AuthLocalDataSource>(),
    ),
  );

  sl.registerFactory<PublicationRepository>(
    () => PublicationRepositoryImpl(
      remoteDataSource: sl<PublicationRemoteDataSource>(),
    ),
  );

  // UseCase
  sl.registerFactory(
    () => AddPublicationUsecase(sl<PublicationRepository>()),
  );

  // Bloc
  sl.registerFactory(
    () => PublicationBloc(
      addPublication: sl<AddPublicationUsecase>(),
    ),
  );
}