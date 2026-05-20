part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}

final class AuthSuccess extends AuthState {
  final UserModel user;

  AuthSuccess({required this.user});
}

final class AuthRegisterSuccess extends AuthState {
  final bool isRegistred;

  AuthRegisterSuccess({required this.isRegistred});
}

final class AuthLoginSuccess extends AuthState {
  final bool isLogged;

  AuthLoginSuccess({required this.isLogged});
}

final class AuthLogoutSucess extends AuthState {}

final class AuthLogoutFailed extends AuthState {}

final class AuthUpdateAvatarSuccess extends AuthSuccess {
  AuthUpdateAvatarSuccess({required super.user});
}
