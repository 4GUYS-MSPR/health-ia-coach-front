import 'package:get_it/get_it.dart';
import 'package:health_ia_care/features/comment/data/datasources/comment_remote_datasource.dart';
import 'package:health_ia_care/features/comment/data/repositories/comment_repository_impl.dart';
import 'package:health_ia_care/features/comment/domain/repositories/comment_repository.dart';
import 'package:health_ia_care/features/comment/domain/usecases/create.dart';
import 'package:health_ia_care/features/comment/domain/usecases/get_all.dart';
import 'package:health_ia_care/features/comment/presentation/bloc/comment_bloc.dart';

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
