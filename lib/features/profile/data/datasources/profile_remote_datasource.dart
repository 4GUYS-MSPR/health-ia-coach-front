import 'package:dio/dio.dart';
import 'package:health_ia_care/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';
import 'package:health_ia_care/features/profile/data/models/member_model.dart';

class ProfileRemoteDatasource {
  final AuthLocalDataSource localDataSource;
  final Dio dio;

  ProfileRemoteDatasource({required this.localDataSource, required this.dio});

  Future<UserModel?> updateUserProfile({
    required String username,
    required String firstname,
    required String lastname,
    required int? id,
    }) async {
      try {
        final response = await dio.patch(
          '/api/user/$id/',
          data: {'username' : username, 'first_name': firstname, 'last_name': lastname});

        if (response.statusCode == 200) {
          return UserModel.fromMap(response.data);
      }

      } on DioException catch (e){
        // ignore: avoid_print
        print(e);
      }
     return null;
  }

  Future<MemberModel?> updateMemberProfile({
    required int age,
    required double bmi,
    required double fatPercentage,
    required double height,
    required double weight,
    required int workoutFrequency,
    required int gender,
    required int level,
    required int subscription,
    required int? id,
    }) async {
      try {
        print({
            'age': age,
            'bmi': bmi,
            'fat_percentage': fatPercentage,
            'height': height,
            'weight': weight,
            'workout_frequency': workoutFrequency,
            'gender': gender,
            'level': level,
            'subscription': subscription
            });
        final response = await dio.patch(
          '/api/member/$id/',
          data: {
            'age': age,
            'bmi': bmi,
            'fat_percentage': fatPercentage,
            'height': height,
            'weight': weight,
            'workout_frequency': workoutFrequency,
            'gender': gender,
            'level': level,
            'subscription': subscription
            });
          

        if (response.statusCode == 200) {
          return MemberModel.fromMap(response.data);
      }

      } on DioException catch (e){
        // ignore: avoid_print
        print(e);
      }
     return null;
  }

  Future<MemberModel?> getMemberStats({
    required int? id,
  }) async {
    try{
      final response = await dio.get('/api/member/$id/');

      if (response.statusCode == 200){
        return MemberModel.fromMap(response.data);
      }
    } on DioException catch (e){
      // ignore: avoid_print
      print (e);
    }
    return null;
  }
  
}