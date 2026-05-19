import 'package:equatable/equatable.dart';

import 'enum_member.dart';

class Member extends Equatable {
  final int id;
  final int age;
  final double? bmi;
  final double? fatPercentage;
  final double? height;
  final double? weight;
  final int workoutFrequency;
  final EnumItemModel? gender;
  final EnumItemModel? level;
  final EnumItemModel? subscription;

  const Member({
    required this.id,
    required this.age,
    required this.bmi,
    required this.fatPercentage,
    required this.height,
    required this.weight,
    required this.workoutFrequency,
    this.gender,
    this.level,
    this.subscription,
  });

  @override
  List<Object?> get props => [
    id,
    age,
    bmi,
    fatPercentage,
    height,
    weight,
    workoutFrequency,
    gender,
    level,
    subscription,
  ];

  @override
  bool get stringify => true;
}
