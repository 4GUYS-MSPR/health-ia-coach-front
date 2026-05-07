import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';
import 'package:health_ia_care/features/auth/domain/repositories/auth_repository.dart';
import 'package:health_ia_care/errors/failure.dart';

class GetUser implements UseCase<UserModel?, NoParams> {
  final AuthRepository repository;
  GetUser(this.repository);

  @override
  Future<Either<Failure, UserModel?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
