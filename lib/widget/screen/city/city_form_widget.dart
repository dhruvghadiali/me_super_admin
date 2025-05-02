import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/controller/city/city_controller.dart';
import 'package:me_super_admin/model/state/state.dart' as state_model;
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/form/state_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/widget/common/form/district_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class CityFormWidget extends StatefulWidget {
  const CityFormWidget({super.key});

  @override
  State<CityFormWidget> createState() => _CityFormWidgetState();
}

class _CityFormWidgetState extends State<CityFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _cityFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _stateFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _districtFieldKey =
      GlobalKey<FormFieldState>();

  final CityController cityController = Get.put(CityController());

  final TextEditingController cityTextEditingController =
      TextEditingController();

  @override
  void initState() {
    if (cityController.city.id.isNotEmpty) {
      cityTextEditingController.text = cityController.city.name;
    }
    super.initState();
  }

  onCityTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    cityController.onCitySubmitted(value, _cityFieldKey);
  }

  onStateDropdownChanged(BuildContext context, state_model.State state) {
    if (state.id.isEmpty) {
      District districtInfo = District.defaultValues();
      cityController.onDistrictChange(districtInfo, _districtFieldKey);
    }

    cityController.onStateChange(state, _stateFieldKey);
  }

  onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    cityController.onSubmitForm(_formKey);
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
          child: GetBuilder<CityController>(
            builder: (cityControllerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: StateSelectionFormWidget(
                        formFieldKey: _stateFieldKey,
                        validator: cityControllerContext.stateValidator,
                        selectedState:
                            cityControllerContext.city.district.state,
                        onChange:
                            (state_model.State state) =>
                                onStateDropdownChanged(context, state),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: DistrictSelectionFormWidget(
                        formFieldKey: _districtFieldKey,
                        validator: cityControllerContext.districtValidator,
                        selectedDistrict: cityControllerContext.city.district,
                        selectedState:
                            cityControllerContext.city.district.state,
                        onChange:
                            (District district) => cityController
                                .onDistrictChange(district, _districtFieldKey),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FloatingTextFieldWidget(
                        key: _cityFieldKey,
                        appColorScheme: AppColorScheme.primary,
                        controller: cityTextEditingController,
                        labelText: appLocalizations.cityTextFieldLabelText,
                        textInputAction: TextInputAction.next,
                        validator: cityControllerContext.cityValidator,
                        onChange:
                            (String value) =>
                                cityControllerContext.onCityChange(value),
                        onFieldSubmitted:
                            (String value) =>
                                onCityTextFieldSubmit(context, value),
                      ),
                    ),
                    cityControllerContext.isLoader
                        ? const ApiRequestLoaderWidget(
                          appColorScheme: AppColorScheme.primary,
                        )
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.submitButtonText,
                        disabled: cityControllerContext.isLoader,
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
