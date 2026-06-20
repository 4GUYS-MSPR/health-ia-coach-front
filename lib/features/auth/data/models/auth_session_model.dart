import 'dart:convert';

import '../../domain/entities/auth_session.dart';

class AuthSessionModel extends AuthSession {
  const AuthSessionModel({
    required super.accessToken,
    required super.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access': accessToken,
      'refresh': refreshToken,
    };
  }

  factory AuthSessionModel.fromMap(Map<String, dynamic> map) {
    return AuthSessionModel(
      accessToken: map['access'] as String,
      refreshToken: map['refresh'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthSessionModel.fromJson(String source) {
    return AuthSessionModel.fromMap(
      json.decode(source) as Map<String, dynamic>,
    );
  }

  factory AuthSessionModel.fromEntity(AuthSession entity) {
    return AuthSessionModel(
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
    );
  }
}
