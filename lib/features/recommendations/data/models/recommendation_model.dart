import '../../domain/entities/recommendation.dart';
import 'exercice_model.dart';

class RecommendationModel extends Recommendation {
  const RecommendationModel({
    required super.text,
    required super.exercices,
  });

  factory RecommendationModel.fromJson(Map<String, dynamic> json) {
    return RecommendationModel(
      text: json['message'] as String? ?? json['text'] as String? ?? '',
      exercices: (json['exercices'] as List<dynamic>?)
              ?.map((e) => ExerciceModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}