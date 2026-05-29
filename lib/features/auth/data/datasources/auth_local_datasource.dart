import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class AuthLocalDataSource {
  Future<void> storeAccessToken(String accessToken);
  Future<void> storeRefreshToken(String refreshToken);
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<void> logout();
  Future<String?> getUserId();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _storeAccessToken = 'STORE_ACCESS_TOKEN';
  static const _storeRefreshToken = 'STORE_REFRESH_TOKEN';
  static const _storeUserId = 'STORE_USER_ID';


  final FlutterSecureStorage secureStorage;
  AuthLocalDataSourceImpl({required this.secureStorage});

  @override
  Future<void> storeAccessToken(String accessToken) async {
    try {
      await secureStorage.write(key: _storeAccessToken, value: accessToken);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Future<void> storeRefreshToken(String refreshToken) async {
    try {
      await secureStorage.write(key: _storeRefreshToken, value: refreshToken);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Future<String?> getToken() async {
    return await get(key: _storeAccessToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await get(key: _storeRefreshToken);
  }

  Future<String?> get({required String key}) async {
    try {
      String? token = await secureStorage.read(key: key);
      return token;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    try {
      await secureStorage.deleteAll();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Future<String?> getUserId() async {
    return await get(key: _storeUserId);
  }
}
