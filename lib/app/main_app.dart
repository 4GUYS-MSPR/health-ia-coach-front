import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/theme/app_theme.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/comment/presentation/bloc/comment_bloc.dart';
import '../features/profile/presentation/bloc/profile_bloc.dart';
import '../features/publication/presentation/bloc/publication_bloc.dart';
import '../features/theme/theme_cubit.dart';
import 'router/app_router.dart';
import 'service_locator/service_locator.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<ProfileBloc>()),
        BlocProvider(create: (context) => sl<PublicationBloc>()),
        BlocProvider(create: (context) => sl<CommentBloc>()),
      ],
      child: Builder(
        builder: (context) {
          final appRouter = sl<AppRouter>();
          final themeMode = context.watch<ThemeCubit>().state;

          return MaterialApp.router(
            themeMode: themeMode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            highContrastTheme: AppTheme.lightHighContrast,
            highContrastDarkTheme: AppTheme.darkHighContrast,
            title: "Health IA Coach",
            routerConfig: appRouter.router,
          );
        },
      ),
    );
  }
}
