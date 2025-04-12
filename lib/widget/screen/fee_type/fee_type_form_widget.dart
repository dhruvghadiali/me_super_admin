import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/fee_type/fee_type_controller.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class FeeTypeFormWidget extends StatefulWidget {
  const FeeTypeFormWidget({super.key});

  @override
  State<FeeTypeFormWidget> createState() => _FeeTypeFormWidgetState();
}

class _FeeTypeFormWidgetState extends State<FeeTypeFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _feeTypeFieldKey =
      GlobalKey<FormFieldState>();

  final FeeTypeController feeTypeController = Get.put(FeeTypeController());

  final TextEditingController feeTypeTextEditingController =
      TextEditingController();

  @override
  void initState() {
    if (feeTypeController.feeType.id.isNotEmpty) {
      feeTypeTextEditingController.text = feeTypeController.feeType.feeType;
    }
    super.initState();
  }

  onFeeTypeTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    feeTypeController.onFeeTypeSubmitted(value, _feeTypeFieldKey, _formKey);
  }

  onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    feeTypeController.onSubmitForm(_formKey);
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
          child: GetBuilder<FeeTypeController>(
            builder: (feeTypeControllerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FloatingTextFieldWidget(
                        key: _feeTypeFieldKey,
                        appColorScheme: AppColorScheme.primary,
                        controller: feeTypeTextEditingController,
                        labelText:
                            appLocalizations.feeTypeTextFieldLabelText,
                        textInputAction: TextInputAction.next,
                        validator:
                            feeTypeControllerContext
                                .feeTypeValidator,
                        onChange:
                            (String value) => feeTypeControllerContext
                                .onFeeTypeChange(value),
                        onFieldSubmitted:
                            (String value) =>
                                onFeeTypeTextFieldSubmit(context, value),
                      ),
                    ),
                    feeTypeControllerContext.isLoader
                        ? const ApiRequestLoaderWidget(
                          appColorScheme: AppColorScheme.primary,
                        )
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.submitButtonText,
                        disabled: feeTypeControllerContext.isLoader,
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
