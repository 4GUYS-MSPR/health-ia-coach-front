import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/comment/data/models/comment_model.dart';
import 'package:health_ia_care/features/comment/domain/repositories/comment_repository.dart';

class CommentGetAll implements UseCase<List<CommentModel>, CommentGetAllParams> {
  final CommentRepository repository;

  CommentGetAll(this.repository);

  @override
  Future<Either<Failure, List<CommentModel>>> call(CommentGetAllParams params) async {
    return await repository.getAll(publicationId: params.publicationId);
  }
}

class CommentGetAllParams {
  final int publicationId;

  CommentGetAllParams({
    required this.publicationId,
  });
}
