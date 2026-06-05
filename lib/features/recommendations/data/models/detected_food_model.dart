import '../../domain/entities/detected_food.dart';

class DetectedFoodModel extends DetectedFood {
  const DetectedFoodModel({
    required super.name,
    required super.confidence,
  });

  factory DetectedFoodModel.fromMap(Map<String, dynamic> map) {
    final name = map['name'];
    if (name is! String || name.trim().isEmpty) {
      throw const FormatException('Invalid "name" for detected food');
    }
    final confidence = map['confidence'];
    if (confidence is! num) {
      throw const FormatException('Invalid "confidence" for detected food');
    }
    return DetectedFoodModel(
      name: name,
      confidence: confidence.toDouble(),
    );
  }
}
