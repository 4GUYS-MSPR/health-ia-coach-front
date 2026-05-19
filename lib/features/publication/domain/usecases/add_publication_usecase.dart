import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../errors/failure.dart';
import '../entities/publication.dart';
import '../entities/publication_type.dart';
import '../repositories/publication_repository.dart';

class AddPublicationParams {
  final PublicationType type;
  final String description;
  final PlatformFile media;

  AddPublicationParams({
    required this.type,
    required this.description,
    required this.media,
  });
}

class AddPublicationUsecase implements UseCase<Publication, AddPublicationParams> {
  final PublicationRepository repository;

  AddPublicationUsecase(this.repository);

  @override
  Future<Either<Failure, Publication>> call(AddPublicationParams params) async {
    return await repository.createPublication(
      type: params.type,
      description: params.description,
      media: params.media,
    );
  }
}
