import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/locale_utils.dart';
import '../cubits/locale_cubit/locale_cubit.dart';


class LocaleDropdown extends StatelessWidget {
  const LocaleDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale?>(
      builder: (context, currentLocale) {
        return DropdownButton(
          value: currentLocale,
          isDense: true,
          underline: Container(),
          menuWidth: 150,
          items: getDropdownItems(),
          selectedItemBuilder: getSelectedItem,
          onChanged: (newLocale) {
            if (newLocale != null) {
              context.read<LocaleCubit>().setLocale(newLocale);
            }
          },
        );
      },
    );
  }

  List<Widget> getSelectedItem(BuildContext context) {
    return LocaleUtils.supportedLocales
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: CountryFlag.fromLanguageCode(
              e.languageCode,
              theme: const ImageTheme(
                width: 30,
                height: 20,
                shape: RoundedRectangle(3),
              ),
            ),
          ),
        )
        .toList();
  }

  List<DropdownMenuItem<Locale>> getDropdownItems() {
    return LocaleUtils.supportedLocales
        .map(
          (e) => DropdownMenuItem(
            value: e,
            child: Row(
              mainAxisSize: .min,
              spacing: 8,
              children: [
                CountryFlag.fromLanguageCode(
                  e.languageCode,
                  theme: const ImageTheme(
                    width: 30,
                    height: 20,
                    shape: RoundedRectangle(3),
                  ),
                ),
                Text(LocaleUtils.getLanguageNativeName(e)),
              ],
            ),
          ),
        )
        .toList();
  }
}
