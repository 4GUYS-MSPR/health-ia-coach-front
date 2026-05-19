import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../errors/failure.dart';
import '../../data/models/publication_model.dart';
import '../entities/publication.dart';
import '../entities/publication_type.dart';

abstract interface class PublicationRepository {
  Future<Either<Failure, Publication>> createPublication({
    required PublicationType type,
    required String description,
    required PlatformFile media,
  });

  Future<Either<Failure, List<PublicationModel>>> getPublications();

  Future<Either<Failure, PublicationModel>> setLiked({
    required bool liked,
    required int id,
  });
}
