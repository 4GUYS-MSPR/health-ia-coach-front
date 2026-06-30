import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/publication.dart';
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

class AddPublicationUsecase implements Usecase<Publication, AddPublicationParams> {
  final PublicationRepository repository;

  AddPublicationUsecase({
    required this.repository,
  });

  @override
  TaskEither<Failure, Publication> call(AddPublicationParams params) {
    return repository.createPublication(
      type: params.type,
      description: params.description,
      media: params.media,
    );
  }
}
