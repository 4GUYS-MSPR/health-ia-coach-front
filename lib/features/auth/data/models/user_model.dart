import 'dart:convert';
import 'package:health_ia_care/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.username,
    required super.firstname,
    required super.lastname,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': firstname,
      'last_name': lastname,
      'username': username,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      email: map['email'] as String,
      firstname: map['first_name'] as String,
      lastname: map['last_name'] as String,
      username: map['username'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
