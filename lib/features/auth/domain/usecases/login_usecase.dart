import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/features/auth/domain/repositories/auth_repository.dart';
import 'package:health_ia_care/errors/failure.dart';

class LoginParams {
  final String username;
  final String password;
  const LoginParams({required this.username, required this.password});
}

class LoginUseCase implements UseCase<bool, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(LoginParams params) async {
    return await repository.login(username: params.username, password: params.password);
  }
}
