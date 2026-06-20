import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/auth_session.dart';
import '../../../domain/usecases/get_session_usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetSessionUsecase _getSessionUsecase;
  final LogoutUsecase _logoutUsecase;

  AuthBloc({
    required GetSessionUsecase getSessionUsecase,
    required LogoutUsecase logoutUsecase,
  }) : _logoutUsecase = logoutUsecase,
       _getSessionUsecase = getSessionUsecase,
       super(AuthInitialState()) {
    on<AuthEvent>((event, emit) {
      emit(AuthInitialState());
    });
    on<AuthGetSessionEvent>((event, emit) => _onGetUserEvent(event, emit));
    on<AuthLogoutEvent>((event, emit) => _onLogoutEvent(event, emit));

    add(AuthGetSessionEvent());
  }

  Future<void> _onGetUserEvent(AuthGetSessionEvent event, Emitter emit) async {
    emit(AuthLoadingState());

    final result = await _getSessionUsecase().run();

    result.fold(
      (l) => emit(AuthFailureState(message: l.toString())),
      (r) {
        if (r != null) {
          emit(AuthLoggedInState(authSession: r));
        } else {
          emit(AuthLoggedOutState());
        }
      },
    );
  }

  Future<void> _onLogoutEvent(AuthLogoutEvent event, Emitter emit) async {
    emit(AuthLoadingState());

    final result = await _logoutUsecase().run();

    result.fold(
      (l) => emit(AuthFailureState(message: l.toString())),
      (r) => emit(AuthLoggedOutState()),
    );
  }
}
