import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/l10n/app_localizations.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/controller/facility_type/facility_type_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class FacilityTypeFormWidget extends StatefulWidget {
  const FacilityTypeFormWidget({super.key});

  @override
  State<FacilityTypeFormWidget> createState() => _FacilityTypeFormWidgetState();
}

class _FacilityTypeFormWidgetState extends State<FacilityTypeFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _facilityTypeFieldKey = GlobalKey<FormFieldState>();

  final FacilityTypeController facilityTypeController = Get.put(FacilityTypeController());

  final TextEditingController _facilityTypeTextEditingController = TextEditingController();

  @override
  void initState() {
    if (facilityTypeController.facilityType.id.isNotEmpty) {
      _facilityTypeTextEditingController.text = facilityTypeController.facilityType.facilityType;
    }
    super.initState();
  }

  @override
  void dispose() {
    _facilityTypeTextEditingController.dispose();
    super.dispose();
  }

  onFacilityTypeTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    facilityTypeController.onFacilityTypeSubmitted(value, _facilityTypeFieldKey, _formKey);
  }

  onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    facilityTypeController.onSubmitForm(_formKey);
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
          child: GetBuilder<FacilityTypeController>(
            builder: (facilityTypeControllerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FloatingTextFieldWidget(
                        fieldKey: _facilityTypeFieldKey,
                        appColorScheme: AppColorScheme.primary,
                        controller: _facilityTypeTextEditingController,
                        labelText: appLocalizations.facilityTypeTextFieldLabelText,
                        textInputAction: TextInputAction.next,
                        validator: facilityTypeControllerContext.facilityTypeValidator,
                        onChange:
                            (String value) =>
                                facilityTypeControllerContext.onFacilityTypeChange(value),
                        onFieldSubmitted:
                            (String value) => onFacilityTypeTextFieldSubmit(context, value),
                      ),
                    ),
                    facilityTypeControllerContext.isLoader
                        ? const ApiRequestLoaderWidget(appColorScheme: AppColorScheme.primary)
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.submitButtonText,
                        disabled: facilityTypeControllerContext.isLoader,
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
