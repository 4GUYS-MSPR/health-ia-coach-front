import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/logging/logger_mixin.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetProfileUsecase with LoggerMixin implements Usecase<Profile, NoParams> {
  final ProfileRepository repository;

  GetProfileUsecase({
    required this.repository,
  });

  @override
  String get loggerName => 'Profile.Domain.Usecases.GetProfileUsecase';

  @override
  TaskEither<Failure, Profile> call([NoParams? params]) {
    logger.fine('Get profile requested');

    return repository.getProfile();
  }
}
