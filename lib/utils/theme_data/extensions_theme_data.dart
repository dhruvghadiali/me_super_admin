import 'package:flutter/material.dart';

@immutable
class ExtensionsThemeData extends ThemeExtension<ExtensionsThemeData> {
  const ExtensionsThemeData({
    required this.eerieBlack,
    required this.calPolyPomonaGreen,
    required this.isabelline,
    required this.metallicRed,
    required this.harvestGold,
    required this.eerieBlackElevatedButtonThemeData,
    required this.calPolyPomonaGreenElevatedButtonThemeData,
    required this.metallicRedElevatedButtonThemeData,
    required this.harvestGoldElevatedButtonThemeData,
  });

  final Color? eerieBlack;
  final Color? calPolyPomonaGreen;
  final Color? isabelline;
  final Color? metallicRed;
  final Color? harvestGold;
  final ElevatedButtonThemeData? eerieBlackElevatedButtonThemeData;
  final ElevatedButtonThemeData? calPolyPomonaGreenElevatedButtonThemeData;
  final ElevatedButtonThemeData? metallicRedElevatedButtonThemeData;
  final ElevatedButtonThemeData? harvestGoldElevatedButtonThemeData;

  @override
  ExtensionsThemeData copyWith({
    Color? eerieBlack,
    Color? calPolyPomonaGreen,
    Color? isabelline,
    Color? metallicRed,
    Color? harvestGold,
    ElevatedButtonThemeData? eerieBlackElevatedButtonThemeData,
    ElevatedButtonThemeData? calPolyPomonaGreenElevatedButtonThemeData,
    ElevatedButtonThemeData? metallicRedElevatedButtonThemeData,
    ElevatedButtonThemeData? harvestGoldElevatedButtonThemeData,
  }) {
    return ExtensionsThemeData(
      eerieBlack: eerieBlack ?? eerieBlack,
      calPolyPomonaGreen: calPolyPomonaGreen ?? calPolyPomonaGreen,
      isabelline: isabelline ?? isabelline,
      metallicRed: metallicRed ?? metallicRed,
      harvestGold: harvestGold ?? harvestGold,
      eerieBlackElevatedButtonThemeData: eerieBlackElevatedButtonThemeData ??
          eerieBlackElevatedButtonThemeData,
      calPolyPomonaGreenElevatedButtonThemeData:
          calPolyPomonaGreenElevatedButtonThemeData ??
              calPolyPomonaGreenElevatedButtonThemeData,
      metallicRedElevatedButtonThemeData: metallicRedElevatedButtonThemeData ??
          metallicRedElevatedButtonThemeData,
      harvestGoldElevatedButtonThemeData: harvestGoldElevatedButtonThemeData ??
          harvestGoldElevatedButtonThemeData,
    );
  }

  @override
  ExtensionsThemeData lerp(
      ThemeExtension<ExtensionsThemeData>? other, double t) {
    if (other is! ExtensionsThemeData) {
      return this;
    }
    return ExtensionsThemeData(
      eerieBlack: Color.lerp(eerieBlack, other.eerieBlack, t),
      calPolyPomonaGreen:
          Color.lerp(calPolyPomonaGreen, other.calPolyPomonaGreen, t),
      isabelline: Color.lerp(isabelline, other.isabelline, t),
      metallicRed: Color.lerp(metallicRed, other.metallicRed, t),
      harvestGold: Color.lerp(harvestGold, other.harvestGold, t),
      eerieBlackElevatedButtonThemeData: ElevatedButtonThemeData.lerp(
        eerieBlackElevatedButtonThemeData,
        other.eerieBlackElevatedButtonThemeData,
        t,
      ),
      calPolyPomonaGreenElevatedButtonThemeData: ElevatedButtonThemeData.lerp(
        calPolyPomonaGreenElevatedButtonThemeData,
        other.calPolyPomonaGreenElevatedButtonThemeData,
        t,
      ),
      metallicRedElevatedButtonThemeData: ElevatedButtonThemeData.lerp(
        metallicRedElevatedButtonThemeData,
        other.metallicRedElevatedButtonThemeData,
        t,
      ),
      harvestGoldElevatedButtonThemeData: ElevatedButtonThemeData.lerp(
        harvestGoldElevatedButtonThemeData,
        other.harvestGoldElevatedButtonThemeData,
        t,
      ),
    );
  }
}
