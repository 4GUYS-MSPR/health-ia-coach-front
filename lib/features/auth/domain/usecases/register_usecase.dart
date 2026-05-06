import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/features/auth/domain/repositories/auth_repository.dart';
import 'package:health_ia_care/errors/failure.dart';

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
