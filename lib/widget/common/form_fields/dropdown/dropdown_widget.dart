import 'package:flutter/material.dart';
import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/l10n/app_localizations.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';

/*
 * DropdownWidget is a customizable dropdown form field widget that supports both single and multi-selection modes.
 *
 * Features:
 * - Displays a label and a dropdown list of items.
 * - Supports single or multiple selection (controlled by multiSelection parameter).
 * - Customizable color scheme and validation.
 * - Shows selected items as a comma-separated string in multi-selection mode.
 * - Handles enabling/disabling and custom field keys.
 *
 * Parameters:
 * - labelText: The label displayed above the dropdown.
 * - items: List of items to display, each as a map with 'label' and 'value'.
 * - selectedItem: The currently selected value(s) as a string (comma-separated for multi-selection).
 * - onChanged: Callback when the selection changes.
 * - appColorScheme: Enum to control color scheme.
 * - validator: Function to validate the selected value(s).
 * - isEnable: Whether the dropdown is enabled (default: true).
 * - multiSelection: Enables multi-selection mode if true (default: false).
 * - fieldKey: Optional key for the form field.
 */
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
    this.multiSelection = false,
    this.fieldKey,
  });

  final String labelText;
  final List<Map<String, String>> items;
  final String selectedItem;
  final bool? isEnable;
  final bool? multiSelection;
  final GlobalKey<FormFieldState>? fieldKey;
  final AppColorScheme appColorScheme;
  final Function onChanged;
  final Function validator;

  /*
   * Returns the color for the dropdown border and text based on the app color scheme.
   *
   * @param context The build context.
   * @param appColorScheme The color scheme to use.
   * @return The color for the dropdown.
   */
  Color? setDropdownColor({required BuildContext context, required AppColorScheme appColorScheme}) {
    switch (appColorScheme) {
      case AppColorScheme.primary:
        return Theme.of(context).colorScheme.primary;
      case AppColorScheme.secondary:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  /*
   * Returns a styled label for each dropdown item, bold if selected.
   *
   * @param context The build context.
   * @param label The label text to display.
   * @param value The value of the dropdown item.
   * @param selectedItem The currently selected item(s).
   * @return A styled Text widget for the dropdown item.
   */
  Widget setDropdownLabel({
    required BuildContext context,
    required String label,
    required String value,
    required String selectedItem,
  }) {
    return Text(
      label.toUpperCase(),
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        fontWeight:
            (multiSelection!
                    ? selectedItem.split(',').indexWhere((data) => data == value) != -1
                    : selectedItem == value)
                ? FontWeight.bold
                : FontWeight.normal,
        color: setDropdownColor(context: context, appColorScheme: appColorScheme),
      ),
    );
  }

  /*
   * Returns a styled label for the selected item(s) in the dropdown button.
   *
   * @param context The build context.
   * @param label The label text to display.
   * @param isSelected Whether the item is selected.
   * @return A styled Text widget for the selected item(s).
   */
  Widget setSelectedItemLabel({
    required BuildContext context,
    required String label,
    required bool isSelected,
  }) {
    return Text(
      label.toUpperCase(),
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: setDropdownColor(context: context, appColorScheme: appColorScheme),
      ),
    );
  }

  /*
   * Handles selection changes for both single and multi-selection modes.
   *
   * For multi-selection, toggles the selected option in the list and updates the parent via onChanged.
   * For single selection, simply calls onChanged with the selected option.
   *
   * @param selectedOption The value selected by the user.
   */
  void onDropDownSelectionChanged(String? selectedOption) {
    if (multiSelection!) {
      if (selectedOption!.isNotEmpty) {
        List<String> selectedItems = setSelectedItems();
        if (selectedItems.indexWhere((item) => item == selectedOption) != -1) {
          selectedItems.remove(selectedOption);
        } else {
          selectedItems.add(selectedOption);
        }
        String newSelectedItem = selectedItems.join(',');
        onChanged(newSelectedItem);
      }
    } else {
      onChanged(selectedOption);
    }
  }

  /*
   * Returns a list of selected item values (for multi-selection mode).
   *
   * Splits the selectedItem string by comma and removes any empty items.
   *
   * @return List<String> of selected values.
   */
  List<String> setSelectedItems() {
    List<String> selectedItems = selectedItem.split(',');
    selectedItems.removeWhere((item) => item.isEmpty);
    return selectedItems;
  }

  /*
   * Builds the dropdown widget UI, including label, dropdown field, and menu items.
   *
   * @param context The build context.
   * @return The widget tree for the dropdown.
   */
  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Label above the dropdown
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Text(labelText, style: Theme.of(context).textTheme.labelSmall),
        ),
        // Dropdown form field
        DropdownButtonFormField(
          key: fieldKey ?? key,
          isDense: true,
          isExpanded: true,
          dropdownColor: themeData.offWhite,
          validator:
              (String? value) => validator(
                multiSelection!
                    ? selectedItem.isEmpty
                        ? value
                        : "$selectedItem,$value"
                    : value,
              ), // Validation function
          icon: Icon(Icons.arrow_drop_down_rounded, color: themeData.calPolyPomonaGreen),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            errorStyle: TextStyle(color: themeData.metallicRed),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: setDropdownColor(context: context, appColorScheme: appColorScheme) as Color,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: setDropdownColor(context: context, appColorScheme: appColorScheme) as Color,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: setDropdownColor(context: context, appColorScheme: appColorScheme) as Color,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: themeData.metallicRed as Color),
            ),
            filled: true,
            fillColor: themeData.offWhite,
          ),
          // The value to display in the dropdown button
          value:
              items.isEmpty
                  ? ""
                  : items.indexWhere((item) => item['value'] == selectedItem) == -1
                  ? ""
                  : selectedItem,
          // Custom builder for the selected item label (shows count for multi-selection)
          selectedItemBuilder: (BuildContext context) {
            String label = appLocalizations.selectDropdownOptionText;
            bool isSelected = false;
            if (multiSelection!) {
              isSelected = setSelectedItems().isNotEmpty;
              label =
                  setSelectedItems().isNotEmpty
                      ? "${setSelectedItems().length} ${appLocalizations.selectedDropdownItemsText}"
                      : appLocalizations.selectDropdownOptionsText;
            } else {
              int index = items.indexWhere((item) => item['value'] == selectedItem);
              if (index != -1) {
                isSelected = true;
                label = items[index]['label'] ?? appLocalizations.selectDropdownOptionText;
              }
            }
            return items.isNotEmpty
                ? [
                  setSelectedItemLabel(context: context, label: label, isSelected: isSelected),
                  ...items.map(
                    (item) => setSelectedItemLabel(
                      context: context,
                      label: label,
                      isSelected: isSelected,
                    ),
                  ),
                ]
                : [setSelectedItemLabel(context: context, label: label, isSelected: isSelected)];
          },
          // Dropdown menu items
          items:
              items.isNotEmpty
                  ? [
                    DropdownMenuItem(
                      value: "",
                      enabled: isEnable ?? true,
                      child:
                          multiSelection!
                              ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      selectedItem.split(',').indexWhere((data) => data == "") != -1
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank,
                                    ),
                                  ),
                                  Expanded(
                                    child: setDropdownLabel(
                                      context: context,
                                      label: appLocalizations.selectDropdownOptionText,
                                      value: "",
                                      selectedItem: selectedItem,
                                    ),
                                  ),
                                ],
                              )
                              : setDropdownLabel(
                                context: context,
                                label: appLocalizations.selectDropdownOptionText,
                                value: "",
                                selectedItem: selectedItem,
                              ),
                    ),
                    ...items.toSet().toList().map((Map<String, String> item) {
                      return DropdownMenuItem(
                        value: item['value'],
                        enabled: isEnable ?? true,
                        child:
                            multiSelection!
                                ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        selectedItem
                                                    .split(',')
                                                    .indexWhere((data) => data == item['value']) !=
                                                -1
                                            ? Icons.check_box
                                            : Icons.check_box_outline_blank,
                                      ),
                                    ),
                                    Expanded(
                                      child: setDropdownLabel(
                                        context: context,
                                        label: item['label'] ?? "",
                                        value: item['value'] ?? "",
                                        selectedItem: selectedItem,
                                      ),
                                    ),
                                  ],
                                )
                                : setDropdownLabel(
                                  context: context,
                                  label: item['label'] ?? "",
                                  value: item['value'] ?? "",
                                  selectedItem: selectedItem,
                                ),
                      );
                    }),
                  ]
                  : [
                    DropdownMenuItem(
                      value: "",
                      enabled: isEnable ?? true,
                      child: setDropdownLabel(
                        context: context,
                        label: appLocalizations.selectDropdownOptionText,
                        value: "",
                        selectedItem: selectedItem,
                      ),
                    ),
                  ],
          // Handles selection changes
          onChanged:
              isEnable == true
                  ? (String? selectedOption) => onDropDownSelectionChanged(selectedOption)
                  : null,
        ),
      ],
    );
  }
}
