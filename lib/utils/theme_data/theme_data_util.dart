import 'package:flutter/material.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class ThemeDataUtil {
  static double elevatedButtonPadding = 15.0;
  static Color eerieBlack = const Color(0xFF191825);
  static Color calPolyPomonaGreen = const Color(0xFF285430);
  static Color isabelline = const Color(0xFFF0EEED);
  static Color metallicRed = const Color(0xFFA93226);
  static Color harvestGold = const Color(0xFFD68910);
  static ElevatedButtonThemeData eerieBlackElevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll<Color>(eerieBlack),
      padding: WidgetStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(vertical: elevatedButtonPadding),
      ),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    ),
  );
  static ElevatedButtonThemeData calPolyPomonaGreenElevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll<Color>(calPolyPomonaGreen),
      padding: WidgetStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(vertical: elevatedButtonPadding),
      ),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    ),
  );
  static ElevatedButtonThemeData metallicRedElevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll<Color>(metallicRed),
      padding: WidgetStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(vertical: elevatedButtonPadding),
      ),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    ),
  );
  static ElevatedButtonThemeData harvestGoldElevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll<Color>(harvestGold),
      padding: WidgetStateProperty.all<EdgeInsets>(
        EdgeInsets.symmetric(vertical: elevatedButtonPadding),
      ),
      shape: WidgetStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    ),
  );

  static ThemeData theme = ThemeData(
    primaryColor: isabelline,
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
    scaffoldBackgroundColor: isabelline,
    textTheme: textTheme,
    extensions: [
      ExtensionsThemeData(
        eerieBlack: eerieBlack,
        calPolyPomonaGreen: calPolyPomonaGreen,
        isabelline: isabelline,
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
