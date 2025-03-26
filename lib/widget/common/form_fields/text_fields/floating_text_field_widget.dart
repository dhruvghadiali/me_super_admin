import 'package:flutter/material.dart';
import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class FloatingTextFieldWidget extends StatelessWidget {
  const FloatingTextFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
    required this.showError,
    required this.appColorScheme,
    required this.onChange,
    required this.onSubmitted,
    this.obscureText = false,
    this.textInputType = TextInputType.multiline,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
  });

  final String labelText;
  final bool obscureText;
  final bool showError;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final AppColorScheme appColorScheme;
  final Function onChange;
  final Function onSubmitted;

  Color? setFloatingTextFieldColor({
    required BuildContext context,
    required AppColorScheme appColorScheme,
  }) {
    switch (appColorScheme) {
      case AppColorScheme.primary:
        return Theme.of(context).colorScheme.primary;
      case AppColorScheme.secondary:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;

    return TextField(
      controller: controller,
      onChanged: (String value) => onChange(value),
      onSubmitted: (String value) => onSubmitted(value),
      obscureText: obscureText,
      textInputAction: textInputAction,
      cursorColor: setFloatingTextFieldColor(
        context: context,
        appColorScheme: appColorScheme,
      ),
      style: TextStyle(
        color: setFloatingTextFieldColor(
          context: context,
          appColorScheme: appColorScheme,
        ),
      ),
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      keyboardType: textInputType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: showError
              ? themeData.metallicRed
              : setFloatingTextFieldColor(
                  context: context,
                  appColorScheme: appColorScheme,
                ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: showError
                ? themeData.metallicRed as Color
                : setFloatingTextFieldColor(
                    context: context,
                    appColorScheme: appColorScheme,
                  ) as Color,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: showError
                ? themeData.metallicRed as Color
                : setFloatingTextFieldColor(
                    context: context,
                    appColorScheme: appColorScheme,
                  ) as Color,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
