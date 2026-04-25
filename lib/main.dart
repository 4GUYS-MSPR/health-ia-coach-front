import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_ia_care/app/router/app_router.dart';
import './feature/theme/theme_cubit.dart';


void main() {
  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final AppRouter appRouter = AppRouter();
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, currentTheme){
        return MaterialApp.router(
          themeMode: currentTheme,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          title: "Health IA Coach",
          routerConfig: appRouter.router,
        );
      }
    );
  }
}

