import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/comment_model.dart';
import '../repositories/comment_repository.dart';

class CommentGetAll implements Usecase<List<CommentModel>, CommentGetAllParams> {
  final CommentRepository repository;

  CommentGetAll({
    required this.repository,
  });

  @override
  TaskEither<Failure, List<CommentModel>> call(CommentGetAllParams params) {
    return repository.getAll(publicationId: params.publicationId);
  }
}

class CommentGetAllParams {
  final int publicationId;

  CommentGetAllParams({
    required this.publicationId,
  });
}
