import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/repositories/comment_repository.dart';
import '../datasources/comment_remote_datasource.dart';
import '../models/comment_model.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource remoteDataSource;

  CommentRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<CommentModel>>> getAll({required int publicationId}) async {
    try {
      final comments = await remoteDataSource.getAll(publicationId: publicationId);
      return right(comments);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CommentModel>> create({
    required int publicationId,
    required String content,
  }) async {
    try {
      final comment = await remoteDataSource.create(
        publicationId: publicationId,
        content: content,
      );
      return right(comment);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
