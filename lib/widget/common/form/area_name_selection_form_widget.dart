import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/model/area_name/area_name.dart';
import 'package:me_super_admin/controller/area_name/area_name_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/dropdown/dropdown_widget.dart';

class AreaNameSelectionFormWidget extends StatelessWidget {
  const AreaNameSelectionFormWidget({
    super.key,
    required this.formFieldKey,
    required this.selectedCity,
    required this.selectedAreaName,

    required this.onChange,
    required this.validator,
  });

  final City selectedCity;
  final AreaName selectedAreaName;
  final GlobalKey<FormFieldState> formFieldKey;

  final Function validator;
  final Function onChange;

  void onAreaNameChange(String value, List<AreaName> areaNames) {
    if (value != selectedAreaName.id) {
      AreaName areaNameInfo = AreaName.defaultValues();
      areaNameInfo = areaNameInfo.copyWith(city: selectedCity);

      if (value.isNotEmpty) {
        areaNameInfo = areaNames.firstWhere((areaName) => areaName.id == value);
      }

      onChange(areaNameInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return GetBuilder<AreaNameController>(
      builder: (areaNameControllerContext) {
        return DropdownWidget(
          key: formFieldKey,
          validator: validator,
          isEnable: selectedCity.id.isNotEmpty,
          labelText: appLocalizations.areaNameDropdownFieldLabelText,
          selectedItem: selectedAreaName.id,
          appColorScheme: AppColorScheme.primary,
          onChanged:
              (String value) =>
                  onAreaNameChange(value, areaNameControllerContext.areaNames),
          items:
              areaNameControllerContext.areaNames.isEmpty
                  ? []
                  : areaNameControllerContext.areaNames
                      .where((areaName) => areaName.city.id == selectedCity.id)
                      .map(
                        (areaName) => {
                          'label': areaName.name,
                          "value": areaName.id,
                        },
                      )
                      .toList(),
        );
      },
    );
  }
}
