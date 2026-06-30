import 'package:dio/dio.dart';

import '../../../../core/logging/logger_mixin.dart';
import '../models/auth_session_model.dart';

abstract interface class AuthRemoteDatasource {
  Future<AuthSessionModel> login({
    required String username,
    required String password,
  });

  Future<void> logout();

  Future<void> register({
    required String username,
    required String password,
    required String structureCode,
  });
}

class AuthRemoteDatasourceImpl with LoggerMixin implements AuthRemoteDatasource {
  final Dio dio;

  AuthRemoteDatasourceImpl({
    required this.dio,
  });

  @override
  String get loggerName => 'Auth.Data.Datasources.AuthRemoteDatasource';

  @override
  Future<AuthSessionModel> login({
    required String username,
    required String password,
  }) async {
    final response = await dio.post(
      '/api/token/',
      data: {'username': username, 'password': password},
    );

    return AuthSessionModel.fromMap(response.data);
  }

  @override
  Future<void> logout() async {
    await dio.post(
      '/api/token/logout/',
    );
  }

  @override
  Future<void> register({
    required String username,
    required String password,
    required String structureCode,
  }) async {
    await dio.post(
      '/api/user/',
      data: {
        'username': username,
        'password': password,
        'structure_code': structureCode,
      },
    );
  }
}
