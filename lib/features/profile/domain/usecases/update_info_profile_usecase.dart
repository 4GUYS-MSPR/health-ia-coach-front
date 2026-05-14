import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';
import 'package:health_ia_care/features/profile/domain/repositories/profile_repository.dart';

class UpdateParams{
  final String username;
  final String firstname;
  final String lastname;

  const UpdateParams({required this.username, required this.firstname, required this.lastname});
}

class UpdateInfoProfileUsecase implements UseCase<UserModel, UpdateParams>{
  final ProfileRepository repository;

  UpdateInfoProfileUsecase(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(UpdateParams params) async {
    return await repository.updateUserProfile(
      username: params.username, firstname: params.firstname, lastname: params.lastname 
    );
  }


}