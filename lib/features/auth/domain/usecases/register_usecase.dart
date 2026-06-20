import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/logging/logger_mixin.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class RegisterUsecaseParams extends Equatable {
  final String username;
  final String password;
  final String structureCode;

  const RegisterUsecaseParams({
    required this.username,
    required this.password,
    required this.structureCode,
  });

  @override
  List<Object?> get props => [
    username,
    password,
    structureCode,
  ];
}

class RegisterUsecase with LoggerMixin implements Usecase<AuthSession, RegisterUsecaseParams> {
  final AuthRepository repository;

  RegisterUsecase({
    required this.repository,
  });

  @override
  String get loggerName => 'Auth.Domain.Usecases.RegisterUsecase';

  @override
  TaskEither<Failure, AuthSession> call(RegisterUsecaseParams params) {
    logger.fine('Register requested');

    return repository.register(
      username: params.username,
      password: params.password,
      structureCode: params.structureCode,
    );
  }
}
