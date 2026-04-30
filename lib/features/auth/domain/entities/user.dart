import 'package:equatable/equatable.dart';

class User extends Equatable{
  final int id;
  final String email;
  final String username;
  final String firstname;
  final String lastname;

  const User({
    required this.id,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.username,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    firstname,
    lastname,
  ];

  @override
  bool get stringify => true;
}