import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

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
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 32),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Symbols.cardiology,
                            size: 48,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Connexion",
                            style: context.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Veuillez entrer vos identifiants pour continuer",
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 32),
                        Form(
                          key: loginCubit.formKey,
                          child: const AutofillGroup(
                            child: Column(
                              children: [
                                LoginUsernameFormField(),
                                SizedBox(height: 12),
                                LoginPasswordFormField(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const LoginButton(),
                      ],
                    ),
                  ),
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: NoAccountRegisterButton(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
