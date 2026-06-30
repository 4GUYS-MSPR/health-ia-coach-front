import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/publication_model.dart';
import '../entities/publication.dart';

abstract interface class PublicationRepository {
  TaskEither<Failure, Publication> createPublication({
    required PublicationType type,
    required String description,
    required PlatformFile media,
  });

  TaskEither<Failure, List<PublicationModel>> getPublications();

  TaskEither<Failure, PublicationModel> setLiked({
    required bool liked,
    required int id,
  });
}
