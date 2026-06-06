import 'package:fpdart/fpdart.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../errors/failure.dart';
import '../repositories/recommendations_repository.dart';

class RecommendationsRequestUsecase implements UseCase<String, NoParams> {
  final RecommendationsRepository repository;

  RecommendationsRequestUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.recommendationsRequest();
  }
}
