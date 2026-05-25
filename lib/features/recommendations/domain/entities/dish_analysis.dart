import 'package:equatable/equatable.dart';

import 'detected_food.dart';
import 'nutrition_values.dart';

class DishAnalysis extends Equatable {
  final List<DetectedFood> foods;
  final NutritionValues nutrition;
  final double reliability;
  final String? recommendation;

  const DishAnalysis({
    required this.foods,
    required this.nutrition,
    required this.reliability,
    this.recommendation,
  });

  @override
  List<Object?> get props => [
    foods,
    nutrition,
    reliability,
    recommendation,
  ];
}
