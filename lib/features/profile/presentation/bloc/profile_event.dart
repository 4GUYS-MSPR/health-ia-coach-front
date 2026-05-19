part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class ProfileUpdateRequestEvent extends ProfileEvent {
  final String username;
  final String firstname;
  final String lastname;
  ProfileUpdateRequestEvent({
    required this.username,
    required this.firstname,
    required this.lastname,
  });
}

class DisplayMemberRequestEvent extends ProfileEvent {}

class ProfileMemberUpdateRequestEvent extends ProfileEvent {
  final int age;
  final double bmi;
  final double fatPercentage;
  final double height;
  final double weight;
  final int workoutFrequency;
  final int gender;
  final int level;
  final int subscription;

  ProfileMemberUpdateRequestEvent({
    required this.age,
    required this.bmi,
    required this.fatPercentage,
    required this.height,
    required this.weight,
    required this.workoutFrequency,
    required this.gender,
    required this.level,
    required this.subscription,
  });
}
