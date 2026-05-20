import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';
import 'package:health_ia_care/features/auth/domain/repositories/auth_repository.dart';

class UpdateAvatarParams {
  final PlatformFile file;
  UpdateAvatarParams({required this.file});
}

class UpdateAvatar implements UseCase<UserModel, UpdateAvatarParams> {
  final AuthRepository repository;
  UpdateAvatar(this.repository);

  @override
  Future<Either<Failure, UserModel>> call(UpdateAvatarParams params) async {
    return await repository.updateAvatarRepo(file: params.file);
  }
}
