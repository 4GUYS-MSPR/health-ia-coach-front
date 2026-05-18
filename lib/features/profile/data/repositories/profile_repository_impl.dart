import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:health_ia_care/features/profile/data/datasources/profile_local_datasource.dart';
import 'package:health_ia_care/features/profile/data/models/member_model.dart';

import 'package:health_ia_care/features/profile/domain/repositories/profile_repository.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';
import 'package:health_ia_care/errors/failure.dart';
import 'package:health_ia_care/features/profile/data/datasources/profile_remote_datasource.dart';

class ProfileRepositoryImpl implements ProfileRepository{
  final ProfileRemoteDatasource datasource;
  final ProfileLocalDatasource profileLocalDatasource;
  final AuthLocalDataSource authLocalDataSource;

  ProfileRepositoryImpl(this.datasource, this.profileLocalDatasource, this.authLocalDataSource);

  @override
  Future<Either<Failure, UserModel>> updateUserProfile({
    required String username,
    required String firstname,
    required String lastname
  }) async {
    try{
      String? id = await profileLocalDatasource.getUserId();

      if (id == null) {
        return Left(ServerFailure(message: "Session expirée ou ID introuvable"));
      }

      int? convertedId = int.tryParse(id);


      final user = await datasource.updateUserProfile(
        username: username, 
        firstname: firstname,
        lastname: lastname,
        id: convertedId,
        );

      if (user == null) {
        return Left(ServerFailure(message: "Utilisateur non trouvé ou session expirée"));
      }
      return Right(user);
    } catch (e) {
        return Left(ServerFailure(message: e.toString()));
    }
  }
  @override
  Future<Either<Failure, MemberModel>> getMemberStats() async {
    try{
      String? id = await profileLocalDatasource.getMemberId();

      if (id == null) {
        return Left(ServerFailure(message: "Session expirée ou ID introuvable"));
      }
      int? convertedId = int.tryParse(id);

      final user = await datasource.getMemberStats(
        id: convertedId,        );

      if (user == null) {
        return Left(ServerFailure(message: "Utilisateur non trouvé ou session expirée"));
      }
      return Right(user);
    } catch (e) {
        return Left(ServerFailure(message: e.toString()));
    }
  }
  @override
  Future<Either<Failure, MemberModel>> updateMemberProfile({
    required int age,
    required double bmi,
    required double fatPercentage,
    required double height,
    required double weight,
    required int workoutFrequency,
    required int gender,
    required int level,
    required int subscription,
  }) async {
    try{
      String? id = await profileLocalDatasource.getMemberId();

      if (id == null) {
        return Left(ServerFailure(message: "Session expirée ou ID introuvable"));
      }

      int? convertedId = int.tryParse(id);


      final member = await datasource.updateMemberProfile(
        age: age,
        bmi: bmi,
        fatPercentage: fatPercentage,
        height: height,
        weight: weight,
        workoutFrequency: workoutFrequency,
        gender: gender,
        level: level,
        subscription: subscription,
        id: convertedId,
        );

      if (member == null) {
        return Left(ServerFailure(message: "Membre non trouvé ou session expirée"));
      }
      return Right(member);
    } catch (e) {
        return Left(ServerFailure(message: e.toString()));
    }

  }

}