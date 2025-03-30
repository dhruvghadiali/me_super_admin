import 'package:flutter/material.dart';

class ElevationButtonThemeConfig {
  static ElevatedButtonThemeData elevatedButtonThemeData(
    Color backgroundColor,
  ) {
    const double elevatedButtonPadding = 15.0;
    const double elevatedButtonBorderRadius = 5.0;
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(backgroundColor),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(vertical: elevatedButtonPadding),
        ),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(elevatedButtonBorderRadius),
          ),
        ),
      ),
    );
  }
}
