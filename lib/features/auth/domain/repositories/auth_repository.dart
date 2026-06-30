import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/auth_session.dart';

abstract interface class AuthRepository {
  TaskEither<Failure, AuthSession?> getSession();

  TaskEither<Failure, AuthSession> login({
    required String username,
    required String password,
  });

  TaskEither<Failure, Unit> logout();

  TaskEither<Failure, AuthSession> register({
    required String username,
    required String password,
    required String structureCode,
  });
}
