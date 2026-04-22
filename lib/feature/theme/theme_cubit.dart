import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeCubit extends Cubit<ThemeMode>{
  static const String _themeKey= 'user_theme';

  ThemeCubit() : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final preference = await SharedPreferences.getInstance();
    final savedIndex = preference.getInt(_themeKey);

    if (savedIndex != null){
      emit(ThemeMode.values[savedIndex]);
    }

  }

  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    emit(newMode);

    final preference = await SharedPreferences.getInstance();
    await preference.setInt(_themeKey, newMode.index);
  }
}