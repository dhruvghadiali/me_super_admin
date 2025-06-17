import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/model/state/state.dart' as state_model;
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/district/district_controller.dart';
import 'package:me_super_admin/widget/common/form/state_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class DistrictFormWidget extends StatefulWidget {
  const DistrictFormWidget({super.key});

  @override
  State<DistrictFormWidget> createState() => _DistrictFormWidgetState();
}

class _DistrictFormWidgetState extends State<DistrictFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _districtFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _stateFieldKey = GlobalKey<FormFieldState>();

  final DistrictController districtController = Get.put(DistrictController());

  final TextEditingController _districtTextEditingController = TextEditingController();

  @override
  void initState() {
    if (districtController.district.id.isNotEmpty) {
      _districtTextEditingController.text = districtController.district.name;
    }
    super.initState();
  }

  @override
  void dispose() {
    _districtTextEditingController.dispose();
    super.dispose();
  }

  onDistrictTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    districtController.onDistrictSubmitted(value, _districtFieldKey);
  }

  onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    districtController.onSubmitForm(_formKey);
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
          child: GetBuilder<DistrictController>(
            builder: (districtControllerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: StateSelectionFormWidget(
                        formFieldKey: _stateFieldKey,
                        validator: districtControllerContext.stateValidator,
                        selectedState: districtControllerContext.district.state,
                        onChange:
                            (state_model.State state) =>
                                districtController.onStateChange(state, _stateFieldKey),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FloatingTextFieldWidget(
                        fieldKey: _districtFieldKey,
                        appColorScheme: AppColorScheme.primary,
                        controller: _districtTextEditingController,
                        labelText: appLocalizations.districtTextFieldLabelText,
                        textInputAction: TextInputAction.next,
                        validator: districtControllerContext.districtValidator,
                        onChange:
                            (String value) => districtControllerContext.onDistrictChange(value),
                        onFieldSubmitted:
                            (String value) => onDistrictTextFieldSubmit(context, value),
                      ),
                    ),
                    districtControllerContext.isLoader
                        ? const ApiRequestLoaderWidget(appColorScheme: AppColorScheme.primary)
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.submitButtonText,
                        disabled: districtControllerContext.isLoader,
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
