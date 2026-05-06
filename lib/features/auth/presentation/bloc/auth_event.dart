part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLoginRequestEvent extends AuthEvent {
  final String username;
  final String password;
  AuthLoginRequestEvent({required this.username, required this.password});
}

class AuthRegisterRequestEvent extends AuthEvent {
  final String username;
  final String password;
  final String structureCode;
  AuthRegisterRequestEvent({
    required this.username,
    required this.password,
    required this.structureCode,
  });
}

class AuthCheckStatusEvent extends AuthEvent {}
