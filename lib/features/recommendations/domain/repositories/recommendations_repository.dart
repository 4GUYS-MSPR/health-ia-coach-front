import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/dish_analysis.dart';

abstract interface class RecommendationsRepository {
  TaskEither<Failure, DishAnalysis> analyzeDish({
    required PlatformFile image,
  });
  TaskEither<Failure, String> recommendationsRequest();
}
