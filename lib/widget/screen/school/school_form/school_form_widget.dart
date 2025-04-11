import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:me_super_admin/app_enum.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/utils/theme_data/extensions_theme_data.dart';
import 'package:me_super_admin/controller/authentication/sign_in_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/checkbox/checkbox_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/dropdown/dropdown_widget.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class SchoolFormWidget extends StatelessWidget {
  SchoolFormWidget({super.key});

  final TextEditingController schoolNameTextEditingController =
      TextEditingController();
  final TextEditingController addressTextEditingController =
      TextEditingController();
  final TextEditingController emailTextEditingController =
      TextEditingController();
  final TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  final TextEditingController establishedYearTextEditingController =
      TextEditingController();
  final TextEditingController affiliationNumberTextEditingController =
      TextEditingController();
  final TextEditingController usernameTextEditingController =
      TextEditingController();
  final TextEditingController passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    ExtensionsThemeData themeData =
        Theme.of(context).extension<ExtensionsThemeData>()!;
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
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
          child: GetBuilder<SignInController>(
            builder: (signInControllerContext) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: FloatingTextFieldWidget(
                      validator: (){},
                      appColorScheme: AppColorScheme.primary,
                      controller: schoolNameTextEditingController,
                      labelText: appLocalizations.schoolNameLabelText,
                      textInputAction: TextInputAction.next,
                      onChange: (String value) => {},
                      onFieldSubmitted:
                          (String value) =>
                              signInControllerContext.usernameValidation(
                                usernameTextEditingController.text,
                              ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: FloatingTextFieldWidget(
                      validator: (){},
                      appColorScheme: AppColorScheme.primary,
                      controller: phoneNumberTextEditingController,
                      labelText: appLocalizations.phoneNumberLabelText,
                     textInputAction: TextInputAction.done,
                      obscureText: true,
                      onChange: (String value) => {},
                      onFieldSubmitted:
                          (String value) =>
                              signInControllerContext.passwordValidation(
                                passwordTextEditingController.text,
                              ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: FloatingTextFieldWidget(
                      validator: (){},
                      appColorScheme: AppColorScheme.primary,
                      controller: emailTextEditingController,
                      labelText: appLocalizations.emailLabelText,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      onChange: (String value) => {},
                      onFieldSubmitted:
                          (String value) =>
                              signInControllerContext.passwordValidation(
                                passwordTextEditingController.text,
                              ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: FloatingTextFieldWidget(
                      validator: (){},
                      appColorScheme: AppColorScheme.primary,
                      controller: addressTextEditingController,
                      labelText: appLocalizations.addressLabelText,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      onChange: (String value) => {},
                      onFieldSubmitted:
                          (String value) =>
                              signInControllerContext.passwordValidation(
                                passwordTextEditingController.text,
                              ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: FloatingTextFieldWidget(
                      validator: (){},
                      appColorScheme: AppColorScheme.primary,
                      controller: establishedYearTextEditingController,
                      labelText: appLocalizations.establishedYearLabelText,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      onChange: (String value) => {},
                      onFieldSubmitted:
                          (String value) =>
                              signInControllerContext.passwordValidation(
                                passwordTextEditingController.text,
                              ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: FloatingTextFieldWidget(
                      validator: (){},
                      appColorScheme: AppColorScheme.primary,
                      controller: affiliationNumberTextEditingController,
                      labelText: appLocalizations.affiliationNumberLabelText,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      onChange: (String value) => {},
                      onFieldSubmitted:
                          (String value) =>
                              signInControllerContext.passwordValidation(
                                passwordTextEditingController.text,
                              ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: FloatingTextFieldWidget(
                      validator: (){},
                      appColorScheme: AppColorScheme.primary,
                      controller: usernameTextEditingController,
                      labelText: appLocalizations.usernameLabelText,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      onChange: (String value) => {},
                      onFieldSubmitted:
                          (String value) =>
                              signInControllerContext.passwordValidation(
                                passwordTextEditingController.text,
                              ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: FloatingTextFieldWidget(
                      validator: (){},
                      appColorScheme: AppColorScheme.primary,
                      controller: passwordTextEditingController,
                      labelText: appLocalizations.passwordLabelText,
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      onChange: (String value) => {},
                      onFieldSubmitted:
                          (String value) =>
                              signInControllerContext.passwordValidation(
                                passwordTextEditingController.text,
                              ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: DropdownWidget(
                      appColorScheme: AppColorScheme.primary,
                      labelText: appLocalizations.schoolTypeTextFieldLabelText,
                      items: [
                        {"value": 'public', "label": 'Public'},
                        {"value": 'private', "label": 'Private'},
                      ],
                      selectedItem: '',
                      onChanged: () {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 25),
                    child: Text(
                      appLocalizations.schoolBoardLabelText,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CheckboxWidget(
                          title: 'CBSE',
                          isSelected: false,
                          onChange: () {},
                          appColorScheme: AppColorScheme.primary,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CheckboxWidget(
                          title: 'ICSE',
                          isSelected: false,
                          onChange: () {},
                          appColorScheme: AppColorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CheckboxWidget(
                          title: 'State Board',
                          isSelected: false,
                          onChange: () {},
                          appColorScheme: AppColorScheme.primary,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CheckboxWidget(
                          title: 'IB',
                          isSelected: false,
                          onChange: () {},
                          appColorScheme: AppColorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  signInControllerContext.isLoader
                      ? const ApiRequestLoaderWidget(
                        appColorScheme: AppColorScheme.primary,
                      )
                      : Container(),
                  Container(
                    margin: const EdgeInsets.only(top: 30, bottom: 30),
                    child: ElevatedButtonWidget(
                      appColorScheme: AppColorScheme.primary,
                      buttonText: appLocalizations.registerSchoolButtonText,
                      disabled: signInControllerContext.isLoader,
                      onPressed: () => {},
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
