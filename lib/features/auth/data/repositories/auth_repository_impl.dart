import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../errors/failure.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource datasource;
  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl(this.datasource, this.authLocalDataSource);

  @override
  Future<Either<Failure, bool>> register({
    required String username,
    required String password,
    required String structureCode,
  }) async {
    try {
      return Right(
        await datasource.register(
          password: password,
          username: username,
          structureCode: structureCode,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> login({required String username, required String password}) async {
    try {
      return Right(
        await datasource.login(
          username: username,
          password: password,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    try {
      final user = await datasource.getCurrentUser();
      if (user == null) {
        return Left(ServerFailure(message: "Utilisateur non trouvé ou session expirée"));
      }
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      return Right(await datasource.logout());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateAvatarRepo({required PlatformFile file}) async {
    try {
      String? id = await authLocalDataSource.getUserId();

      if (id == null) {
        return Left(ServerFailure(message: "Session expirée ou ID introuvable"));
      }

      int convertedId = int.parse(id);
      return Right(await datasource.updateAvatarData(file: file, id: convertedId));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
