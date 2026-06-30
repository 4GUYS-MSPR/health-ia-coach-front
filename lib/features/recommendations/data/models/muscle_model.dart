import '../../domain/entities/muscle.dart';

class MuscleModel extends Muscle {
  const MuscleModel({
    required super.id,
    required super.name,
  });

  factory MuscleModel.fromJson(Map<String, dynamic> json) {
    return MuscleModel(
      id: json['id'] as int? ?? 0,
      name: json['value'] as String? ?? 'unknow',
    );
  }
}
