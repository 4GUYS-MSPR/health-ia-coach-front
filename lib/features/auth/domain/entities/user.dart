import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String firstname;
  final String lastname;
  final int memberId;

  const User({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.memberId,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    firstname,
    lastname,
    memberId,
  ];

  @override
  bool get stringify => true;
}
