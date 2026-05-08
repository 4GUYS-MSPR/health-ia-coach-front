import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/presentation/bloc/auth_bloc.dart';
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
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final appRouter = sl<AppRouter>();
          final themeMode = context.watch<ThemeCubit>().state;

          return MaterialApp.router(
            themeMode: themeMode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            title: "Health IA Coach",
            routerConfig: appRouter.router,
          );
        },
      ),
    );
  }
}
