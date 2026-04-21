import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, currentTheme){
        return MaterialApp(
          themeMode: currentTheme,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: Scaffold(
            body: Center(
              
            )
          ),

        );
      }
    );
  }
}

