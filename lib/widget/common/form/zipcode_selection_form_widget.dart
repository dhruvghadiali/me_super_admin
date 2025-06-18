import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/model/zipcode/zipcode.dart';
import 'package:me_super_admin/model/area_name/area_name.dart';
import 'package:me_super_admin/controller/zipcode/zipcode_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/dropdown/dropdown_widget.dart';

class ZipcodeSelectionFormWidget extends StatelessWidget {
  const ZipcodeSelectionFormWidget({
    super.key,
    required this.formFieldKey,
    required this.selectedZipcode,
    required this.selectedAreaName,

    required this.onChange,
    required this.validator,
  });

  final Zipcode selectedZipcode;
  final AreaName selectedAreaName;
  final GlobalKey<FormFieldState> formFieldKey;

  final Function validator;
  final Function onChange;

  void onZipcodeChange(String value, List<Zipcode> zipcodes) {
    if (value != selectedZipcode.id) {
      Zipcode zipcodeInfo = Zipcode.defaultValues();
      zipcodeInfo = zipcodeInfo.copyWith(areaName: selectedAreaName);

      if (value.isNotEmpty) {
        zipcodeInfo = zipcodes.firstWhere((zipcode) => zipcode.id == value);
      }

      onChange(zipcodeInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return GetBuilder<ZipcodeController>(
      builder: (zipcodeControllerContext) {
        return DropdownWidget(
          fieldKey: formFieldKey,
          validator: validator,
          isEnable: selectedAreaName.id.isNotEmpty,
          labelText: appLocalizations.zipcodeDropdownFieldLabelText,
          selectedItem: zipcodeControllerContext.zipcodes.isEmpty ? '' : selectedZipcode.id,
          appColorScheme: AppColorScheme.primary,
          onChanged: (String value) => onZipcodeChange(value, zipcodeControllerContext.zipcodes),
          items:
              zipcodeControllerContext.zipcodes.isEmpty
                  ? []
                  : zipcodeControllerContext.zipcodes
                      .where((zipcode) => zipcode.areaName.id == selectedAreaName.id)
                      .map((zipcode) => {'label': zipcode.zipcode, "value": zipcode.id})
                      .toList(),
        );
      },
    );
  }
}
