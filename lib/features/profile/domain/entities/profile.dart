import 'package:equatable/equatable.dart';

import '../../../../core/shared/models/enum_item_model.dart';

class Profile extends Equatable {
  final int id;
  final String username;
  final String firstname;
  final String lastname;
  final String? avatarUrl;
  final int age;
  final EnumItemModel? gender;
  final double? bmi;
  final double? fatPercentage;
  final double? height;
  final double? weight;
  final int workoutFrequency;
  final EnumItemModel? level;
  final EnumItemModel? subscription;

  const Profile({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    this.avatarUrl,
    required this.age,
    this.gender,
    required this.bmi,
    required this.fatPercentage,
    required this.height,
    required this.weight,
    required this.workoutFrequency,
    this.level,
    this.subscription,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    firstname,
    lastname,
    avatarUrl,
    age,
    gender,
    bmi,
    fatPercentage,
    height,
    weight,
    workoutFrequency,
    level,
    subscription,
  ];

  @override
  bool get stringify => true;
}
