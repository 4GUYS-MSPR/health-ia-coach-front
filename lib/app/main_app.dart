import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_ia_care/core/extensions/l10n_extension.dart';

import '../core/shared/cubits/locale_cubit/locale_cubit.dart';
import '../core/shared/cubits/theme_cubit.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/comment/presentation/bloc/comment_bloc.dart';
import '../features/profile/presentation/bloc/profile_bloc.dart';
import '../features/publication/presentation/bloc/publication_bloc.dart';
import '../features/recommendations/presentation/blocs/recommendations/recommendations_bloc.dart';
import '../l10n/generated/app_localizations.dart';
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
        BlocProvider(create: (context) => sl<CommentBloc>()),
        BlocProvider(create: (context) => sl<RecommendationsBloc>()),
        BlocProvider(create: (_) => sl<LocaleCubit>()),
        BlocProvider(create: (context) => sl<PublicationBloc>()),
      ],
      child: Builder(
        builder: (context) {
          final appRouter = sl<AppRouter>();
          final selectedLocale = context.watch<LocaleCubit>().state;
          final themeMode = context.watch<ThemeCubit>().state;

          return MaterialApp.router(
            onGenerateTitle: (context) => context.l10n.appTitle,
            themeMode: themeMode,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            highContrastTheme: AppTheme.lightHighContrast,
            highContrastDarkTheme: AppTheme.darkHighContrast,
            title: "Health IA Coach",
            routerConfig: appRouter.router,
            // l10n
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: selectedLocale,
          );
        },
      ),
    );
  }
}
