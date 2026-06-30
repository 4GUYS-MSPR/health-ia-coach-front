import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/logging/logger_mixin.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class GetSessionUsecase with LoggerMixin implements Usecase<AuthSession?, NoParams> {
  final AuthRepository repository;

  GetSessionUsecase({
    required this.repository,
  });

  @override
  String get loggerName => 'Auth.Domain.Usecases.GetCurrentUserUsecase';

  @override
  TaskEither<Failure, AuthSession?> call([NoParams? params]) {
    logger.fine('Get current user requested');

    return repository.getSession();
  }
}
