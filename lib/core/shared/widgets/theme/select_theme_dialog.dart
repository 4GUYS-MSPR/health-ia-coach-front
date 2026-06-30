import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../extensions/l10n_extension.dart';
import '../../cubits/theme_cubit/theme_cubit.dart';

class SelectThemeDialog extends StatelessWidget {
  const SelectThemeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.settingsAppThemeTitle),
      contentPadding: .only(top: 16),
      content: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return RadioGroup<ThemeMode>(
            onChanged: (newTheme) {
              if (newTheme != null) {
                context.read<ThemeCubit>().setTheme(newTheme);
              }
            },
            groupValue: themeMode,
            child: Column(
              mainAxisSize: .min,
              children: [
                RadioListTile(
                  value: ThemeMode.system,
                  secondary: Icon(Symbols.routine),
                  controlAffinity: .trailing,
                  contentPadding: .symmetric(horizontal: 24),
                  title: Text(context.l10n.themeSystemName),
                ),
                RadioListTile(
                  value: ThemeMode.dark,
                  secondary: Icon(Symbols.dark_mode),
                  controlAffinity: .trailing,
                  contentPadding: .symmetric(horizontal: 24),
                  title: Text(context.l10n.themeDarkName),
                ),
                RadioListTile(
                  value: ThemeMode.light,
                  secondary: Icon(Symbols.light_mode),
                  controlAffinity: .trailing,
                  contentPadding: .symmetric(horizontal: 24),
                  title: Text(context.l10n.themeLightName),
                ),
              ],
            ),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(context.l10n.settingsValidateButton),
        ),
      ],
    );
  }
}
