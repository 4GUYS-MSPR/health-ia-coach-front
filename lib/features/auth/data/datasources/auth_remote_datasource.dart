import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../errors/failure.dart';
import '../../../profile/data/datasources/profile_local_datasource.dart';
import '../models/user_model.dart';
import 'auth_local_datasource.dart';

class AuthRemoteDataSource {
  final Dio dio;
  final AuthLocalDataSource localDataSource;
  final ProfileLocalDatasource profileLocalDatasource;

  AuthRemoteDataSource({
    required this.dio,
    required this.localDataSource,
    required this.profileLocalDatasource,
  });

  Future<bool> register({
    required String username,
    required String password,
    required String structureCode,
  }) async {
    try {
      final response = await dio.post(
        '/api/user/',
        data: {"username": username, "password": password, "client": structureCode},
      );

      return response.statusCode == 201;
    } on DioException catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return false;
  }

  Future<bool> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/api/token/',
        data: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        await localDataSource.storeAccessToken(response.data['access']);
        await localDataSource.storeRefreshToken(response.data['refresh']);
        return true;
      }
    } on DioException catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return false;
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final response = await dio.get('/api/user/me');

      if (response.statusCode == 200) {
        await profileLocalDatasource.storeMemberId(response.data['member_id']);
        await profileLocalDatasource.storeUserId(response.data['id']);
        return UserModel.fromMap(response.data);
      }
    } on DioException catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }

  Future<bool> logout() async {
    try {
      final token = await localDataSource.getToken();
      final refresh = await localDataSource.getRefreshToken();

      if (token == null || token.isEmpty || refresh == null || refresh.isEmpty) {
        return false;
      }

      final response = await dio.post(
        '/api/token/logout/',
        data: {'refresh': refresh},
      );

      if (response.statusCode == 205) {
        await localDataSource.logout();
        return true;
      }
    } on DioException catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return false;
  }

  Future<UserModel> updateAvatarData({required PlatformFile file, required int id}) async {
    MultipartFile multiFile;

    if (file.bytes != null) {
      multiFile = MultipartFile.fromBytes(file.bytes!, filename: file.name);
    } else if (file.path != null) {
      final ioFile = io.File(file.path!);
      final bytes = await ioFile.readAsBytes();

      multiFile = MultipartFile.fromBytes(bytes, filename: file.name);
    } else {
      throw Exception('Fichier invalide');
    }

    FormData formData = FormData.fromMap({
      'avatar': multiFile,
    });

    final response = await dio.patch(
      '/api/user/$id/avatar/',
      data: formData,
    );

    if (response.statusCode == 200) {
      return UserModel.fromMap(response.data);
    }

    throw ServerFailure(message: '${response.statusCode}');
  }
}
