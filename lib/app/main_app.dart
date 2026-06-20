import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/extensions/l10n_extension.dart';
import '../core/shared/cubits/locale_cubit/locale_cubit.dart';
import '../core/shared/cubits/theme_cubit/theme_cubit.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/blocs/auth_bloc/auth_bloc.dart';
import '../features/publications/presentation/bloc/comments_bloc/comments_bloc.dart';
import '../features/publications/presentation/bloc/publications_bloc/publications_bloc.dart';
import '../l10n/generated/app_localizations.dart';
import 'router/app_router.dart';
import 'service_locator/service_locator.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Core
        BlocProvider(create: (_) => sl<ThemeCubit>()),
        BlocProvider(create: (_) => sl<LocaleCubit>()),
        BlocProvider(create: (_) => sl<AuthBloc>()),

        // Features
        BlocProvider(create: (_) => sl<PublicationsBloc>()),
      ],
      child: Builder(
        builder: (context) {
          final appRouter = sl<AppRouter>();
          final selectedLocale = context.watch<LocaleCubit>().state;
          final themeMode = context.watch<ThemeCubit>().state;

          return MaterialApp.router(
            // App title
            onGenerateTitle: (context) => context.l10n.appTitle,

            // App theme
            themeMode: themeMode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            highContrastTheme: AppTheme.lightHighContrast,
            highContrastDarkTheme: AppTheme.darkHighContrast,

            // l10n
            locale: selectedLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,

            // Router
            routerConfig: appRouter.router,
          );
        },
      ),
    );
  }
}
