// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/publication_model.dart';
import '../repositories/publication_repository.dart';

class GetPublicationsUsecase implements Usecase<List<PublicationModel>, NoParams> {
  final PublicationRepository repository;

  GetPublicationsUsecase({
    required this.repository,
  });

  @override
  TaskEither<Failure, List<PublicationModel>> call([NoParams? params]) {
    return repository.getPublications();
  }
}
