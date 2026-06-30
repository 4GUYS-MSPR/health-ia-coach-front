import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  void setTheme(ThemeMode mode) => emit(mode);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final index = json['theme_mode'] as int?;
    if (index != null) {
      return ThemeMode.values[index];
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {"user_theme": state.index};
  }
}
