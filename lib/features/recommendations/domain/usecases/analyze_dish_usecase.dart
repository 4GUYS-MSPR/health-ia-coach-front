import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dish_analysis.dart';
import '../repositories/recommendations_repository.dart';

class AnalyzeDishParams {
  final PlatformFile image;

  AnalyzeDishParams({required this.image});
}

class AnalyzeDishUsecase implements Usecase<DishAnalysis, AnalyzeDishParams> {
  final RecommendationsRepository repository;

  AnalyzeDishUsecase({
    required this.repository,
  });

  @override
  TaskEither<Failure, DishAnalysis> call(AnalyzeDishParams params) {
    return repository.analyzeDish(image: params.image);
  }
}
