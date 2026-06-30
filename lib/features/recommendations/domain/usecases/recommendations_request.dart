import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/recommendation.dart';
import '../repositories/recommendations_repository.dart';

class RecommendationsRequestUsecase implements Usecase<Recommendation, NoParams> {
  final RecommendationsRepository repository;

  RecommendationsRequestUsecase({
    required this.repository,
  });

  @override
  TaskEither<Failure, Recommendation> call(NoParams params) {
    return repository.recommendationsRequest();
  }
}
