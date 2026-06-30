import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/publication.dart';
import '../../domain/repositories/publication_repository.dart';
import '../datasources/publications_remote_datasource.dart';
import '../models/publication_model.dart';

class PublicationRepositoryImpl implements PublicationRepository {
  final PublicationsRemoteDataSource remoteDataSource;

  PublicationRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  TaskEither<Failure, Publication> createPublication({
    required PublicationType type,
    required String description,
    required PlatformFile media,
  }) {
    return TaskEither.tryCatch(
      () async {
        return await remoteDataSource.createPublication(
          type: type.value,
          description: description,
          media: media,
        );
      },
      (error, stackTrace) {
        return const UnknownFailure();
      },
    );
  }

  @override
  TaskEither<Failure, List<PublicationModel>> getPublications() {
    return TaskEither.tryCatch(
      () async {
        return await remoteDataSource.getAllPublications();
      },
      (error, stackTrace) {
        return const UnknownFailure();
      },
    );
  }

  @override
  TaskEither<Failure, PublicationModel> setLiked({
    required bool liked,
    required int id,
  }) {
    return TaskEither.tryCatch(
      () async {
        return await remoteDataSource.setLiked(liked: liked, id: id);
      },
      (error, stackTrace) {
        return const UnknownFailure();
      },
    );
  }
}
