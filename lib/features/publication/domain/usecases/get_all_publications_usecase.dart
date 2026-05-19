import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication.dart';
import 'package:health_ia_care/features/publication/domain/repositories/publication_repository.dart';

class GetPublicationsUsecase implements UseCase<List<Publication>, NoParams> {
  final PublicationRepository repository;

  GetPublicationsUsecase(this.repository);

  @override
  Future<Either<Failure, List<Publication>>> call(NoParams params) async {
    return await repository.getPublications();
  }
}