import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/logging/logger_mixin.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_session.dart';
import '../errors/auth_failures.dart';
import '../repositories/auth_repository.dart';

class LoginUsecaseParams extends Equatable {
  final String username;
  final String password;

  const LoginUsecaseParams({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [
    username,
    password,
  ];
}

class LoginUsecase with LoggerMixin implements Usecase<AuthSession, LoginUsecaseParams> {
  final AuthRepository repository;

  LoginUsecase({
    required this.repository,
  });

  @override
  String get loggerName => 'Auth.Domain.Usecases.LoginWithPasswordUsecase';

  @override
  TaskEither<Failure, AuthSession> call(LoginUsecaseParams params) {
    logger.fine('Sign-in with password requested');

    if (params.username.isEmpty) {
      logger.warning('Login validation failed: empty username');
      return TaskEither.left(const EmptyPasswordFailure());
    }

    if (params.password.isEmpty) {
      logger.warning('Login validation failed: empty password');
      return TaskEither.left(const EmptyPasswordFailure());
    }

    return repository.login(
      username: params.username,
      password: params.password,
    );
  }
}
