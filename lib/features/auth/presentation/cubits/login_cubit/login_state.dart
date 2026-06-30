part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {}

final class LoginFailureState extends LoginState {
  final Failure failure;

  const LoginFailureState({
    required this.failure,
  });

  @override
  List<Object> get props => [
    failure,
  ];
}
