import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String username;
  final String firstname;
  final String lastname;

  const User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
  });

  @override
  List<Object?> get props => [
    id,
    firstname,
    lastname,
  ];

  @override
  bool get stringify => true;
}
