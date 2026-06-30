import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../extensions/l10n_extension.dart';
import '../../cubits/theme_cubit/theme_cubit.dart';

class SwitchThemeButton extends StatelessWidget {
  const SwitchThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    void onSelectionChanged(Set<ThemeMode> p1) {
      context.read<ThemeCubit>().setTheme(p1.first);
    }

    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, state) {
        return SegmentedButton<ThemeMode>(
          emptySelectionAllowed: false,
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: .system,
              label: Text(context.l10n.themeSystemName),
              icon: const Icon(Symbols.routine),
            ),
            ButtonSegment(
              value: .light,
              label: Text(context.l10n.themeLightName),
              icon: const Icon(Symbols.light_mode),
            ),
            ButtonSegment(
              value: .dark,
              label: Text(context.l10n.themeDarkName),
              icon: const Icon(Symbols.dark_mode),
            ),
          ],
          selected: {state},
          onSelectionChanged: onSelectionChanged,
        );
      },
    );
  }
}
