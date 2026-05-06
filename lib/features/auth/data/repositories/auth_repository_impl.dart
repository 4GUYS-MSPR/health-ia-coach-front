import 'package:health_ia_care/errors/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:health_ia_care/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource datasource;

  AuthRepositoryImpl(this.datasource);

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
  Future<Either<Failure, bool>> checkAuthStatus() async {
    try {
      return Right(await datasource.checkAuthStatus());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
