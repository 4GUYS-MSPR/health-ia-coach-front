import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/recommendations_repository.dart';

class RecommendationsRequestUsecase implements Usecase<String, NoParams> {
  final RecommendationsRepository repository;

  RecommendationsRequestUsecase({
    required this.repository,
  });

  @override
  TaskEither<Failure, String> call(NoParams params) {
    return repository.recommendationsRequest();
  }
}
