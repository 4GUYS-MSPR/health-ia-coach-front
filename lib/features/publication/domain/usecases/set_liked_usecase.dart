import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/publication_model.dart';
import '../repositories/publication_repository.dart';

class SetLikedUsecase implements UseCase<PublicationModel, SetLikedParams> {
  final PublicationRepository repository;

  SetLikedUsecase(this.repository);

  @override
  Future<Either<Failure, PublicationModel>> call(SetLikedParams params) async {
    return await repository.setLiked(
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
