import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.appColorScheme,
    this.disabled = false,
  });

  final String buttonText;
  final Function onPressed;
  final AppColorScheme appColorScheme;
  final bool? disabled;

  ElevatedButtonThemeData? setElevatedButtonThemeData({
    required BuildContext context,
    required AppColorScheme appColorScheme,
  }) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;

    switch (appColorScheme) {
      case AppColorScheme.primary:
        return themeData.eerieBlackElevatedButtonThemeData;
      case AppColorScheme.secondary:
        return themeData.calPolyPomonaGreenElevatedButtonThemeData;
    }
  }

  void elevatedButtonPressed() {
    HapticFeedback.heavyImpact();
    onPressed();
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButtonTheme(
        data: setElevatedButtonThemeData(
          context: context,
          appColorScheme: appColorScheme,
        ) as ElevatedButtonThemeData,
        child: ElevatedButton(
          onPressed: (disabled == null || disabled == true)
              ? null
              : () => elevatedButtonPressed(),
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: themeData.offWhite,
                ),
          ),
        ),
      ),
    );
  }
}
