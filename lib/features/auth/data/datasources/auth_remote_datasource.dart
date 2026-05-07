import 'package:dio/dio.dart';
import 'package:health_ia_care/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final Dio dio;
  final String baseUrl;
  final AuthLocalDataSource localDataSource;

  AuthRemoteDataSource({required this.dio, required this.baseUrl, required this.localDataSource});

  Future<bool> register({
    required String username,
    required String password,
    required String structureCode,
  }) async {
    try {
      final response = await dio.post(
        '$baseUrl/user/',
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
        '$baseUrl/token/',
        data: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        await localDataSource.storeAccessToken(response.data['access']);
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
      final token = await localDataSource.getToken();

      if (token == null || token.isEmpty) {
        return null;
      }

      final response = await dio.get(
        '$baseUrl/user/me',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

       if (response.statusCode == 200) {
        return UserModel.fromMap(response.data);
      }
    } on DioException catch (e) {
      // ignore: avoid_print
      print(e);
    }
      return null;
  }

  Future<void> logout()async {
    try{
      await localDataSource.logout();
    }catch (e){
      // ignore: avoid_print
      print(e);
    }
  }





}
