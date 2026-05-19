import 'package:bloc/bloc.dart';

import '../../../../core/logging/logger_mixin.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../auth/data/models/user_model.dart';
import '../../data/models/member_model.dart';
import '../../domain/usecases/display_user_traning_info_usecase.dart';
import '../../domain/usecases/update_info_member_usecase.dart';
import '../../domain/usecases/update_info_profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> with LoggerMixin {
  final UpdateInfoProfileUsecase updateProfile;
  final DisplayUserTrainingUsecase displayTraningStats;
  final UpdateInfoMemberUsecase updateMemberProfile;

  ProfileBloc({
    required this.updateProfile,
    required this.displayTraningStats,
    required this.updateMemberProfile,
  }) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      ProfileInitial();
    });
    on<ProfileUpdateRequestEvent>((event, emit) => _onUpdateUserProfileEvent(event, emit));
    on<DisplayMemberRequestEvent>((event, emit) => _onGetMemberTrainingProfileEvent(event, emit));
    on<ProfileMemberUpdateRequestEvent>((event, emit) => _onUpdateMemberProfileEvent(event, emit));
  }

  @override
  String get loggerName => 'Profile.Data.ProfileBloc';

  Future<void> _onUpdateUserProfileEvent(
    ProfileUpdateRequestEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfilLoading());
    final result = await updateProfile(
      UpdateParams(username: event.username, firstname: event.firstname, lastname: event.lastname),
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

  Future<void> _onUpdateMemberProfileEvent(
    ProfileMemberUpdateRequestEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfilLoading());
    final result = await updateMemberProfile(
      UpdateMemberParams(
        age: event.age,
        bmi: event.bmi,
        fatPercentage: event.fatPercentage,
        height: event.height,
        weight: event.weight,
        workoutFrequency: event.workoutFrequency,
        gender: event.gender,
        level: event.level,
        subscription: event.subscription,
      ),
    );
    result.fold(
      (l) {
        emit(ProfileFailure(message: l.message));
      },
      (r) {
        emit(ProfileMemberUpdateSuccess(member: r));
      },
    );
  }

  Future<void> _onGetMemberTrainingProfileEvent(
    DisplayMemberRequestEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfilLoading());
    final result = await displayTraningStats(NoParams());

    result.fold(
      (l) {
        emit(ProfileFailure(message: l.message));
        logger.warning(l.message);
      },
      (r) {
        emit(ProfileGetTrainingSuccess(member: r));
      },
    );
  }
}
