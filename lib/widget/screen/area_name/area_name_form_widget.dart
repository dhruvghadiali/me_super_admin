import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/model/state/state.dart' as state_model;
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/area_name/area_name_controller.dart';
import 'package:me_super_admin/widget/common/form/city_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form/state_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/widget/common/form/district_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class AreaNameFormWidget extends StatefulWidget {
  const AreaNameFormWidget({super.key});

  @override
  State<AreaNameFormWidget> createState() => _AreaNameFormWidgetState();
}

class _AreaNameFormWidgetState extends State<AreaNameFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _areaNameFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _cityFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _stateFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _districtFieldKey =
      GlobalKey<FormFieldState>();

  final AreaNameController areaNameController = Get.put(AreaNameController());

  final TextEditingController areaNameTextEditingController =
      TextEditingController();

  @override
  void initState() {
    if (areaNameController.areaName.id.isNotEmpty) {
      areaNameTextEditingController.text = areaNameController.areaName.name;
    }
    super.initState();
  }

  onAreaNameTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    areaNameController.onAreaNameSubmitted(value, _areaNameFieldKey);
  }

  onStateDropdownChanged(BuildContext context, state_model.State state) {
    if (state.id.isEmpty) {
      District district = District.defaultValues();
      areaNameController.onDistrictChange(district, _districtFieldKey);
      City city = City.defaultValues();
      areaNameController.onCityChange(city, _cityFieldKey);
    }

    areaNameController.onStateChange(state, _stateFieldKey);
  }

  onDistrictDropdownChanged(BuildContext context, District district) {
    if (district.id.isEmpty) {
      City city = City.defaultValues();
      areaNameController.onCityChange(city, _cityFieldKey);
    }

    areaNameController.onDistrictChange(district, _districtFieldKey);
  }

  onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    areaNameController.onSubmitForm(_formKey);
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
        decoration: BoxDecoration(
          color: themeData.offWhite,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: themeData.offWhite as Color,
              blurRadius: 10.0,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: GetBuilder<AreaNameController>(
            builder: (areaNameControllerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: StateSelectionFormWidget(
                        formFieldKey: _stateFieldKey,
                        validator: areaNameControllerContext.stateValidator,
                        selectedState:
                            areaNameControllerContext
                                .areaName
                                .city
                                .district
                                .state,
                        onChange:
                            (state_model.State state) =>
                                onStateDropdownChanged(context, state),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: DistrictSelectionFormWidget(
                        formFieldKey: _districtFieldKey,
                        validator: areaNameControllerContext.districtValidator,
                        selectedDistrict:
                            areaNameControllerContext.areaName.city.district,
                        selectedState:
                            areaNameControllerContext
                                .areaName
                                .city
                                .district
                                .state,
                        onChange:
                            (District district) =>
                                onDistrictDropdownChanged(context, district),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: CitySelectionFormWidget(
                        formFieldKey: _cityFieldKey,
                        validator: areaNameControllerContext.cityValidator,
                        selectedDistrict:
                            areaNameControllerContext.areaName.city.district,
                        selectedCity: areaNameControllerContext.areaName.city,
                        onChange:
                            (City city) => areaNameControllerContext
                                .onCityChange(city, _cityFieldKey),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FloatingTextFieldWidget(
                        key: _areaNameFieldKey,
                        appColorScheme: AppColorScheme.primary,
                        controller: areaNameTextEditingController,
                        labelText: appLocalizations.areaNameTextFieldLabelText,
                        textInputAction: TextInputAction.next,
                        validator: areaNameControllerContext.areaNameValidator,
                        onChange:
                            (String value) => areaNameControllerContext
                                .onAreaNameChange(value),
                        onFieldSubmitted:
                            (String value) =>
                                onAreaNameTextFieldSubmit(context, value),
                      ),
                    ),
                    areaNameControllerContext.isLoader
                        ? const ApiRequestLoaderWidget(
                          appColorScheme: AppColorScheme.primary,
                        )
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.submitButtonText,
                        disabled: areaNameControllerContext.isLoader,
                        onPressed: () => onSubmitForm(context),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
