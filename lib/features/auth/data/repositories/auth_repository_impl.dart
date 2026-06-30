import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/logging/logger_mixin.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/errors/auth_failures.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_session_model.dart';

class AuthRepositoryImpl with LoggerMixin implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDataSource localDatasource;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  TaskEither<Failure, AuthSessionModel> register({
    required String username,
    required String password,
    required String structureCode,
  }) {
    return TaskEither.tryCatch(
      () async {
        await remoteDatasource.register(
          username: username,
          password: password,
          structureCode: structureCode,
        );

        return await remoteDatasource.login(
          username: username,
          password: password,
        );
      },
      (error, stackTrace) {
        return UnknowAuthFailure();
      },
    );
  }

  @override
  TaskEither<Failure, AuthSessionModel> login({
    required String username,
    required String password,
  }) {
    return TaskEither.tryCatch(
      () async {
        final authSession = await remoteDatasource.login(
          username: username,
          password: password,
        );
        await localDatasource.storeAuthSession(authSession);

        return authSession;
      },
      (error, stackTrace) {
        logger.severe("Login failed", error, stackTrace);
        return UnknowAuthFailure();
      },
    );
  }

  @override
  TaskEither<Failure, Unit> logout() {
    return TaskEither.tryCatch(
      () async {
        try {
          await remoteDatasource.logout();
        } catch (e) {
          rethrow;
        } finally {
          await localDatasource.clearSession();
        }
        return unit;
      },
      (error, stackTrace) {
        return UnknowAuthFailure(
          debugMessage: error.toString(),
        );
      },
    );
  }

  @override
  TaskEither<Failure, AuthSession?> getSession() {
    return TaskEither.tryCatch(
      () async {
        return await localDatasource.getAuthSession();
      },
      (error, stackTrace) {
        return UnknownFailure();
      },
    );
  }
}
