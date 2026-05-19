part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfilLoading extends ProfileState {}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure({required this.message});
}

final class ProfileUpdateSuccess extends ProfileState {
  final UserModel user;

  ProfileUpdateSuccess({required this.user});
}

final class ProfileGetTrainingSuccess extends ProfileState {
  final MemberModel member;

  ProfileGetTrainingSuccess({required this.member});
}

final class ProfileMemberUpdateSuccess extends ProfileState {
  final MemberModel member;
  ProfileMemberUpdateSuccess({required this.member});
}
