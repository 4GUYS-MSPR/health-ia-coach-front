import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/errors/failures.dart';
import '../../../../../core/logging/logger_mixin.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> with LoggerMixin {
  final LoginUsecase _loginWithPasswordUsecase;

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginCubit({
    required LoginUsecase loginWithPasswordUsecase,
  }) : _loginWithPasswordUsecase = loginWithPasswordUsecase,
       super(LoginInitialState());

  @override
  String get loggerName => 'Auth.Presentation.Cubits.LoginCubit';

  Future<void> submitRequested() async {
    final form = formKey.currentState;
    if (form == null || !form.validate()) {
      return;
    }
    emit(LoginLoadingState());
    logger.info('Sign-in action initiated from UI');

    final res = await _loginWithPasswordUsecase(
      LoginUsecaseParams(
        username: usernameController.text,
        password: passwordController.text,
      ),
    ).run();

    res.fold(
      (l) {
        logger.warning('Sign-in failed: ${l.runtimeType}');
        emit(LoginFailureState(failure: l));
      },
      (r) {
        logger.info('Sign-in successful');
        emit(LoginSuccessState());
      },
    );
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
