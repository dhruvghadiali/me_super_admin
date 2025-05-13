import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/controller/city/city_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/dropdown/dropdown_widget.dart';

class CitySelectionFormWidget extends StatelessWidget {
  const CitySelectionFormWidget({
    super.key,
    required this.formFieldKey,
    required this.selectedCity,
    required this.selectedDistrict,

    required this.onChange,
    required this.validator,
  });

  final City selectedCity;
  final District selectedDistrict;
  final GlobalKey<FormFieldState> formFieldKey;

  final Function validator;
  final Function onChange;

  void onCityChange(String value, List<City> cities) {
    if (value != selectedCity.id) {
      City cityInfo = City.defaultValues();
      cityInfo = cityInfo.copyWith(district: selectedDistrict);

      if (value.isNotEmpty) {
        cityInfo = cities.firstWhere((city) => city.id == value);
      }

      onChange(cityInfo);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

    return GetBuilder<CityController>(
      builder: (cityControllerContext) {
        return DropdownWidget(
          fieldKey: formFieldKey,
          validator: validator,
          isEnable: selectedDistrict.id.isNotEmpty,
          labelText: appLocalizations.cityDropdownFieldLabelText,
          selectedItem: selectedCity.id,
          appColorScheme: AppColorScheme.primary,
          onChanged:
              (String value) =>
                  onCityChange(value, cityControllerContext.cities),
          items:
              cityControllerContext.cities.isEmpty
                  ? []
                  : cityControllerContext.cities
                      .where((city) => city.district.id == selectedDistrict.id)
                      .map((city) => {'label': city.name, "value": city.id})
                      .toList(),
        );
      },
    );
  }
}
