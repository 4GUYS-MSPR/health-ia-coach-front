import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../errors/failure.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

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
