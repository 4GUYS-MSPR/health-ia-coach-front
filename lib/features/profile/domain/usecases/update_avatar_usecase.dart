import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/logging/logger_mixin.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateAvatarParams extends Equatable {
  final PlatformFile file;

  const UpdateAvatarParams({
    required this.file,
  });

  @override
  List<Object?> get props => [
    file,
  ];
}

class UpdateAvatarUsecase with LoggerMixin implements Usecase<Profile, UpdateAvatarParams> {
  final ProfileRepository repository;

  UpdateAvatarUsecase({
    required this.repository,
  });

  @override
  String get loggerName => 'Profile.Domain.Usecases.UpdateAvatarUsecase';

  @override
  TaskEither<Failure, Profile> call(UpdateAvatarParams params) {
    logger.fine('Update avatar requested');

    return repository.updateAvatar(
      file: params.file,
    );
  }
}
