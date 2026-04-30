part of 'auth_bloc.dart';

abstract class AuthState{}

class AuthInitial extends AuthState{}
class AuthLoading extends AuthState{}
class AuthFailure extends AuthState{
  final String message;
  AuthFailure({required this.message});
}
class AuthSuccess extends AuthState{
  final UserModel? user;
  AuthSuccess(this.user);
}

final class AuthRegisterSuccess extends AuthState {
  final bool isRegistred;

  AuthRegisterSuccess({required this.isRegistred});
}

final class AuthLoginSuccess extends AuthState {
  final bool isLogged;

  AuthLoginSuccess({required this.isLogged});
}

