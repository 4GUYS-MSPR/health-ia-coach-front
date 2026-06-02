import 'package:get_it/get_it.dart';

import '../data/datasources/comment_remote_datasource.dart';
import '../data/repositories/comment_repository_impl.dart';
import '../domain/repositories/comment_repository.dart';
import '../domain/usecases/create.dart';
import '../domain/usecases/get_all.dart';
import '../presentation/bloc/comment_bloc.dart';

Future<void> registerComment(GetIt sl) async {
  // DataSource
  sl.registerFactory<CommentRemoteDataSource>(
    () => CommentRemoteDataSourceImpl(
      dio: sl(),
    ),
  );

  sl.registerFactory<CommentRepository>(
    () => CommentRepositoryImpl(
      remoteDataSource: sl<CommentRemoteDataSource>(),
    ),
  );

  // UseCase
  sl.registerFactory(
    () => CommentGetAll(sl<CommentRepository>()),
  );
  sl.registerFactory(
    () => CommentCreate(sl<CommentRepository>()),
  );

  // Bloc
  sl.registerFactory(
    () => CommentBloc(
      getAll: sl<CommentGetAll>(),
      create: sl<CommentCreate>(),
    ),
  );
}
