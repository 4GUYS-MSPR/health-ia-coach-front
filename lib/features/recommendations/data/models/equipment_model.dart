import '../../domain/entities/equipment.dart';

class EquipmentModel extends Equipment {
  const EquipmentModel({
    required super.id,
    required super.name,
  });

  factory EquipmentModel.fromJson(Map<String, dynamic> json) {
    return EquipmentModel(
      id: json['id'] as int? ?? 0,
      name: json['value'] as String? ?? 'unknow',
    );
  }
}