import 'package:auto_validate/auto_validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../cubits/login_cubit/login_cubit.dart';

class LoginPasswordFormField extends StatefulWidget {
  const LoginPasswordFormField({
    super.key,
  });

  @override
  State<LoginPasswordFormField> createState() => _LoginPasswordFormFieldState();
}

class _LoginPasswordFormFieldState extends State<LoginPasswordFormField> {
  bool obscureText = true;

  void toggleVisibility() {
    HapticFeedback.selectionClick();
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.watch<LoginCubit>();

    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: .circular(12)),
      prefixIcon: const Icon(Symbols.password),
      labelText: "Password",
      hintText: "Enter your password",
      // labelText: context.l10n.authSignInPasswordFormFieldLabel,
      // hintText: context.l10n.authSignInPasswordFormFieldHint,
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: IconButton(
          style: const ButtonStyle(),
          onPressed: toggleVisibility,
          icon: Icon(
            obscureText ? Symbols.visibility : Symbols.visibility_off,
          ),
        ),
      ),
    );

    final autofillHints = [
      AutofillHints.password,
    ];

    final validator = FormValidator.required(
      // errorMessage: context.l10n.globalFormFieldErrorRequired,
    );

    void onFieldSubmitted(_) {
      context.read<LoginCubit>().submitRequested();
    }

    return TextFormField(
      controller: loginCubit.passwordController,
      decoration: inputDecoration,
      autofillHints: autofillHints,
      obscureText: obscureText,
      validator: validator,
      autovalidateMode: .onUserInteractionIfError,
      keyboardType: .visiblePassword,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
