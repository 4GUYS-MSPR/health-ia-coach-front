import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ProfileLocalDatasource {
  Future<void> storeUserId(int userId);
  Future<String?> getUserId();
  Future<void> storeMemberId(int memberId);
  Future<String?> getMemberId();
}

class ProfileLocalDatasourceImpl implements ProfileLocalDatasource {
  static const _storeMemberId = 'STORE_MEMBER_ID';
  static const _storeUserId = 'STORE_USER_ID';

  final FlutterSecureStorage secureStorage;

  ProfileLocalDatasourceImpl({required this.secureStorage});

  @override
  Future<void> storeUserId(int userId) async {
    try {
      await secureStorage.write(key: _storeUserId, value: userId.toString());
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Future<String?> getUserId() async {
    return await get(key: _storeUserId);
  }

  @override
  Future<void> storeMemberId(int memberId) async {
    try {
      await secureStorage.write(key: _storeMemberId, value: memberId.toString());
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Future<String?> getMemberId() async {
    return await get(key: _storeMemberId);
  }

  Future<String?> get({required String key}) async {
    try {
      String? id = await secureStorage.read(key: key);
      return id;
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return null;
  }
}
