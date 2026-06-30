import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../models/profile_model.dart';

abstract class ProfileRemoteDatasource {
  Future<ProfileModel> fetchCurrentProfile();

  Future<ProfileModel> updateProfile({
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
  });

  Future<ProfileModel> updateAvatar({
    required PlatformFile file,
  });
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final Dio dio;

  ProfileRemoteDatasourceImpl({required this.dio});

  @override
  Future<ProfileModel> fetchCurrentProfile() async {
    // 1. Appel User
    final userRes = await dio.get('/api/user/me/');
    // 2. Appel Member avec le member_id récupéré
    final memberRes = await dio.get('/api/member/${userRes.data['member_id']}/');

    // 3. Fusion des JSON
    final mergedData = {
      ...(userRes.data as Map<String, dynamic>),
      ...(memberRes.data as Map<String, dynamic>),
    };

    return ProfileModel.fromMap(mergedData);
  }

  // Ajoute cette logique dans ta classe ProfileRemoteDatasourceImpl
  @override
  Future<ProfileModel> updateProfile({
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
  }) async {
    // 1. Récupération de l'utilisateur actuel pour avoir les IDs
    final currentUserRes = await dio.get('/api/user/me/');
    final userId = currentUserRes.data['id'];
    final memberId = currentUserRes.data['member_id'];

    // 2. Mise à jour de l'identité (User)
    final userPayload = {
      'username': ?username,
      'first_name': ?firstname,
      'last_name': ?lastname,
    };
    
    if (userPayload.isNotEmpty) {
      await dio.patch('/api/user/$userId/', data: userPayload);
    }

    // 3. Mise à jour des stats (Member)
    final memberPayload = {
      'age': ?age,
      'gender': ?gender,
      'bmi': ?bmi,
      'fat_percentage': ?fatPercentage,
      'height': ?height,
      'weight': ?weight,
      'workout_frequency': ?workoutFrequency,
      'level': ?level,
    };
    
    if (memberPayload.isNotEmpty) {
      await dio.patch('/api/member/$memberId/', data: memberPayload);
    }

    // 4. Retourne le modèle mis à jour complet
    return fetchCurrentProfile();
  }

  @override
  Future<ProfileModel> updateAvatar({required PlatformFile file}) async {
    // 1. Récupération de l'utilisateur actuel pour avoir l'ID
    final currentUserRes = await dio.get('/api/user/me/');
    final userId = currentUserRes.data['id'];

    // 2. Préparation du fichier (compatible Web et Mobile)
    MultipartFile multipartFile;
    if (file.bytes != null) {
      multipartFile = MultipartFile.fromBytes(
        file.bytes!,
        filename: file.name,
      );
    } else {
      multipartFile = await MultipartFile.fromFile(
        file.path!,
        filename: file.name,
      );
    }

    final formData = FormData.fromMap({
      'avatar': multipartFile,
    });

    // 3. Upload de l'avatar via multipart/form-data
    await dio.patch('/api/user/$userId/avatar/', data: formData);

    // 4. Retourner le profil mis à jour
    return fetchCurrentProfile();
  }
}
