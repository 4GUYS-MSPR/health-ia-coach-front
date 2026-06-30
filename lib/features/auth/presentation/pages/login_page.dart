import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../app/service_locator/service_locator.dart';
import '../../../../core/extensions/l10n_extension.dart';
import '../../../../core/shared/layouts/responsive_layout_builder.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../cubits/login_cubit/login_cubit.dart';
import '../layouts/login/login_compact_layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.l10n.authErrorLabel(state.failure.debugMessage ?? ''))),
                );
              } else if (state is LoginSuccessState) {
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
          compact: LoginCompactLayout(),
        ),
      ),
    );
  }
}
