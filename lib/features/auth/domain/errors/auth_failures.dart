import '../../../../core/errors/failures.dart';

/// Base class for authentication-related failures.
sealed class AuthFailure extends Failure {
  const AuthFailure({super.debugMessage});
}

class UnknowAuthFailure extends AuthFailure {
  const UnknowAuthFailure({super.debugMessage});
}

/// Username is required but was not provided.
class EmptyUsernameFailure extends AuthFailure {
  const EmptyUsernameFailure({super.debugMessage});
}

/// Password is required but was not provided.
class EmptyPasswordFailure extends AuthFailure {
  const EmptyPasswordFailure({super.debugMessage});
}

/// Provided credentials are incorrect.
class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure({super.debugMessage});
}

/// Sign-in is blocked because the account is locked.
class AccountLockedFailure extends AuthFailure {
  const AccountLockedFailure({super.debugMessage});
}

/// The auth service rejected the request because too many attempts were made.
class TooManyRequestsFailure extends AuthFailure {
  const TooManyRequestsFailure({super.debugMessage});
}

/// The provided password does not meet the minimum security requirements.
class WeakPasswordFailure extends AuthFailure {
  const WeakPasswordFailure({super.debugMessage});
}

/// The password confirmation does not match the password value.
class PasswordMismatchFailure extends AuthFailure {
  const PasswordMismatchFailure({super.debugMessage});
}
