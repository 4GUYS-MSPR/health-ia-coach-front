import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/comment_model.dart';
import '../repositories/comment_repository.dart';

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
