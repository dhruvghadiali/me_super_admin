import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/model/area_name/area_name.dart';
import 'package:me_super_admin/model/state/state.dart' as state_model;
import 'package:me_super_admin/controller/zipcode/zipcode_controller.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/form/city_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form/state_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/widget/common/form/district_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form/area_name_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class ZipcodeFormWidget extends StatefulWidget {
  const ZipcodeFormWidget({super.key});

  @override
  State<ZipcodeFormWidget> createState() => _ZipcodeFormWidgetState();
}

class _ZipcodeFormWidgetState extends State<ZipcodeFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _zipcodeFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _areaNameFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _cityFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _stateFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _districtFieldKey =
      GlobalKey<FormFieldState>();

  final ZipcodeController zipcodeController = Get.put(ZipcodeController());

  final TextEditingController zipcodeTextEditingController =
      TextEditingController();

  @override
  void initState() {
    if (zipcodeController.zipcode.id.isNotEmpty) {
      zipcodeTextEditingController.text = zipcodeController.zipcode.zipcode;
    }
    super.initState();
  }

  onZipcodeTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    zipcodeController.onZipcodeSubmitted(value, _zipcodeFieldKey);
  }

  onStateDropdownChanged(BuildContext context, state_model.State state) {
    if (state.id.isEmpty) {
      District district = District.defaultValues();
      zipcodeController.onDistrictChange(district, _districtFieldKey);
      City city = City.defaultValues();
      zipcodeController.onCityChange(city, _cityFieldKey);
      AreaName areaName = AreaName.defaultValues();
      zipcodeController.onAreaNameChange(areaName, _areaNameFieldKey);
    }

    zipcodeController.onStateChange(state, _stateFieldKey);
  }

  onDistrictDropdownChanged(BuildContext context, District district) {
    if (district.id.isEmpty) {
      City city = City.defaultValues();
      zipcodeController.onCityChange(city, _cityFieldKey);
      AreaName areaName = AreaName.defaultValues();
      zipcodeController.onAreaNameChange(areaName, _areaNameFieldKey);
    }

    zipcodeController.onDistrictChange(district, _districtFieldKey);
  }

  onCityDropdownChanged(BuildContext context, City city) {
    if (city.id.isEmpty) {
      AreaName areaName = AreaName.defaultValues();
      zipcodeController.onAreaNameChange(areaName, _areaNameFieldKey);
    }

    zipcodeController.onCityChange(city, _cityFieldKey);
  }

  onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    zipcodeController.onSubmitForm(_formKey);
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
          child: GetBuilder<ZipcodeController>(
            builder: (zipcodeControllerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: StateSelectionFormWidget(
                        formFieldKey: _stateFieldKey,
                        validator: zipcodeControllerContext.stateValidator,
                        selectedState:
                            zipcodeControllerContext
                                .zipcode
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
                        validator: zipcodeControllerContext.districtValidator,
                        selectedDistrict:
                            zipcodeControllerContext
                                .zipcode
                                .areaName
                                .city
                                .district,
                        selectedState:
                            zipcodeControllerContext
                                .zipcode
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
                        validator: zipcodeControllerContext.cityValidator,
                        selectedDistrict:
                            zipcodeControllerContext
                                .zipcode
                                .areaName
                                .city
                                .district,
                        selectedCity:
                            zipcodeControllerContext.zipcode.areaName.city,
                        onChange:
                            (City city) => onCityDropdownChanged(context, city),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: AreaNameSelectionFormWidget(
                        formFieldKey: _areaNameFieldKey,
                        validator: zipcodeControllerContext.areaNameValidator,
                        selectedAreaName:
                            zipcodeControllerContext.zipcode.areaName,
                        selectedCity:
                            zipcodeControllerContext.zipcode.areaName.city,
                        onChange:
                            (AreaName areaName) => zipcodeControllerContext
                                .onAreaNameChange(areaName, _areaNameFieldKey),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FloatingTextFieldWidget(
                        key: _zipcodeFieldKey,
                        appColorScheme: AppColorScheme.primary,
                        controller: zipcodeTextEditingController,
                        labelText: appLocalizations.zipcodeTextFieldLabelText,
                        textInputAction: TextInputAction.next,
                        validator: zipcodeControllerContext.zipcodeValidator,
                        onChange:
                            (String value) =>
                                zipcodeControllerContext.onZipcodeChange(value),
                        onFieldSubmitted:
                            (String value) =>
                                onZipcodeTextFieldSubmit(context, value),
                      ),
                    ),
                    zipcodeControllerContext.isLoader
                        ? const ApiRequestLoaderWidget(
                          appColorScheme: AppColorScheme.primary,
                        )
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.submitButtonText,
                        disabled: zipcodeControllerContext.isLoader,
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
