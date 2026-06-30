import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/service_locator/service_locator.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/shared/layouts/responsive_layout_builder.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../cubits/register_cubit/register_cubit.dart';
import '../layouts/register/register_compact_layout.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterCubit>(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.l10n.authErrorLabel(state.failure))),
                );
              } else if (state is RegisterSuccessState) {
                context.read<AuthBloc>().add(AuthGetSessionEvent());
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoggedInState) {
                context.goNamed(AppRoutes.home);
              }
            },
          ),
        ],
        child: ResponsiveLayoutBuilder(
          compact: RegisterCompactLayout(),
        ),
      ),
    );
  }
}
