import 'package:bloc/bloc.dart';
import 'package:health_ia_care/core/usecases/usecase.dart';
import 'package:health_ia_care/features/auth/data/models/user_model.dart';
import 'package:health_ia_care/features/auth/domain/usecases/auth_check_usecase.dart';
import 'package:health_ia_care/features/auth/domain/usecases/register_usecase.dart';
import 'package:health_ia_care/features/auth/domain/usecases/login_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase register;
  final LoginUseCase login;
  final AuthCheckUseCase authCheck;

  AuthBloc({required this.register, required this.login, required this.authCheck})
    : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthInitial());
    });
    on<AuthRegisterRequestEvent>((event, emit) => _onRegisterEvent(event, emit));
    on<AuthLoginRequestEvent>((event, emit) => _onLoginEvent(event, emit));
    on<AuthCheckStatusEvent>((event, emit) => _onCheckStatusEvent(event, emit));
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

  Future<void> _onCheckStatusEvent(AuthCheckStatusEvent event, Emitter<AuthState> emit) async {
    final isConnected = await authCheck(NoParams());
    isConnected.fold(
      (l) {
        emit(AuthFailure(message: l.message));
      },
      (r) {
        emit(AuthLoginSuccess(isLogged: r));
      },
    );
  }
}
