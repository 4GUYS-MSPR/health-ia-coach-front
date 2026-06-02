import 'package:get_it/get_it.dart';

import '../../auth/data/datasources/auth_local_datasource.dart';
import '../data/datasources/publication_remote_datasource.dart';
import '../data/repositories/publication_repository_impl.dart';
import '../domain/repositories/publication_repository.dart';
import '../domain/usecases/add_publication_usecase.dart';
import '../domain/usecases/get_all_publications_usecase.dart';
import '../domain/usecases/set_liked_usecase.dart';
import '../presentation/bloc/publication_bloc.dart';

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
  sl.registerFactory(
    () => GetPublicationsUsecase(sl<PublicationRepository>()),
  );
  sl.registerFactory(
    () => SetLikedUsecase(sl<PublicationRepository>()),
  );

  // Bloc
  sl.registerFactory(
    () => PublicationBloc(
      addPublication: sl<AddPublicationUsecase>(),
      getPublications: sl<GetPublicationsUsecase>(),
      setLiked: sl<SetLikedUsecase>(),
    ),
  );
}
