import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication_type.dart';

abstract interface class PublicationRepository {
  Future<Either<Failure, Publication>> createPublication({
    required PublicationType type,
    required String description,
    required PlatformFile media,
  });
}