import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/models/user_model.dart';
import '../../domain/usecases/auth_check_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/update_avatar.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase register;
  final LoginUseCase login;
  final GetUser getUser;
  final LogoutUseCase logout;
  final UpdateAvatar updateAvatar;

  AuthBloc({
    required this.register,
    required this.login,
    required this.getUser,
    required this.logout,
    required this.updateAvatar,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthInitial());
    });
    on<AuthRegisterRequestEvent>((event, emit) => _onRegisterEvent(event, emit));
    on<AuthLoginRequestEvent>((event, emit) => _onLoginEvent(event, emit));
    on<AuthGetUserEvent>((event, emit) => _onGetUserEvent(event, emit));
    on<AuthLogoutEvent>((event, emit) => _onLogoutEvent(event, emit));
    on<AuthUpdateAvatarEvent>((event, emit) => _onUpdateAvatarEvent(event, emit));
    add(AuthGetUserEvent());
  }

  Future<void> _onRegisterEvent(AuthRegisterRequestEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await register(
      RegisterParams(
        username: event.username,
        password: event.password,
        structureCode: event.structureCode,
      ),
    );
    result.fold(
      (l) {
        emit(AuthFailure(message: l.message));
      },
      (r) {
        emit(AuthRegisterSuccess(isRegistred: r));
      },
    );
  }

  Future<void> _onLoginEvent(AuthLoginRequestEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await login(LoginParams(username: event.username, password: event.password));
    result.fold(
      (l) {
        emit(AuthFailure(message: l.message));
      },
      (r) {
        emit(AuthLoginSuccess(isLogged: r));
      },
    );
  }

  Future<void> _onGetUserEvent(AuthGetUserEvent event, Emitter emit) async {
    emit(AuthLoading());
    final result = await getUser(NoParams());

    result.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => emit(AuthSuccess(user: r)),
    );
  }

  Future<void> _onLogoutEvent(AuthLogoutEvent event, Emitter emit) async {
    emit(AuthLoading());
    final result = await logout(NoParams());

    result.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => emit(r ? AuthLogoutSucess() : AuthLogoutFailed()),
    );
  }

  Future<void> _onUpdateAvatarEvent(AuthUpdateAvatarEvent event, Emitter emit) async {
    emit(AuthLoading());
    final result = await updateAvatar(UpdateAvatarParams(file: event.file));
    result.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => emit(AuthUpdateAvatarSuccess(user: r)),
    );
  }
}
