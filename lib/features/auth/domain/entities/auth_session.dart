import 'package:equatable/equatable.dart';

class AuthSession extends Equatable {
  final String accessToken;
  final String refreshToken;

  const AuthSession({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [
    accessToken,
    refreshToken,
  ];

  AuthSession copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return AuthSession(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
