import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/extensions/theme_extension.dart';
import '../../cubits/login_cubit/login_cubit.dart';
import '../../widgets/login_button.dart';
import '../../widgets/login_password_form_field.dart';
import '../../widgets/login_username_form_field.dart';
import '../../widgets/no_account_register_button.dart';

class LoginCompactLayout extends StatelessWidget {
  const LoginCompactLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.watch<LoginCubit>();

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Connexion",
                  style: context.textTheme.displayLarge,
                ),
                Form(
                  key: loginCubit.formKey,
                  child: AutofillGroup(
                    child: Column(
                      children: [
                        LoginUsernameFormField(),
                        LoginPasswordFormField(),
                      ],
                    ),
                  ),
                ),
                LoginButton(),
                NoAccountRegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
