import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/publication/data/datasources/publication_remote_datasource.dart';
import 'package:health_ia_care/features/publication/data/models/publication_model.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication.dart';
import 'package:health_ia_care/features/publication/domain/entities/publication_type.dart';
import 'package:health_ia_care/features/publication/domain/repositories/publication_repository.dart';

class PublicationRepositoryImpl implements PublicationRepository {
  final PublicationRemoteDataSource remoteDataSource;

  PublicationRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Publication>> createPublication({
    required PublicationType type,
    required String description,
    required PlatformFile media,
  }) async {
    try {
      final result = await remoteDataSource.createPublication(
        type: type.value,
        description: description,
        media: media,
      );

      return right(result);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PublicationModel>>> getPublications() async {
    try {
      final publications = await remoteDataSource.getPublications();
      return right(publications);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PublicationModel>> setLiked({
    required bool liked,
    required int id,
  }) async {
    try {
      final publication = await remoteDataSource.setLiked(liked: liked, id: id);
      return right(publication);
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
