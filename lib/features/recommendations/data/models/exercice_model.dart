import '../../../../core/shared/models/enum_item_model.dart';
import '../../domain/entities/exercice.dart';
import 'body_part_model.dart';
import 'equipment_model.dart';
import 'muscle_model.dart';

class ExerciceModel extends Exercice {
  const ExerciceModel({
    required super.id,
    required super.imageUrl,
    required super.createAt,
    super.category,
    super.bodyParts,
    super.equipments,
    super.secondaryMuscles,
    super.targetMuscles,
  });

  factory ExerciceModel.fromJson(Map<String, dynamic> json) {
    return ExerciceModel(
      id: json['id'] as int? ?? 0,
      imageUrl: json['image_url'] as String? ?? '',
      createAt: json['create_at'] as String? ?? '',
      category: EnumItemModel.fromJson(json['category']),
      bodyParts:
          (json['body_parts'] as List<dynamic>?)
              ?.map((e) => BodyPartModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      equipments:
          (json['equipments'] as List<dynamic>?)
              ?.map((e) => EquipmentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      secondaryMuscles:
          (json['secondary_muscles'] as List<dynamic>?)
              ?.map((e) => MuscleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      targetMuscles:
          (json['target_muscles'] as List<dynamic>?)
              ?.map((e) => MuscleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
