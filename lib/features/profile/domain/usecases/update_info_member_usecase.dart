import 'package:fpdart/fpdart.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/errors/failure.dart';
import '../../data/models/member_model.dart';
import '../repositories/profile_repository.dart';

class UpdateMemberParams {
  final int age;
  final double bmi;
  final double fatPercentage;
  final double height;
  final double weight;
  final int workoutFrequency;
  final int gender;
  final int level;
  final int subscription;

  UpdateMemberParams({
    required this.age,
    required this.bmi,
    required this.fatPercentage,
    required this.height,
    required this.weight,
    required this.workoutFrequency,
    required this.gender,
    required this.level,
    required this.subscription,
  });
}

class UpdateInfoMemberUsecase implements UseCase<MemberModel, UpdateMemberParams> {
  final ProfileRepository repository;

  UpdateInfoMemberUsecase(this.repository);

  @override
  Future<Either<Failure, MemberModel>> call(UpdateMemberParams params) async {
    return await repository.updateMemberProfile(
      age: params.age,
      bmi: params.bmi,
      fatPercentage: params.fatPercentage,
      height: params.height,
      weight: params.weight,
      workoutFrequency: params.workoutFrequency,
      gender: params.gender,
      level: params.level,
      subscription: params.subscription,
    );
  }
}
