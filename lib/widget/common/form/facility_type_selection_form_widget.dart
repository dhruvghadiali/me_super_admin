import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/l10n/app_localizations.dart';
import 'package:me_super_admin/model/facility_type/facility_type.dart';
import 'package:me_super_admin/controller/facility_type/facility_type_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/dropdown/dropdown_widget.dart';

class FacilityTypeSelectionFormWidget extends StatelessWidget {
  const FacilityTypeSelectionFormWidget({
    super.key,
    required this.formFieldKey,
    required this.selectedFacilityType,
    required this.onChange,
    required this.validator,
  });

  final FacilityType selectedFacilityType;
  final GlobalKey<FormFieldState> formFieldKey;

  final Function validator;
  final Function onChange;

  void onFacilityTypeChange(String value, List<FacilityType> facilityTypes) {
    if (value != selectedFacilityType.id) {
      FacilityType facilityTypeInfo = FacilityType.defaultValues();

      if (value.isNotEmpty) {
        facilityTypeInfo = facilityTypes.firstWhere((facilityType) => facilityType.id == value);
      }

      onChange(facilityTypeInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return GetBuilder<FacilityTypeController>(
      builder: (facilityTypeControllerContext) {
        return DropdownWidget(
          fieldKey: formFieldKey,
          validator: validator,
          labelText: appLocalizations.facilityTypeDropdownFieldLabelText,
          selectedItem:
              facilityTypeControllerContext.facilityTypes.isEmpty ? '' : selectedFacilityType.id,
          appColorScheme: AppColorScheme.primary,
          onChanged:
              (String value) =>
                  onFacilityTypeChange(value, facilityTypeControllerContext.facilityTypes),
          items:
              facilityTypeControllerContext.facilityTypes.isEmpty
                  ? []
                  : facilityTypeControllerContext.facilityTypes
                      .map(
                        (facilityType) => {
                          'label': facilityType.facilityType,
                          "value": facilityType.id,
                        },
                      )
                      .toList(),
        );
      },
    );
  }
}
