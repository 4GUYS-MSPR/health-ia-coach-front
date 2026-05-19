import 'dart:convert';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.firstname,
    required super.lastname,
    required super.memberId,
    required super.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'first_name': firstname,
      'last_name': lastname,
      'member_id': memberId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      firstname: (map['first_name'] != null && map['first_name'].toString().isNotEmpty)
          ? map['first_name'] as String
          : 'Non renseigné',
      lastname: (map['last_name'] != null && map['last_name'].toString().isNotEmpty)
          ? map['last_name'] as String
          : 'Non renseigné',
      username: map['username'] as String,
      memberId: map['member_id'] as int,
      avatar: map['avatar'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
