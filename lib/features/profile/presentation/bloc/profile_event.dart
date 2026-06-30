part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final UpdateProfileParams params;
  const UpdateProfileEvent(this.params);
  @override
  List<Object?> get props => [params];
}

class UpdateAvatarEvent extends ProfileEvent {
  final PlatformFile file;
  const UpdateAvatarEvent(this.file);
  @override
  List<Object?> get props => [file];
}
