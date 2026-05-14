import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';

abstract interface class ProfileRepository{
  Future<Either<Failure, UserModel>> updateUserProfile({
    required String username,
    required String firstname,
    required String lastname
  });

}