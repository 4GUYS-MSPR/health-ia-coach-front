import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/profile.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/update_avatar_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUsecase getProfileUseCase;
  final UpdateProfileUsecase updateProfileUseCase;
  final UpdateAvatarUsecase updateAvatarUseCase;

  ProfileBloc({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.updateAvatarUseCase,
  }) : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<UpdateAvatarEvent>(_onUpdateAvatar);

    add(GetProfileEvent());
  }

  Future<void> _onGetProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final result = await getProfileUseCase().run();
    result.fold(
      (failure) => emit(ProfileFailure(failure.toString())),
      (profile) => emit(ProfileLoaded(profile)),
    );
  }

  Future<void> _onUpdateProfile(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    final result = await updateProfileUseCase(event.params).run();
    result.fold(
      (failure) => emit(ProfileFailure(failure.toString())),
      (profile) => emit(ProfileUpdateSuccess(profile)),
    );
  }

  Future<void> _onUpdateAvatar(UpdateAvatarEvent event, Emitter<ProfileState> emit) async {
    final result = await updateAvatarUseCase(
      UpdateAvatarParams(
        file: event.file,
      ),
    ).run();
    result.fold(
      (failure) => emit(ProfileFailure(failure.toString())),
      (profile) => emit(ProfileUpdateSuccess(profile)),
    );
  }
}
