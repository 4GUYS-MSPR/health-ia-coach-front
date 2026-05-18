import 'package:bloc/bloc.dart';
import 'package:health_ia_care/core/logging/logger_mixin.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';
import 'package:health_ia_care/features/profile/data/models/member_model.dart';
import 'package:health_ia_care/features/profile/domain/usecases/display_user_traning_info_usecase.dart';
import 'package:health_ia_care/features/profile/domain/usecases/update_info_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> with LoggerMixin {
  final UpdateInfoProfileUsecase updateProfile;
  final DisplayUserTrainingUsecase displayTraningStats;


  ProfileBloc({
    required this.updateProfile,
    required this.displayTraningStats
  }) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      ProfileInitial();
    });
    on<ProfileUpdateRequestEvent>((event, emit) => _onUpdateUserProfileEvent(event, emit));
    on<DisplayMemberRequestEvent>((event, emit) => _onGetMemberTrainingProfileEvent(event, emit));
  }

  @override
  String get loggerName => 'Profile.Data.ProfileBloc';

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

  Future<void> _onGetMemberTrainingProfileEvent(DisplayMemberRequestEvent event, Emitter<ProfileState> emit ) async {
    emit(ProfilLoading());
    final result = await displayTraningStats(NoParams());

    result.fold(
      (l) {
        emit(ProfileFailure(message: l.message));
        logger.warning(l.message);
      },
      (r) {
        emit(ProfileGetTrainingSuccess(member: r));
      }
    );
  }
}
