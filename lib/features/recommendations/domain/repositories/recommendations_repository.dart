import 'package:file_picker/file_picker.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../errors/failure.dart';
import '../entities/dish_analysis.dart';

abstract interface class RecommendationsRepository {
  Future<Either<Failure, DishAnalysis>> analyzeDish({
    required PlatformFile image,
  });
}
