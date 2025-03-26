import 'package:flutter/material.dart';
import 'package:me_super_admin/app_enum.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onChange,
    required this.appColorScheme,
    this.subtitle = '',
  });

  final String title;
  final String? subtitle;
  final bool isSelected;
  final Function onChange;
  final AppColorScheme appColorScheme;

  Color? setActiveColor({
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
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: const EdgeInsets.all(0),
      activeColor: setActiveColor(
        context: context,
        appColorScheme: appColorScheme,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: setActiveColor(
                context: context,
                appColorScheme: appColorScheme,
              ),
            ),
      ),
      subtitle: subtitle!.isNotEmpty
          ? Text(
              subtitle ?? '',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    color: setActiveColor(
                      context: context,
                      appColorScheme: appColorScheme,
                    ),
                  ),
            )
          : null,
      value: isSelected,
      onChanged: (bool? value) => onChange(value),
    );
  }
}
