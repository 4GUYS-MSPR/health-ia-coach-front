import 'package:dio/dio.dart';
import 'package:health_ia_care/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';

class ProfileRemoteDatasource {
  final AuthLocalDataSource localDataSource;
  final String baseUrl;
  final Dio dio;

  ProfileRemoteDatasource({required this.localDataSource, required this.baseUrl, required this.dio});

  Future<UserModel?> updateUserProfile({
    required String username,
    required String firstname,
    required String lastname,
    required int? id,
    required String? token
    }) async {
      try {
        final response = await dio.patch(
          '$baseUrl/user/$id/',
          data: {'username' : username, 'first_name': firstname, 'last_name': lastname},
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          );

        if (response.statusCode == 200) {
          return UserModel.fromMap(response.data);
      }

      } on DioException catch (e){
        // ignore: avoid_print
        print(e);
      }
     return null;
    }


}