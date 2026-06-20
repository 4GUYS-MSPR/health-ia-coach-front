import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource remoteDatasource;

  ProfileRepositoryImpl({
    required this.remoteDatasource,
  });

  @override
  TaskEither<Failure, Profile> getProfile() {
    return TaskEither<Failure, ProfileModel>.tryCatch(
      () => remoteDatasource.fetchCurrentProfile(),
      (error, stackTrace) => UnknownFailure(debugMessage: error.toString()),
    ).map((model) => model as Profile);
  }

  @override
  TaskEither<Failure, Profile> updateAvatar({required PlatformFile file}) {
    return TaskEither<Failure, ProfileModel>.tryCatch(
      () => remoteDatasource.updateAvatar(file: file),
      (error, stackTrace) => UnknownFailure(debugMessage: error.toString()),
    ).map((model) => model as Profile);
  }

  @override
  TaskEither<Failure, Profile> updateProfile({
    String? username,
    String? firstname,
    String? lastname,
    int? age,
    int? gender,
    double? bmi,
    double? fatPercentage,
    double? height,
    double? weight,
    int? workoutFrequency,
    int? level,
  }) {
    return TaskEither<Failure, ProfileModel>.tryCatch(
      () => remoteDatasource.updateProfile(
        username: username,
        firstname: firstname,
        lastname: lastname,
        age: age,
        gender: gender,
        bmi: bmi,
        fatPercentage: fatPercentage,
        height: height,
        weight: weight,
        workoutFrequency: workoutFrequency,
        level: level,
      ),
      (error, stackTrace) => UnknownFailure(debugMessage: error.toString()),
    ).map((model) => model as Profile);
  }
}
