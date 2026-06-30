import 'package:equatable/equatable.dart';

class Author extends Equatable {
  final int id;
  final String username;
  final String firstname;
  final String lastname;
  final String? avatarUrl;

  const Author({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    firstname,
    lastname,
    avatarUrl,
  ];
}
