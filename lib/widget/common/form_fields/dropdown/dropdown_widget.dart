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
    required this.validator,
    this.isEnable = true,
  });

  final String labelText;
  final List<Map<String, String>> items;
  final String selectedItem;
  final bool? isEnable;
  final AppColorScheme appColorScheme;
  final Function onChanged;
  final Function validator;

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
          child: Text(labelText, style: Theme.of(context).textTheme.labelSmall),
        ),
        DropdownButtonFormField(
          key: key,
          isDense: true,
          isExpanded: true,
          dropdownColor: themeData.offWhite,
          validator: (String? value) => validator(value),
          icon: Icon(
            Icons.arrow_drop_down_rounded,
            color: themeData.calPolyPomonaGreen,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            errorStyle: TextStyle(color: themeData.metallicRed),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    setDropdownColor(
                          context: context,
                          appColorScheme: appColorScheme,
                        )
                        as Color,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    setDropdownColor(
                          context: context,
                          appColorScheme: appColorScheme,
                        )
                        as Color,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    setDropdownColor(
                          context: context,
                          appColorScheme: appColorScheme,
                        )
                        as Color,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeData.metallicRed as Color),
            ),
            filled: true,
            fillColor: themeData.offWhite,
          ),
          items:
              items.isNotEmpty
                  ? [
                    DropdownMenuItem(
                      value: "",
                      enabled: isEnable ?? true,
                      child: Text(
                        "select option".toUpperCase(),
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: setDropdownColor(
                            context: context,
                            appColorScheme: appColorScheme,
                          ),
                        ),
                      ),
                    ),
                    ...items.toSet().toList().map((Map<String, String> item) {
                      return DropdownMenuItem(
                        value: item['value'],
                        enabled: isEnable ?? true,
                        child: Text(
                          item['label']!.toUpperCase(),
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium!.copyWith(
                            fontWeight:
                                selectedItem == item['value']
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color: setDropdownColor(
                              context: context,
                              appColorScheme: appColorScheme,
                            ),
                          ),
                        ),
                      );
                    }),
                  ]
                  : [
                    DropdownMenuItem(
                      value: "",
                      enabled: isEnable ?? true,
                      child: Text(
                        "select option".toUpperCase(),
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.normal,
                          color: setDropdownColor(
                            context: context,
                            appColorScheme: appColorScheme,
                          ),
                        ),
                      ),
                    ),
                  ],
          value:
              items.isEmpty
                  ? ""
                  : items.indexWhere((item) => item['value'] == selectedItem) ==
                      -1
                  ? ""
                  : selectedItem,
          onChanged:
              isEnable == true
                  ? (String? selectedItem) {
                    onChanged(selectedItem);
                  }
                  : null,
        ),
      ],
    );
  }
}
