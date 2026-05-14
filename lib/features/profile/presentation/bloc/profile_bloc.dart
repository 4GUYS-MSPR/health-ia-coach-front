import 'package:bloc/bloc.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';
import 'package:health_ia_care/features/profile/domain/usecases/update_info_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateInfoProfileUsecase updateProfile;


  ProfileBloc({
    required this.updateProfile
  }) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      ProfileInitial();
    });
    on<ProfileUpdateRequestEvent>((event, emit) => _onUpdateUserProfileEvent(event, emit));
  }

  Future<void> _onUpdateUserProfileEvent(ProfileUpdateRequestEvent event, Emitter<ProfileState> emit ) async {
    emit(ProfilLoading());
    final result = await updateProfile(
      UpdateParams(
        username: event.username,
        firstname : event.firstname,
        lastname: event.lastname
      ),
    );
    result.fold(
      (l) {
        emit(ProfileFailure(message: l.message));
      },
      (r) {
        emit(ProfileUpdateSuccess(user: r));
      },
    );

  }




}
