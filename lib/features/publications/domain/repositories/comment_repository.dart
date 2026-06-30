import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/comment_model.dart';

abstract interface class CommentRepository {
  TaskEither<Failure, CommentModel> create({
    required int publicationId,
    required String content,
  });

  TaskEither<Failure, List<CommentModel>> getAll({
    required int publicationId,
  });
}
