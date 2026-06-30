import '../../domain/entities/body_part.dart';

class BodyPartModel extends BodyPart {
  const BodyPartModel({
    required super.id,
    required super.name,
  });

  factory BodyPartModel.fromJson(Map<String, dynamic> json) {
    return BodyPartModel(
      id: json['id'] as int? ?? 0,
      name: json['value'] as String? ?? 'unknow',
    );
  }
}
