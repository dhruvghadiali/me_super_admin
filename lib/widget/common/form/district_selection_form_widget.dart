import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/model/state/state.dart' as state_model;
import 'package:me_super_admin/controller/district/district_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/dropdown/dropdown_widget.dart';

class DistrictSelectionFormWidget extends StatelessWidget {
  const DistrictSelectionFormWidget({
    super.key,
    required this.formFieldKey,
    required this.selectedState,
    required this.selectedDistrict,

    required this.onChange,
    required this.validator,
  });

  final state_model.State selectedState;
  final District selectedDistrict;
  final GlobalKey<FormFieldState> formFieldKey;

  final Function validator;
  final Function onChange;

  void onDistrictChange(String value, List<District> districts) {
    District districtInfo = District.defaultValues();
    districtInfo = districtInfo.copyWith(state: selectedState);

    if (value.isNotEmpty) {
      districtInfo = districts.firstWhere((district) => district.id == value);
    }

    onChange(districtInfo);
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return GetBuilder<DistrictController>(
      builder: (districtControllerContext) {
        return DropdownWidget(
          key: formFieldKey,
          validator: validator,
          isEnable: selectedState.id.isNotEmpty,
          labelText: appLocalizations.districtDropdownFieldLabelText,
          selectedItem: selectedDistrict.id,
          appColorScheme: AppColorScheme.primary,
          onChanged:
              (String value) =>
                  onDistrictChange(value, districtControllerContext.districts),
          items:
              districtControllerContext.districts.isEmpty
                  ? []
                  : districtControllerContext.districts
                      .where(
                        (district) => district.state.id == selectedState.id,
                      )
                      .map((state) => {'label': state.name, "value": state.id})
                      .toList(),
        );
      },
    );
  }
}
