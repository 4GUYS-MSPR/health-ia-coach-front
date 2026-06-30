import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../extensions/l10n_extension.dart';
import '../../../utils/locale_utils.dart';
import '../../cubits/locale_cubit/locale_cubit.dart';

class SelectLocaleDialog extends StatelessWidget {
  const SelectLocaleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.settingsAppLanguageTitle),
      contentPadding: .only(top: 16),
      content: SizedBox(
        width: .maxFinite,
        child: BlocBuilder<LocaleCubit, Locale?>(
          builder: (context, selectedLocale) {
            return RadioGroup<Locale>(
              onChanged: (Locale? newLocale) {
                if (newLocale != null) {
                  context.read<LocaleCubit>().setLocale(newLocale);
                }
              },
              groupValue: selectedLocale,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: LocaleUtils.supportedLocales.length,
                itemBuilder: (context, index) {
                  final Locale locale = LocaleUtils.supportedLocales[index];
                  return RadioListTile(
                    value: locale,
                    secondary: CountryFlag.fromLanguageCode(
                      locale.languageCode,
                      theme: ImageTheme(
                        shape: RoundedRectangle(4),
                        width: 32,
                        height: 20,
                      ),
                    ),
                    controlAffinity: .trailing,
                    contentPadding: .symmetric(horizontal: 24),
                    title: Text(LocaleUtils.getLanguageNativeName(locale)),
                  );
                },
              ),
            );
          },
        ),
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
