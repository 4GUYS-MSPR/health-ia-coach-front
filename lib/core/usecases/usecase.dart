import 'package:fpdart/fpdart.dart';

import '../errors/failures.dart';

/// Base interface for all standard UseCases in the application.
///
/// In Clean Architecture, UseCases encapsulate specific business rules or scenarios.
/// By returning a [TaskEither], we enforce graceful error handling:
/// - Asynchronous executions are deferred until `.run()` is called.
/// - Failures are caught and mapped left into a domain [Failure].
/// - Successes are mapped right into the expected [ReturnType].
///
/// This entirely prevents raw exceptions from bubbling up to the Presentation layer.
///
/// [ReturnType] specifies the output data type on success.
/// [Params] specifies the input arguments required. Use `NoParams` if no input is needed.
abstract interface class Usecase<ReturnType, Params> {
  TaskEither<Failure, ReturnType> call(Params params);
}
