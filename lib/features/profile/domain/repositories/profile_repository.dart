import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/profile.dart';

abstract interface class ProfileRepository {
  TaskEither<Failure, Profile> getProfile();

  TaskEither<Failure, Profile> updateAvatar({
    required PlatformFile file,
  });

  TaskEither<Failure, Profile> updateProfile({
    required String? username,
    required String? firstname,
    required String? lastname,
    required int? age,
    required int? gender,
    required double? bmi,
    required double? fatPercentage,
    required double? height,
    required double? weight,
    required int? workoutFrequency,
    required int? level,
  });
}
