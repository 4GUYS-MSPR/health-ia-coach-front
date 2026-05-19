import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/member_model.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, UserModel>> updateUserProfile({
    required String username,
    required String firstname,
    required String lastname,
  });

  Future<Either<Failure, MemberModel>> updateMemberProfile({
    required int age,
    required double bmi,
    required double fatPercentage,
    required double height,
    required double weight,
    required int workoutFrequency,
    required int gender,
    required int level,
    required int subscription,
  });

  Future<Either<Failure, MemberModel>> getMemberStats();
}
