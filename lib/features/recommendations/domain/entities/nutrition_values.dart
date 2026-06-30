import 'package:equatable/equatable.dart';

class NutritionValues extends Equatable {
  final double calories;
  final double proteinsG;
  final double carbsG;
  final double fatsG;
  final double fiberG;
  final double sugarsG;
  final double sodiumMG;
  final double cholesterolMG;
  final double waterIntakeML;
  final String? label;
  final String? category;
  final String? mealType;

  const NutritionValues({
    required this.calories,
    required this.proteinsG,
    required this.carbsG,
    required this.fatsG,
    required this.fiberG,
    required this.sugarsG,
    required this.sodiumMG,
    required this.cholesterolMG,
    required this.waterIntakeML,
    this.label,
    this.category,
    this.mealType,
  });

  @override
  List<Object?> get props => [
    calories,
    proteinsG,
    carbsG,
    fatsG,
    fiberG,
    sugarsG,
    sodiumMG,
    cholesterolMG,
    waterIntakeML,
    label,
    category,
    mealType,
  ];
}
