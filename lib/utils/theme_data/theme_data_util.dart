import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/utils/theme_data/elevation_button_theme_config.dart';
class ThemeDataUtil {
  static Color eerieBlack = const Color(0xFF191825);
  static Color calPolyPomonaGreen = const Color(0xFF285430);
  static Color offWhite = const Color(0xFFF0EEED);
  static Color metallicRed = const Color(0xFFA93226);
  static Color harvestGold = const Color(0xFFD68910);
  static ElevatedButtonThemeData eerieBlackElevatedButtonThemeData = ElevationButtonThemeConfig.elevatedButtonThemeData(eerieBlack);
  static ElevatedButtonThemeData calPolyPomonaGreenElevatedButtonThemeData = ElevationButtonThemeConfig.elevatedButtonThemeData(calPolyPomonaGreen);
  static ElevatedButtonThemeData metallicRedElevatedButtonThemeData = ElevationButtonThemeConfig.elevatedButtonThemeData(metallicRed);
  static ElevatedButtonThemeData harvestGoldElevatedButtonThemeData = ElevationButtonThemeConfig.elevatedButtonThemeData(harvestGold);

  static ThemeData theme = ThemeData(
    primaryColor: offWhite,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: eerieBlack,
      onPrimary: eerieBlack,
      secondary: calPolyPomonaGreen,
      onSecondary: calPolyPomonaGreen,
      error: metallicRed,
      onError: metallicRed,
      surface: eerieBlack,
      onSurface: eerieBlack,
    ),
    scaffoldBackgroundColor: offWhite,
    textTheme: textTheme,
    extensions: [
      ExtensionsThemeData(
        eerieBlack: eerieBlack,
        calPolyPomonaGreen: calPolyPomonaGreen,
        offWhite: offWhite,
        metallicRed: metallicRed,
        harvestGold: harvestGold,
        eerieBlackElevatedButtonThemeData: eerieBlackElevatedButtonThemeData,
        calPolyPomonaGreenElevatedButtonThemeData:
            calPolyPomonaGreenElevatedButtonThemeData,
        metallicRedElevatedButtonThemeData: metallicRedElevatedButtonThemeData,
        harvestGoldElevatedButtonThemeData: harvestGoldElevatedButtonThemeData,
      ),
    ],
  );

  static TextTheme textTheme = TextTheme(
    bodyLarge: TextStyle(
      color: eerieBlack,
    ),
    bodyMedium: TextStyle(
      color: eerieBlack,
    ),
    bodySmall: TextStyle(
      color: eerieBlack,
    ),
    displayMedium: TextStyle(
      color: eerieBlack,
    ),
    displayLarge: TextStyle(
      color: eerieBlack,
    ),
    displaySmall: TextStyle(
      color: eerieBlack,
    ),
    headlineLarge: TextStyle(
      color: eerieBlack,
    ),
    headlineMedium: TextStyle(
      color: eerieBlack,
    ),
    headlineSmall: TextStyle(
      color: eerieBlack,
    ),
    labelLarge: TextStyle(
      color: eerieBlack,
    ),
    labelMedium: TextStyle(
      color: eerieBlack,
    ),
    labelSmall: TextStyle(
      color: eerieBlack,
    ),
    titleLarge: TextStyle(
      color: eerieBlack,
    ),
    titleMedium: TextStyle(
      color: eerieBlack,
    ),
    titleSmall: TextStyle(
      color: eerieBlack,
    ),
  );
}
