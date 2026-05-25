import 'package:equatable/equatable.dart';

class NutritionValues extends Equatable {
  final double calories;
  final double proteinsG;
  final double carbsG;
  final double fatsG;

  const NutritionValues({
    required this.calories,
    required this.proteinsG,
    required this.carbsG,
    required this.fatsG,
  });

  @override
  List<Object?> get props => [
    calories,
    proteinsG,
    carbsG,
    fatsG,
  ];
}
