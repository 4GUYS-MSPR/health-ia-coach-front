import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/extensions/theme_extension.dart';
import '../../cubits/register_cubit/register_cubit.dart';
import '../../widgets/already_have_account_login_button.dart';

class RegisterCompactLayout extends StatelessWidget {
  const RegisterCompactLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.read<RegisterCubit>();

    final inputDecorationTheme = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );

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
                            "Inscription",
                            style: context.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Créez votre compte pour démarrer.",
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
                          key: registerCubit.formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: registerCubit.usernameController,
                                decoration: inputDecorationTheme.copyWith(
                                  labelText: 'Nom d\'utilisateur',
                                  prefixIcon: const Icon(Symbols.person),
                                ),
                                validator: (val) => val != null && val.isEmpty ? 'Requis' : null,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: registerCubit.passwordController,
                                decoration: inputDecorationTheme.copyWith(
                                  labelText: 'Mot de passe',
                                  prefixIcon: const Icon(Symbols.password),
                                ),
                                obscureText: true,
                                validator: (val) => val != null && val.isEmpty ? 'Requis' : null,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: registerCubit.structureCodeController,
                                decoration: inputDecorationTheme.copyWith(
                                  labelText: 'Code de structure',
                                  prefixIcon: const Icon(Symbols.domain),
                                ),
                                validator: (val) => val != null && val.isEmpty ? 'Requis' : null,
                                textInputAction: TextInputAction.done,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            final isLoading = state is RegisterLoadingState;
                            return FilledButton.icon(
                              onPressed: isLoading ? null : () => registerCubit.register(),
                              style: ButtonStyle(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              icon: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Icon(Symbols.person_add),
                              label: Text(isLoading ? 'Création...' : 'Créer mon compte'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: AlreadyHaveAccountLoginButton(),
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
