import 'package:get_it/get_it.dart';

import '../data/datasources/comments_remote_datasource.dart';
import '../data/datasources/publications_remote_datasource.dart';
import '../data/repositories/comments_repository_impl.dart';
import '../data/repositories/publications_repository_impl.dart';
import '../domain/repositories/comment_repository.dart';
import '../domain/repositories/publication_repository.dart';
import '../domain/usecases/add_publication_usecase.dart';
import '../domain/usecases/create_comment_usecase.dart';
import '../domain/usecases/get_all_comments_usecase.dart';
import '../domain/usecases/get_all_publications_usecase.dart';
import '../domain/usecases/set_liked_usecase.dart';
import '../presentation/bloc/comments_bloc/comments_bloc.dart';
import '../presentation/bloc/publications_bloc/publications_bloc.dart';

Future<void> registerPublicationsFeature(GetIt sl) async {
  _registerDatasources(sl);
  _registerRepositories(sl);
  _registerUsecases(sl);
  _registerBlocsAndCubits(sl);
}

void _registerDatasources(GetIt sl) {
  sl.registerLazySingleton<PublicationsRemoteDataSource>(
    () => PublicationsRemoteDataSourceImpl(
      dio: sl(),
    ),
  );

  sl.registerLazySingleton<CommentsRemoteDataSource>(
    () => CommentsRemoteDataSourceImpl(
      dio: sl(),
    ),
  );
}

void _registerRepositories(GetIt sl) {
  sl.registerLazySingleton<PublicationRepository>(
    () => PublicationRepositoryImpl(
      remoteDataSource: sl<PublicationsRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<CommentRepository>(
    () => CommentRepositoryImpl(
      remoteDataSource: sl<CommentsRemoteDataSource>(),
    ),
  );
}

void _registerUsecases(GetIt sl) {
  sl.registerLazySingleton(
    () => AddPublicationUsecase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => GetPublicationsUsecase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => SetLikedUsecase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => CommentGetAll(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => CommentCreate(
      repository: sl(),
    ),
  );
}

void _registerBlocsAndCubits(GetIt sl) {
  sl.registerFactory(
    () => PublicationsBloc(
      addPublication: sl<AddPublicationUsecase>(),
      getPublications: sl<GetPublicationsUsecase>(),
      setLiked: sl<SetLikedUsecase>(),
    ),
  );
  sl.registerFactory(
    () => CommentsBloc(
      getAll: sl<CommentGetAll>(),
      create: sl<CommentCreate>(),
    ),
  );
}
