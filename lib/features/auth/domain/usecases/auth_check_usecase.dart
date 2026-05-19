import 'package:fpdart/fpdart.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../errors/failure.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class GetUser implements UseCase<UserModel, NoParams> {
  final AuthRepository repository;
  GetUser(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}
