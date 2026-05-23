import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/comment/data/models/comment_model.dart';

abstract interface class CommentRepository {
  Future<Either<Failure, List<CommentModel>>> getAll({
    required int publicationId,
  });

  Future<Either<Failure, CommentModel>> create({
    required int publicationId,
    required String content,
  });
}
