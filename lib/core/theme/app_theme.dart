import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF000000);
  static const Color secondary = Color(0xFF282A25);
  static const Color tertiary = Color(0xFFA5C57F);

  //Couleurs de fond
  static const Color background = Color(0xFF000000);
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color surfaceDark = Color(0xFF000000);
  static const Color surfaceLight = Color(0xFFF9FAFB);



  //Couleurs des textes
  static const Color textPrimary = Color(0xFFF9FAFB);
  static const Color textPrimaryDark = Color(0xFF000000);
  static const Color textSecondary = Color(0xFFD1D5DB);
  static const Color textSecondaryDark = Color(0xFF000000);
  static const Color textTertiary = Color(0xff8a9579);
  static const Color textTertiaryDark= Color(0xff8a9579);



  //Couleurs systeme
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);

  //Theme sombre
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      surface: surfaceDark,
      error: error,
    ),

    elevatedButtonTheme: _elevatedBtn(),
    textTheme: _buildTextTheme(textPrimary, textSecondary, textTertiary),

  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: secondary,
      tertiary: tertiary,
      surface: surfaceLight,
      error: error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onTertiary: Colors.white,
      onSurface: textPrimary,
    ),

    elevatedButtonTheme: _elevatedBtn(),
    textTheme: _buildTextTheme(textPrimaryDark, textSecondaryDark, textTertiary),


  );

  static ElevatedButtonThemeData _elevatedBtn() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: tertiary,
        foregroundColor: primary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  // Helper pour ne pas répéter la configuration typo
  static TextTheme _buildTextTheme(Color pColor, Color sColor, Color tColor) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: pColor,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: pColor,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: pColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: pColor,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: pColor,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: pColor,
      ),
      titleLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: pColor,
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: pColor,
      ),
      titleSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: pColor,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: pColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: sColor,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: sColor,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: sColor,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: sColor,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: tColor,
      ),
    );
  }





}

