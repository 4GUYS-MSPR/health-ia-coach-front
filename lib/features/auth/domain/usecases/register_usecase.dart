import 'package:fpdart/fpdart.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../errors/failure.dart';
import '../repositories/auth_repository.dart';

class RegisterParams {
  final String username;
  final String password;
  final String structureCode;
  const RegisterParams({
    required this.username,
    required this.password,
    required this.structureCode,
  });
}

class RegisterUseCase implements UseCase<bool, RegisterParams> {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(RegisterParams params) async {
    return await repository.register(
      username: params.username,
      password: params.password,
      structureCode: params.structureCode,
    );
  }
}
