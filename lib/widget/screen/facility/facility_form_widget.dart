import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/l10n/app_localizations.dart';
import 'package:me_super_admin/model/facility_type/facility_type.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/facility/facility_controller.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/widget/common/form/facility_type_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class FacilityFormWidget extends StatefulWidget {
  const FacilityFormWidget({super.key});

  @override
  State<FacilityFormWidget> createState() => _FacilityFormWidgetState();
}

class _FacilityFormWidgetState extends State<FacilityFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _facilityTypeFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _facilityNameFieldKey = GlobalKey<FormFieldState>();

  final FacilityController facilityController = Get.put(FacilityController());

  final TextEditingController _facilityTextEditingController = TextEditingController();

  @override
  void initState() {
    if (facilityController.facility.id.isNotEmpty) {
      _facilityTextEditingController.text = facilityController.facility.facilityName;
    }
    super.initState();
  }

  @override
  void dispose() {
    _facilityTextEditingController.dispose();
    super.dispose();
  }

  onFacilityNameTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    facilityController.onFacilitySubmitted(value, _facilityNameFieldKey);
  }

  onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    facilityController.onSubmitForm(_formKey);
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData = Theme.of(context).extension<ExtensionsThemeData>()!;
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
          child: GetBuilder<FacilityController>(
            builder: (facilityControllerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FacilityTypeSelectionFormWidget(
                        formFieldKey: _facilityTypeFieldKey,
                        validator: facilityControllerContext.facilityTypeValidator,
                        selectedFacilityType: facilityControllerContext.facility.facilityType,
                        onChange:
                            (FacilityType facilityType) => facilityControllerContext
                                .onFacilityTypeChange(facilityType, _facilityTypeFieldKey),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FloatingTextFieldWidget(
                        fieldKey: _facilityNameFieldKey,
                        appColorScheme: AppColorScheme.primary,
                        controller: _facilityTextEditingController,
                        labelText: appLocalizations.facilityNameTextFieldLabelText,
                        textInputAction: TextInputAction.next,
                        validator: facilityControllerContext.facilityNameValidator,
                        onChange:
                            (String value) => facilityControllerContext.onFacilityNameChange(value),
                        onFieldSubmitted:
                            (String value) => onFacilityNameTextFieldSubmit(context, value),
                      ),
                    ),
                    facilityControllerContext.isLoader
                        ? const ApiRequestLoaderWidget(appColorScheme: AppColorScheme.primary)
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.submitButtonText,
                        disabled: facilityControllerContext.isLoader,
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
