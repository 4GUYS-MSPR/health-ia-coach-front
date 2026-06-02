import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/comment_model.dart';
import '../repositories/comment_repository.dart';

class CommentCreate implements UseCase<CommentModel, CommentCreateParams> {
  final CommentRepository repository;

  CommentCreate(this.repository);

  @override
  Future<Either<Failure, CommentModel>> call(CommentCreateParams params) async {
    return await repository.create(
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
