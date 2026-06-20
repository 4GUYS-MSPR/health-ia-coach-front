import 'package:auto_validate/auto_validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../cubits/login_cubit/login_cubit.dart';

class LoginUsernameFormField extends StatelessWidget {
  const LoginUsernameFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.watch<LoginCubit>();

    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: .circular(12)),
      prefixIcon: const Icon(Symbols.person),
      labelText: "Username",
      hintText: "Enter your username",
    );
    final autofillHints = [
      AutofillHints.username,
    ];
    final validator = FormValidator.combination(
      validators: [
        FormValidator.required(
          // errorMessage: context.l10n.globalFormFieldErrorRequired,
        ),
      ],
    );

    return TextFormField(
      controller: loginCubit.usernameController,
      decoration: inputDecoration,
      autofillHints: autofillHints,
      validator: validator,
      autovalidateMode: .onUserInteractionIfError,
      keyboardType: .emailAddress,
      textInputAction: .next,
    );
  }
}
