import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/usecases/register_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUsecase _registerUsecase;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController structureCodeController = TextEditingController();

  RegisterCubit({
    required RegisterUsecase registerUsecase,
  }) : _registerUsecase = registerUsecase,
       super(RegisterInitialState());

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    emit(RegisterLoadingState());

    final result = await _registerUsecase(
      RegisterUsecaseParams(
        username: usernameController.text.trim(),
        password: passwordController.text,
        structureCode: structureCodeController.text.trim(),
      ),
    ).run();

    result.match(
      (l) => emit(RegisterFailureState(failure: l.toString())),
      (r) => emit(RegisterSuccessState()),
    );
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    passwordController.dispose();
    structureCodeController.dispose();
    return super.close();
  }
}
