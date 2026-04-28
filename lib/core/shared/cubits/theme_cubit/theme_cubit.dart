import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../logging/logger_mixin.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> with LoggerMixin {
  @override
  String get loggerName => 'Core.Shared.Cubits.ThemeCubit';

  ThemeCubit() : super(ThemeMode.system) {
    logger.info('ThemeCubit initialized with mode: ${state.name}');
  }

  Future<void> setTheme(ThemeMode mode) async {
    emit(mode);
    logger.info('Theme mode set to: ${mode.name}');
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final index = json['theme_mode'] as int?;
    ThemeMode restored;
    if (index != null && index >= 0 && index < ThemeMode.values.length) {
      restored = ThemeMode.values[index];
      logger.fine('Theme mode restored from storage: ${restored.name}');
    } else {
      restored = ThemeMode.system;
      logger.warning(
        'Invalid theme mode index in storage, defaulting to system',
      );
    }
    return restored;
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    logger.fine('Persisting theme mode to storage: ${state.name}');
    return {'theme_mode': state.index};
  }
}
