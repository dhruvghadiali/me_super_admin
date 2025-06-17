import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/controller/state/state_controller.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class StateFormWidget extends StatefulWidget {
  const StateFormWidget({super.key});

  @override
  State<StateFormWidget> createState() => _StateFormWidgetState();
}

class _StateFormWidgetState extends State<StateFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _stateFieldKey = GlobalKey<FormFieldState>();

  final StateController stateController = Get.put(StateController());

  final TextEditingController _stateTextEditingController = TextEditingController();

  @override
  void initState() {
    if (stateController.state.id.isNotEmpty) {
      _stateTextEditingController.text = stateController.state.name;
    }
    super.initState();
  }

  @override
  void dispose() {
    _stateTextEditingController.dispose();
    super.dispose();
  }

  onStateTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    stateController.onStateSubmitted(value, _stateFieldKey, _formKey);
  }

  onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    stateController.onSubmitForm(_formKey);
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
          child: GetBuilder<StateController>(
            builder: (stateControllerContext) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: FloatingTextFieldWidget(
                        fieldKey: _stateFieldKey,
                        appColorScheme: AppColorScheme.primary,
                        controller: _stateTextEditingController,
                        labelText: appLocalizations.stateTextFieldLabelText,
                        textInputAction: TextInputAction.next,
                        validator: stateControllerContext.stateValidator,
                        onChange: (String value) => stateControllerContext.onStateChange(value),
                        onFieldSubmitted: (String value) => onStateTextFieldSubmit(context, value),
                      ),
                    ),
                    stateControllerContext.isLoader
                        ? const ApiRequestLoaderWidget(appColorScheme: AppColorScheme.primary)
                        : Container(),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: ElevatedButtonWidget(
                        appColorScheme: AppColorScheme.primary,
                        buttonText: appLocalizations.submitButtonText,
                        disabled: stateControllerContext.isLoader,
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
