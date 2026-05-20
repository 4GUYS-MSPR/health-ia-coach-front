import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/publication/data/models/publication_model.dart';
import 'package:health_ia_care/features/publication/domain/repositories/publication_repository.dart';

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
