import 'package:fpdart/fpdart.dart';

import '../errors/failures.dart';

/// An interface for generic usecases returning streams with functional error handling.
///
/// Enforces the Clean Architecture rule that all external operations must
/// be encapsulated securely. Instead of exposing raw `Exception`s, a `StreamUsecase`
/// wraps each event inside an [Either] returning:
/// - A typed [Failure] in the `Left` container if an operation failed.
/// - The domain response object [ReturnType] in the `Right` container if successful.
///
/// Parameters for the operation are passed through the [Params] argument.
abstract interface class StreamUsecase<ReturnType, Params> {
  Stream<Either<Failure, ReturnType>> call(Params params);
}
