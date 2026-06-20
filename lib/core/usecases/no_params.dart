import 'package:equatable/equatable.dart';

/// A utility class used to represent the absence of parameters.
///
/// In Clean Architecture, every UseCase typically defines a `Params` type
/// to strongly type its inputs. When a UseCase does not require any input data
/// (e.g., retrieving a global stream, signing out), [NoParams] is used to
/// fulfill the generic contract safely without relying on `null` or `void`.
class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
