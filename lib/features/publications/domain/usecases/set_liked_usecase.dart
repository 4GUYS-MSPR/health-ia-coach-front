import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/publication_model.dart';
import '../repositories/publication_repository.dart';

class SetLikedUsecase implements Usecase<PublicationModel, SetLikedParams> {
  final PublicationRepository repository;

  SetLikedUsecase({
    required this.repository,
  });

  @override
  TaskEither<Failure, PublicationModel> call(SetLikedParams params) {
    return repository.setLiked(
      liked: params.liked,
      id: params.id,
    );
  }
}

class SetLikedParams {
  final bool liked;
  final int id;

  const SetLikedParams({
    required this.liked,
    required this.id,
  });
}
