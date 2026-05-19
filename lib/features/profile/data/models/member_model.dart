import 'dart:convert';

import '../../domain/entities/enum_member.dart';
import '../../domain/entities/member.dart';

class MemberModel extends Member {
  const MemberModel({
    required super.id,
    required super.age,
    required super.bmi,
    required super.fatPercentage,
    required super.height,
    required super.weight,
    required super.workoutFrequency,
    super.gender,
    super.level,
    super.subscription,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'age': age,
      'bmi': bmi,
      'fat_percentage': fatPercentage,
      'height': height,
      'weight': weight,
      'workout_frequency': workoutFrequency,
      if (gender != null) 'gender': gender!.id,
      if (level != null) 'level': level!.id,
      if (subscription != null) 'subscription': subscription!.id,
    };
  }

  factory MemberModel.fromMap(Map<String, dynamic> map) {
    return MemberModel(
      id: map['id'] as int,
      age: map['age'] as int,
      bmi: (map['bmi'] as num?)?.toDouble() ?? 0.0,
      fatPercentage: (map['fat_percentage'] as num?)?.toDouble() ?? 0.0,
      height: (map['height'] as num?)?.toDouble() ?? 0.0,
      weight: (map['weight'] as num?)?.toDouble() ?? 0.0,
      workoutFrequency: map['workout_frequency'] as int? ?? 0,
      gender: EnumItemModel.fromJson(map['gender']),
      level: EnumItemModel.fromJson(map['level']),
      subscription: EnumItemModel.fromJson(map['subscription']),
    );
  }

  String toJson() => json.encode(toMap());

  factory MemberModel.fromJson(String source) =>
      MemberModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
