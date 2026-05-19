import 'package:fpdart/fpdart.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../errors/failure.dart';
import '../../data/models/member_model.dart';
import '../repositories/profile_repository.dart';

class DisplayUserTrainingUsecase implements UseCase<MemberModel, NoParams> {
  final ProfileRepository repository;

  DisplayUserTrainingUsecase(this.repository);

  @override
  Future<Either<Failure, MemberModel>> call(NoParams params) async {
    return await repository.getMemberStats();
  }
}
