import 'package:flutter/material.dart';
import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({
    super.key,
    required this.labelText,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.appColorScheme,
    this.isEnable = true,
  });

  final String labelText;
  final List<Map<String, String>> items;
  final String selectedItem;
  final bool? isEnable;
  final AppColorScheme appColorScheme;
  final Function onChanged;

  Color? setDropdownColor({
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Text(
            labelText,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        DropdownButtonFormField(
          isDense: true,
          isExpanded: true,
          dropdownColor: themeData.isabelline,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: setDropdownColor(
                  context: context,
                  appColorScheme: appColorScheme,
                ) as Color,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: setDropdownColor(
                  context: context,
                  appColorScheme: appColorScheme,
                ) as Color,
                width: 1,
              ),
            ),
            filled: true,
            fillColor: themeData.isabelline,
          ),
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: themeData.calPolyPomonaGreen,
          ),
          items: items.toSet().toList().map(
            (Map<String, String> item) {
              return DropdownMenuItem(
                value: item['value'],
                enabled: isEnable ?? true,
                child: Text(
                  item['label']!.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: selectedItem == item['value']
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: setDropdownColor(
                          context: context,
                          appColorScheme: appColorScheme,
                        ),
                      ),
                ),
              );
            },
          ).toList(),
          value: items.indexWhere((item) => item['value'] == selectedItem) == -1
              ? items[0]['value']
              : selectedItem,
          onChanged: (String? selectedItem) {
            onChanged(selectedItem ?? items[0]['value']);
          },
        ),
      ],
    );
  }
}
