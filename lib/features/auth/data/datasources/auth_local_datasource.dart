import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/logging/logger_mixin.dart';
import '../../domain/entities/auth_session.dart';

abstract interface class AuthLocalDataSource {
  Future<void> storeAuthSession(AuthSession session);
  Future<void> storeAccessToken(String accessToken);
  Future<void> storeRefreshToken(String refreshToken);

  Future<AuthSession?> getAuthSession();
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();

  Future<void> clearSession();
}

class AuthLocalDataSourceImpl with LoggerMixin implements AuthLocalDataSource {
  static const _storeAccessToken = 'STORE_ACCESS_TOKEN';
  static const _storeRefreshToken = 'STORE_REFRESH_TOKEN';

  final FlutterSecureStorage secureStorage;

  AuthLocalDataSourceImpl({
    required this.secureStorage,
  });

  @override
  String get loggerName => 'Auth.Data.Datasources.AuthLocalDataSource';

  @override
  Future<void> storeAuthSession(AuthSession session) async {
    try {
      await secureStorage.write(key: _storeAccessToken, value: session.accessToken);
      await secureStorage.write(key: _storeRefreshToken, value: session.refreshToken);
      logger.finer('Auth session stored');
    } catch (e, stackTrace) {
      logger.severe('Failed to store auth session', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> storeAccessToken(String accessToken) async {
    try {
      await secureStorage.write(key: _storeAccessToken, value: accessToken);
      logger.finer('Access token stored successfully');
    } catch (e, stackTrace) {
      logger.severe('Failed to store access token', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> storeRefreshToken(String refreshToken) async {
    try {
      await secureStorage.write(key: _storeRefreshToken, value: refreshToken);
      logger.finer('Refresh token stored successfully');
    } catch (e, stackTrace) {
      logger.severe('Failed to store refresh token', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<AuthSession?> getAuthSession() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();

    if (accessToken != null && refreshToken != null) {
      return AuthSession(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
    } else {
      return null;
    }
  }

  @override
  Future<String?> getAccessToken() async {
    final token = await secureStorage.read(key: _storeAccessToken);
    logger.finer('Access token retrieved: ${token != null ? "found" : "null"}');
    return token;
  }

  @override
  Future<String?> getRefreshToken() async {
    final token = await secureStorage.read(key: _storeRefreshToken);
    logger.finer('Refresh token retrieved: ${token != null ? "found" : "null"}');
    return token;
  }

  @override
  Future<void> clearSession() async {
    try {
      await secureStorage.delete(key: _storeAccessToken);
      await secureStorage.delete(key: _storeRefreshToken);
      logger.finer('User session cleared');
    } catch (e, stackTrace) {
      logger.severe('Failed to clear session', e, stackTrace);
      rethrow;
    }
  }
}
