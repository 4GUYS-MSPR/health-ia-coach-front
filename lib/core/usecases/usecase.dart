import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:health_ia_care/errors/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
