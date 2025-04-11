import 'package:flutter/material.dart';
import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class FloatingTextFieldWidget extends StatelessWidget {
  const FloatingTextFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
    required this.appColorScheme,
    required this.onChange,
    required this.onFieldSubmitted,
    required this.validator,
    this.obscureText = false,
    this.textInputType = TextInputType.multiline,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
  });

  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final AppColorScheme appColorScheme;
  final Function onChange;
  final Function onFieldSubmitted;
  final Function validator;

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

    return TextFormField(
      key: key,
      controller: controller,
      onChanged: (String value) => onChange(value),
      onFieldSubmitted: (String value) => onFieldSubmitted(value),
      onEditingComplete: () {},
      onSaved: (String? value) {},
      validator: (String? value) => validator(value),
      obscureText: obscureText,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      keyboardType: textInputType,
      cursorColor:
          setFloatingTextFieldColor(
                context: context,
                appColorScheme: appColorScheme,
              )
              as Color,
      style: TextStyle(
        color:
            setFloatingTextFieldColor(
                  context: context,
                  appColorScheme: appColorScheme,
                )
                as Color,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color:
              setFloatingTextFieldColor(
                    context: context,
                    appColorScheme: appColorScheme,
                  )
                  as Color,
        ),
        border: OutlineInputBorder(),
        errorStyle: TextStyle(color: themeData.metallicRed),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                setFloatingTextFieldColor(
                      context: context,
                      appColorScheme: appColorScheme,
                    )
                    as Color,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                setFloatingTextFieldColor(
                      context: context,
                      appColorScheme: appColorScheme,
                    )
                    as Color,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                setFloatingTextFieldColor(
                      context: context,
                      appColorScheme: appColorScheme,
                    )
                    as Color,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: themeData.metallicRed as Color),
        ),
      ),
    );
  }
}
