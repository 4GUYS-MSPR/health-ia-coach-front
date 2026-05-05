import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/features/auth/domain/repositories/auth_repository.dart';
import 'package:health_ia_care/errors/failure.dart';

class AuthCheckUseCase implements UseCase<bool, NoParams> {
  final AuthRepository repository;
  AuthCheckUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.checkAuthStatus();
  }
}