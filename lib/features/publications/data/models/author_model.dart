import '../../domain/entities/author.dart';

class AuthorModel extends Author {
  const AuthorModel({
    required super.id,
    required super.username,
    required super.firstname,
    required super.lastname,
    super.avatarUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'first_name': firstname,
      'last_name': lastname,
      'avatar': avatarUrl,
    };
  }

  factory AuthorModel.fromMap(Map<String, dynamic> map) {
    return AuthorModel(
      id: map['id'] as int,
      username: map['username'] as String,
      firstname: map['first_name'] as String,
      lastname: map['last_name'] as String,
      avatarUrl: map['avatar'] as String?,
    );
  }
}
