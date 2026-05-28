import '../../domain/entities/nutrition_values.dart';

class NutritionValuesModel extends NutritionValues {
  const NutritionValuesModel({
    required super.calories,
    required super.proteinsG,
    required super.carbsG,
    required super.fatsG,
    required super.fiberG,
    required super.sugarsG,
    required super.sodiumMG,
    required super.cholesterolMG,
    required super.waterIntakeML,
    super.label,
    super.category,
    super.mealType,
  });

  factory NutritionValuesModel.fromMap(Map<String, dynamic> map) {
    double readDouble(String key) {
      final value = map[key];
      if (value == null) return 0.0;
      if (value is num) return value.toDouble();
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return NutritionValuesModel(
      label:         map['label'] as String?,
      calories:      readDouble('calories'),
      proteinsG:     readDouble('protein'),       
      carbsG:        readDouble('carbohydrates'), 
      fatsG:         readDouble('fat'),           
      fiberG:        readDouble('fiber'),
      sugarsG:       readDouble('sugars'),
      sodiumMG:      readDouble('sodium'),
      cholesterolMG: readDouble('cholesterol'),
      waterIntakeML: readDouble('water_intake'),
      category:      map['category'] as String?,
      mealType:      map['meal_type'] as String?,
    );
  }

  factory NutritionValuesModel.empty() {
  return const NutritionValuesModel(
    calories:      0.0,
    proteinsG:     0.0,
    carbsG:        0.0,
    fatsG:         0.0,
    fiberG:        0.0,
    sugarsG:       0.0,
    sodiumMG:      0.0,
    cholesterolMG: 0.0,
    waterIntakeML: 0.0,
    label:         null,
    category:      null,
    mealType:      null,
  );
}
}