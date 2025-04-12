import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/controller/education_board/education_board_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class EducationBoardFormWidget extends StatefulWidget {
  const EducationBoardFormWidget({super.key});

  @override
  State<EducationBoardFormWidget> createState() =>
      _EducationBoardFormWidgetState();
}

class _EducationBoardFormWidgetState extends State<EducationBoardFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _educationBoardFieldKey =
      GlobalKey<FormFieldState>();

  final EducationBoardController educationBoardController = Get.put(
    EducationBoardController(),
  );

  final TextEditingController educationBoardTextEditingController =
      TextEditingController();

  @override
  void initState() {
    if (educationBoardController.educationBoard.id.isNotEmpty) {
      educationBoardTextEditingController.text =
          educationBoardController.educationBoard.educationBoard;
    }
    super.initState();
  }

  onEducationBoardTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    educationBoardController.onEducationBoardSubmitted(
      value,
      _educationBoardFieldKey,
      _formKey,
    );
  }

  onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    educationBoardController.onSubmitForm(_formKey);
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
          child: GetBuilder<EducationBoardController>(
            builder: (educationBoardControllerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FloatingTextFieldWidget(
                        key: _educationBoardFieldKey,
                        appColorScheme: AppColorScheme.primary,
                        controller: educationBoardTextEditingController,
                        labelText:
                            appLocalizations.educationBoardTextFieldLabelText,
                        textInputAction: TextInputAction.next,
                        validator:
                            educationBoardControllerContext.educationBoardValidator,
                        onChange:
                            (String value) => educationBoardControllerContext
                                .onEducationBoardChange(value),
                        onFieldSubmitted:
                            (String value) =>
                                onEducationBoardTextFieldSubmit(context, value),
                      ),
                    ),
                    educationBoardControllerContext.isLoader
                        ? const ApiRequestLoaderWidget(
                          appColorScheme: AppColorScheme.primary,
                        )
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.submitButtonText,
                        disabled: educationBoardControllerContext.isLoader,
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
