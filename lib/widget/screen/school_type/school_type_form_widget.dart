import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/school_type/school_type_controller.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class SchoolTypeFormWidget extends StatefulWidget {
  const SchoolTypeFormWidget({super.key});

  @override
  State<SchoolTypeFormWidget> createState() => _SchoolTypeFormWidgetState();
}

class _SchoolTypeFormWidgetState extends State<SchoolTypeFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _schoolTypeFieldKey =
      GlobalKey<FormFieldState>();

  final SchoolTypeController schoolTypeController = Get.put(
    SchoolTypeController(),
  );

  final TextEditingController schoolTypeTextEditingController =
      TextEditingController();

  @override
  void initState() {
    if (schoolTypeController.schoolType.id.isNotEmpty) {
      schoolTypeTextEditingController.text =
          schoolTypeController.schoolType.schoolType;
    }
    super.initState();
  }

  onSchoolTypeTextFieldSubmit(BuildContext context, String value) {
    FocusScope.of(context).unfocus();
    schoolTypeController.onSchoolTypeSubmitted(
      value,
      _schoolTypeFieldKey,
      _formKey,
    );
  }

  onSubmitForm(BuildContext context) {
    FocusScope.of(context).unfocus();
    schoolTypeController.onSubmitForm(_formKey);
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
          child: GetBuilder<SchoolTypeController>(
            builder: (schoolTypeControllerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FloatingTextFieldWidget(
                        key: _schoolTypeFieldKey,
                        appColorScheme: AppColorScheme.primary,
                        controller: schoolTypeTextEditingController,
                        labelText: appLocalizations.schoolTypeLabelText,
                        textInputAction: TextInputAction.next,
                        validator:
                            schoolTypeControllerContext.schoolTypeValidator,
                        onChange:
                            (String value) => schoolTypeControllerContext
                                .onSchoolTypeChange(value),
                        onFieldSubmitted:
                            (String value) =>
                                onSchoolTypeTextFieldSubmit(context, value),
                      ),
                    ),
                    schoolTypeControllerContext.isLoader
                        ? const ApiRequestLoaderWidget(
                          appColorScheme: AppColorScheme.primary,
                        )
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.signInButtonText,
                        disabled: schoolTypeControllerContext.isLoader,
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
