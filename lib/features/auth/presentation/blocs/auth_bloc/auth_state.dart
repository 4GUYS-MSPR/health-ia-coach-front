part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthFailureState extends AuthState {
  final String message;

  const AuthFailureState({
    required this.message,
  });

  @override
  List<Object?> get props => [
    message,
  ];
}

final class AuthLoggedInState extends AuthState {
  final AuthSession authSession;

  const AuthLoggedInState({
    required this.authSession,
  });

  @override
  List<Object?> get props => [
    authSession,
  ];
}

final class AuthLoggedOutState extends AuthState {}
