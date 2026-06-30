import 'dart:convert';

import '../../../../core/shared/models/enum_item_model.dart';
import '../../domain/entities/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.id,
    required super.username,
    required super.firstname,
    required super.lastname,
    required super.age,
    required super.bmi,
    required super.fatPercentage,
    required super.height,
    required super.weight,
    required super.workoutFrequency,
    super.gender,
    super.level,
    super.subscription,
    super.avatarUrl,
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

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as int,
      avatarUrl: map['avatar'] as String,
      username: map['username'] as String,
      firstname: map['first_name'] as String,
      lastname: map['last_name'] as String,
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

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
