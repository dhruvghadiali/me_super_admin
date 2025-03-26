import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/authentication/sign_in_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class SignInFormWidget extends StatelessWidget {
  SignInFormWidget({super.key});

  final SignInController signInController = Get.put(SignInController());
  final TextEditingController usernameTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  void onPressed() {
    // loginController.login(
    //   Login(
    //     username: usernameTextEditingController.text,
    //     password: passwordTextEditingController.text,
    //   ),
    // );
  }

  void onUsernameChange(String value) {
    // usernameTextEditingController.text = value;
    // usernameTextEditingController.selection = TextSelection.collapsed(
    //   offset: usernameTextEditingController.text.length,
    // );
  }

  void onPasswordChange(String value) {
    // passwordTextEditingController.text = value;
    // passwordTextEditingController.selection = TextSelection.collapsed(
    //   offset: passwordTextEditingController.text.length,
    // );
  }

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 25,
        ),
        decoration: BoxDecoration(
          color: themeData.isabelline,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          boxShadow: [
            BoxShadow(
              color: themeData.isabelline as Color,
              blurRadius: 10.0,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  appLocalizations.signInFormTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              GetBuilder<SignInController>(
                builder: (loginControllerContext) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: FloatingTextFieldWidget(
                          appColorScheme: AppColorScheme.primary,
                          controller: usernameTextEditingController,
                          labelText: appLocalizations.usernameLabelText,
                          showError:
                              loginControllerContext.showUsernameTextfieldError,
                          textInputAction: TextInputAction.next,
                          onChange: (String value) => onUsernameChange(value),
                          onSubmitted: (String value) =>
                              loginControllerContext.usernameValidation(
                            usernameTextEditingController.text,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: FloatingTextFieldWidget(
                          appColorScheme: AppColorScheme.primary,
                          controller: passwordTextEditingController,
                          labelText: appLocalizations.passwordLabelText,
                          showError:
                              loginControllerContext.showPasswordTextfieldError,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          onChange: (String value) => onPasswordChange(value),
                          onSubmitted: (String value) =>
                              loginControllerContext.passwordValidation(
                            passwordTextEditingController.text,
                          ),
                        ),
                      ),
                      // loginControllerContext.isLoader
                      //     ? const ApiRequestLoaderWidget(
                      //         appColorScheme: AppColorScheme.primary,
                      //       )
                      //     : Container(),
                      Container(
                        margin: const EdgeInsets.only(top: 150),
                        child: ElevatedButtonWidget(
                          appColorScheme: AppColorScheme.primary,
                          buttonText: appLocalizations.signInButtonText,
                          disabled: loginControllerContext.isLoader,
                          onPressed: () => onPressed(),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
