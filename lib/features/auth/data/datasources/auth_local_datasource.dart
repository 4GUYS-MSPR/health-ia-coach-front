import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract interface class AuthLocalDataSource {
  Future<void> storeAccessToken (String accessToken);
  Future<String?> getToken(String _storeAccessToken);
}


class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const _storeAccessToken = 'STORE_ACCESS_TOKEN';

  final FlutterSecureStorage secureStorage;
  AuthLocalDataSourceImpl({required this.secureStorage  });

  @override
  Future<void> storeAccessToken(String accessToken) async {
    try{
      await secureStorage.write(key: _storeAccessToken, value: accessToken);

    } catch (e){
      print(e);
    }
  }

  @override
  Future<String?> getToken(String _storeAccessToken) async {
    try{
      String? token = await secureStorage.read(key:_storeAccessToken); 
      return token;
    }catch (e){
      print(e);
    }

    }
}
