import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/comment_repository.dart';
import '../datasources/comments_remote_datasource.dart';
import '../models/comment_model.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentsRemoteDataSource remoteDataSource;

  CommentRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  TaskEither<Failure, List<CommentModel>> getAll({required int publicationId}) {
    return TaskEither.tryCatch(
      () async {
        return await remoteDataSource.getPublicationComments(publicationId: publicationId);
      },
      (error, stackTrace) {
        return UnknownFailure();
      },
    );
  }

  @override
  TaskEither<Failure, CommentModel> create({
    required int publicationId,
    required String content,
  }) {
    return TaskEither.tryCatch(
      () async {
        return await remoteDataSource.postComment(
          publicationId: publicationId,
          content: content,
        );
      },
      (error, stackTrace) {
        return UnknownFailure();
      },
    );
  }
}
