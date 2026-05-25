import '../../domain/entities/nutrition_values.dart';

class NutritionValuesModel extends NutritionValues {
  const NutritionValuesModel({
    required super.calories,
    required super.proteinsG,
    required super.carbsG,
    required super.fatsG,
  });

  factory NutritionValuesModel.fromMap(Map<String, dynamic> map) {
    double readDouble(String key) {
      final value = map[key];
      if (value is! num) {
        throw FormatException('Invalid "$key" in nutrition');
      }
      return value.toDouble();
    }

    return NutritionValuesModel(
      calories: readDouble('calories'),
      proteinsG: readDouble('proteins_g'),
      carbsG: readDouble('carbs_g'),
      fatsG: readDouble('fats_g'),
    );
  }
}
