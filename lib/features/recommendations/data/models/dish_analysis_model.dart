import '../../domain/entities/dish_analysis.dart';
import 'detected_food_model.dart';
import 'nutrition_values_model.dart';

class DishAnalysisModel extends DishAnalysis {
  const DishAnalysisModel({
    required super.foods,
    required super.nutrition,
    required super.reliability,
    super.recommendation,
  });

  factory DishAnalysisModel.fromMap(Map<String, dynamic> map) {
    final foodsData = map['foods'];
    if (foodsData is! List) {
      throw const FormatException('Invalid "foods" list');
    }

    final nutritionData = map['nutrition'];
    if (nutritionData is! Map<String, dynamic>) {
      throw const FormatException('Invalid "nutrition" object');
    }

    final reliability = map['reliability'];
    if (reliability is! num) {
      throw const FormatException('Invalid "reliability"');
    }

    final recommendation = map['recommendation'];
    if (recommendation != null && recommendation is! String) {
      throw const FormatException('Invalid "recommendation"');
    }

    return DishAnalysisModel(
      foods: foodsData
          .map((item) => DetectedFoodModel.fromMap(item as Map<String, dynamic>))
          .toList(),
      nutrition: NutritionValuesModel.fromMap(nutritionData),
      reliability: reliability.toDouble(),
      recommendation: recommendation as String?,
    );
  }
}
