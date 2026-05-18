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
      String? token = await authLocalDataSource.getToken();

      if (id == null || token == null) {
        return Left(ServerFailure(message: "Session expirée ou ID introuvable"));
      }

      int? convertedId = int.tryParse(id);


      final user = await datasource.updateUserProfile(
        username: username, 
        firstname: firstname,
        lastname: lastname,
        id: convertedId,
        token: token
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
      String? token = await authLocalDataSource.getToken();

      if (id == null || token == null) {
        return Left(ServerFailure(message: "Session expirée ou ID introuvable"));
      }
      int? convertedId = int.tryParse(id);

      final user = await datasource.getMemberStats(
        id: convertedId,
        token: token
        );

      if (user == null) {
        return Left(ServerFailure(message: "Utilisateur non trouvé ou session expirée"));
      }
      return Right(user);
    } catch (e) {
        return Left(ServerFailure(message: e.toString()));
    }
  }

}