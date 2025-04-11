import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/controller/academic_grade/academic_grade_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class AcademicGradeFormWidget extends StatefulWidget {
  const AcademicGradeFormWidget({super.key});

  @override
  State<AcademicGradeFormWidget> createState() => _AcademicGradeFormWidgetState();
}

class _AcademicGradeFormWidgetState extends State<AcademicGradeFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _academicGradeFieldKey =
      GlobalKey<FormFieldState>();

  final AcademicGradeController academicGradeController = Get.put(
    AcademicGradeController(),
  );

  final TextEditingController academicGradeTextEditingController =
      TextEditingController();

  @override
  void initState() {
    if (academicGradeController.academicGrade.id.isNotEmpty) {
      academicGradeTextEditingController.text =
          academicGradeController.academicGrade.academicGrade;
    }
    super.initState();
  }

  onAcademicGradeTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    academicGradeController.onAcademicGradeSubmitted(
      value,
      _academicGradeFieldKey,
      _formKey,
    );
  }

  onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    academicGradeController.onSubmitForm(_formKey);
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
          child: GetBuilder<AcademicGradeController>(
            builder: (academicGradeControllerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FloatingTextFieldWidget(
                        key: _academicGradeFieldKey,
                        appColorScheme: AppColorScheme.primary,
                        controller: academicGradeTextEditingController,
                        labelText: appLocalizations.academicGradeTextFieldLabelText,
                        textInputAction: TextInputAction.next,
                        validator:
                            academicGradeControllerContext.academicGradeValidator,
                        onChange:
                            (String value) => academicGradeControllerContext
                                .onAcademicGradeChange(value),
                        onFieldSubmitted:
                            (String value) =>
                                onAcademicGradeTextFieldSubmit(context, value),
                      ),
                    ),
                    academicGradeControllerContext.isLoader
                        ? const ApiRequestLoaderWidget(
                          appColorScheme: AppColorScheme.primary,
                        )
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.submitButtonText,
                        disabled: academicGradeControllerContext.isLoader,
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
