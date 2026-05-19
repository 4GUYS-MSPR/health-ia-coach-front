import 'package:fpdart/fpdart.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../errors/failure.dart';
import '../../data/models/publication_model.dart';
import '../repositories/publication_repository.dart';

class GetPublicationsUsecase implements UseCase<List<PublicationModel>, NoParams> {
  final PublicationRepository repository;

  GetPublicationsUsecase(this.repository);

  @override
  Future<Either<Failure, List<PublicationModel>>> call(NoParams params) async {
    return await repository.getPublications();
  }
}
