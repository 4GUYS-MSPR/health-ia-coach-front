import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/logging/logger_mixin.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class LogoutUsecase with LoggerMixin implements Usecase<Unit, NoParams> {
  final AuthRepository repository;

  LogoutUsecase({
    required this.repository,
  });

  @override
  String get loggerName => 'Auth.Domain.Usecases.LogoutUsecase';

  @override
  TaskEither<Failure, Unit> call([NoParams? params]) {
    logger.fine('Logout requested');

    return repository.logout();
  }
}
