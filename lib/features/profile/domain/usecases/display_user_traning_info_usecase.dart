import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/profile/data/models/member_model.dart';
import 'package:health_ia_care/features/profile/domain/repositories/profile_repository.dart';

class DisplayUserTrainingUsecase implements UseCase<MemberModel, NoParams>{
  final ProfileRepository repository;

  DisplayUserTrainingUsecase(this.repository);

  @override
  Future<Either<Failure, MemberModel>> call(NoParams params) async {
    return await repository.getMemberStats();
  }

}