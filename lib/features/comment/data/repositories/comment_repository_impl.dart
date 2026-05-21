import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/comment/data/datasources/comment_remote_datasource.dart';
import 'package:health_ia_care/features/comment/data/models/comment_model.dart';
import 'package:health_ia_care/features/comment/domain/repositories/comment_repository.dart';

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
}
