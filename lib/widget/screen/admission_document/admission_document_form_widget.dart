import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/l10n/app_localizations.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/controller/admission_document/admission_document_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class AdmissionDocumentFormWidget extends StatefulWidget {
  const AdmissionDocumentFormWidget({super.key});

  @override
  State<AdmissionDocumentFormWidget> createState() => _AdmissionDocumentFormWidgetState();
}

class _AdmissionDocumentFormWidgetState extends State<AdmissionDocumentFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _admissionDocumentFieldKey = GlobalKey<FormFieldState>();

  final AdmissionDocumentController admissionDocumentController = Get.put(
    AdmissionDocumentController(),
  );

  final TextEditingController _admissionDocumentTextEditingController = TextEditingController();

  @override
  void initState() {
    if (admissionDocumentController.admissionDocument.id.isNotEmpty) {
      _admissionDocumentTextEditingController.text =
          admissionDocumentController.admissionDocument.admissionDocument;
    }
    super.initState();
  }

  @override
  void dispose() {
    _admissionDocumentTextEditingController.dispose();
    super.dispose();
  }

  onAdmissionDocumentTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    admissionDocumentController.onAdmissionDocumentSubmitted(
      value,
      _admissionDocumentFieldKey,
      _formKey,
    );
  }

  onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    admissionDocumentController.onSubmitForm(_formKey);
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
          child: GetBuilder<AdmissionDocumentController>(
            builder: (admissionDocumentControllerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FloatingTextFieldWidget(
                        fieldKey: _admissionDocumentFieldKey,
                        appColorScheme: AppColorScheme.primary,
                        controller: _admissionDocumentTextEditingController,
                        labelText: appLocalizations.admissionDocumentTextFieldLabelText,
                        textInputAction: TextInputAction.next,
                        validator: admissionDocumentControllerContext.admissionDocumentValidator,
                        onChange:
                            (String value) =>
                                admissionDocumentControllerContext.onAdmissionDocumentChange(value),
                        onFieldSubmitted:
                            (String value) => onAdmissionDocumentTextFieldSubmit(context, value),
                      ),
                    ),
                    admissionDocumentControllerContext.isLoader
                        ? const ApiRequestLoaderWidget(appColorScheme: AppColorScheme.primary)
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.submitButtonText,
                        disabled: admissionDocumentControllerContext.isLoader,
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
