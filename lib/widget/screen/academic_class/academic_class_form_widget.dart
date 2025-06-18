import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/controller/academic_class/academic_class_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class AcademicClassFormWidget extends StatefulWidget {
  const AcademicClassFormWidget({super.key});

  @override
  State<AcademicClassFormWidget> createState() => _AcademicClassFormWidgetState();
}

class _AcademicClassFormWidgetState extends State<AcademicClassFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _academicClassFieldKey = GlobalKey<FormFieldState>();

  final AcademicClassController academicClassController = Get.put(AcademicClassController());

  final TextEditingController _academicClassTextEditingController = TextEditingController();

  @override
  void initState() {
    if (academicClassController.academicClass.id.isNotEmpty) {
      _academicClassTextEditingController.text =
          academicClassController.academicClass.academicClass;
    }
    super.initState();
  }

  @override
  void dispose() {
    _academicClassTextEditingController.dispose();
    super.dispose();
  }

  onAcademicClassTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    academicClassController.onAcademicClassSubmitted(value, _academicClassFieldKey, _formKey);
  }

  onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    academicClassController.onSubmitForm(_formKey);
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
          child: GetBuilder<AcademicClassController>(
            builder: (academicClassControllerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FloatingTextFieldWidget(
                        fieldKey: _academicClassFieldKey,
                        appColorScheme: AppColorScheme.primary,
                        controller: _academicClassTextEditingController,
                        labelText: appLocalizations.academicClassTextFieldLabelText,
                        textInputAction: TextInputAction.next,
                        validator: academicClassControllerContext.academicClassValidator,
                        onChange:
                            (String value) =>
                                academicClassControllerContext.onAcademicClassChange(value),
                        onFieldSubmitted:
                            (String value) => onAcademicClassTextFieldSubmit(context, value),
                      ),
                    ),
                    academicClassControllerContext.isLoader
                        ? const ApiRequestLoaderWidget(appColorScheme: AppColorScheme.primary)
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.submitButtonText,
                        disabled: academicClassControllerContext.isLoader,
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
