part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class ProfileUpdateRequestEvent extends ProfileEvent{
  final String username;
  final String firstname;
  final String lastname;
  ProfileUpdateRequestEvent({required this.username, required this.firstname, required this.lastname});
}
