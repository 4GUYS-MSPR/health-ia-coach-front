import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, bool>> register({
    required String username,
    required String password,
    required String structureCode,
  });

  Future<Either<Failure, bool>> login({required String username, required String password});

  Future<Either<Failure, UserModel>> getCurrentUser();

  Future<Either<Failure, UserModel>> updateAvatarRepo({required PlatformFile file});

}
