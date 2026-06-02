import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../extensions/l10n_extension.dart';
import '../../cubits/theme_cubit.dart';

class SwitchThemeButton extends StatefulWidget {
  const SwitchThemeButton({super.key});

  @override
  State<SwitchThemeButton> createState() => _SwitchThemeButtonState();
}

class _SwitchThemeButtonState extends State<SwitchThemeButton> {
  @override
  Widget build(BuildContext context) {
    final ThemeMode currentMode = context.watch<ThemeCubit>().state;
    return SafeArea(
      child: SegmentedButton<ThemeMode>(
        emptySelectionAllowed: false,
        segments: [
          ButtonSegment(
            value: ThemeMode.system,
            label: Text(context.l10n.themeSystemName),
            icon: Icon(Icons.settings_brightness_outlined),
          ),
          ButtonSegment(
            value: ThemeMode.light,
            label: Text(context.l10n.themeLightName),
            icon: Icon(Icons.light_mode_outlined),
          ),
          ButtonSegment(
            value: ThemeMode.dark,
            label: Text(context.l10n.themeDarkName),
            icon: Icon(Icons.dark_mode_outlined),
          ),
        ],
        selected: {currentMode},
        onSelectionChanged: (Set<ThemeMode> newSelection) {
          context.read<ThemeCubit>().setTheme(newSelection.first);
        },
      ),
    );
  }
}
