import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/comment/data/models/comment_model.dart';
import 'package:health_ia_care/features/comment/domain/repositories/comment_repository.dart';

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
