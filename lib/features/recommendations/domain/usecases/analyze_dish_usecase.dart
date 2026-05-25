import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../errors/failure.dart';
import '../entities/dish_analysis.dart';
import '../repositories/recommendations_repository.dart';

class AnalyzeDishParams {
  final PlatformFile image;

  AnalyzeDishParams({required this.image});
}

class AnalyzeDishUsecase implements UseCase<DishAnalysis, AnalyzeDishParams> {
  final RecommendationsRepository repository;

  AnalyzeDishUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, DishAnalysis>> call(AnalyzeDishParams params) async {
    return await repository.analyzeDish(image: params.image);
  }
}
