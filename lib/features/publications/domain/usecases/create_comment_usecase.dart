import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/comment_model.dart';
import '../repositories/comment_repository.dart';

class CommentCreate implements Usecase<CommentModel, CommentCreateParams> {
  final CommentRepository repository;

  CommentCreate({
    required this.repository,
  });

  @override
  TaskEither<Failure, CommentModel> call(CommentCreateParams params) {
    return repository.create(
      publicationId: params.publicationId,
      content: params.content,
    );
  }
}

class CommentCreateParams {
  final int publicationId;
  final String content;

  CommentCreateParams({
    required this.publicationId,
    required this.content,
  });
}
