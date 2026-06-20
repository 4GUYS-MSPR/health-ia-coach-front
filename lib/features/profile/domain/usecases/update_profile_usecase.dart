import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/logging/logger_mixin.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileParams extends Equatable {
  final String? username;
  final String? firstname;
  final String? lastname;
  final int? age;
  final int? gender;
  final double? bmi;
  final double? fatPercentage;
  final double? height;
  final double? weight;
  final int? workoutFrequency;
  final int? level;

  const UpdateProfileParams({
    this.age,
    this.bmi,
    this.fatPercentage,
    this.height,
    this.weight,
    this.workoutFrequency,
    this.gender,
    this.level,
    this.username,
    this.firstname,
    this.lastname,
  });

  @override
  List<Object?> get props => [
    username,
    firstname,
    lastname,
    age,
    gender,
    bmi,
    fatPercentage,
    height,
    weight,
    workoutFrequency,
    level,
  ];
}

class UpdateProfileUsecase with LoggerMixin implements Usecase<Profile, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateProfileUsecase({
    required this.repository,
  });

  @override
  String get loggerName => 'Profile.Domain.Usecases.UpdateProfileUsecase';

  @override
  TaskEither<Failure, Profile> call(UpdateProfileParams params) {
    logger.fine('Update profile requested');

    return repository.updateProfile(
      age: params.age,
      bmi: params.bmi,
      fatPercentage: params.fatPercentage,
      height: params.height,
      weight: params.weight,
      workoutFrequency: params.workoutFrequency,
      gender: params.gender,
      level: params.level,
      username: params.username,
      firstname: params.firstname,
      lastname: params.lastname,
    );
  }
}
