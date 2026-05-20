import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String firstname;
  final String lastname;
  final int memberId;
  final String? avatar;

  const User({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.memberId,
    required this.avatar,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    firstname,
    lastname,
    memberId,
    avatar
  ];

  @override
  bool get stringify => true;
}
