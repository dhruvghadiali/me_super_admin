import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/model/school_admin/school_admin.dart';
import 'package:me_super_admin/controller/school_admin/school_admin_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class SchoolAdminFormWidget extends StatefulWidget {
  const SchoolAdminFormWidget({super.key, required this.schoolAdmin, required this.index, required this.onSubmitForm});

  final SchoolAdmin schoolAdmin;
  final int index;
  final Function onSubmitForm;

  @override
  State<SchoolAdminFormWidget> createState() => _SchoolAdminFormWidgetState();
}

class _SchoolAdminFormWidgetState extends State<SchoolAdminFormWidget> {
  // Importing the SchoolAdminController using GetX for state management.
  final SchoolAdminController schoolAdminController = Get.put(SchoolAdminController());

  /*
   * Global keys used for form validation and accessing specific form field states.
   * _formKey: Tracks the overall form state (validation, submission).
   * _<fieldName>FieldKey: Allows direct access to specific form fields for validation, focus, or error handling.
   */
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> _firstNameFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _lastNameFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _phoneNumberFieldKey = GlobalKey<FormFieldState>();

  /*
   * FocusNodes used to manage the focus state of individual form fields.
   * These nodes are responsible for controlling the focus and blur events of the corresponding form fields.
   * They are helpful in navigating between form fields and handling focus-related behaviors (e.g., moving to the next field on submit).
   */
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();

  /*
   * TextEditingControllers used to manage and manipulate the text input in form fields. These controllers allow you to:
   * 
   * - Retrieve and update the text entered by the user in each corresponding form field.
   * - Validate input, reset text fields, and retrieve user input for form submission.
   * 
   * Useful for controlling text field values programmatically and listening for changes in user input.
   */
  final TextEditingController _firstNameTextEditingController = TextEditingController();
  final TextEditingController _lastNameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _phoneNumberTextEditingController = TextEditingController();

  @override
  void initState() {
    /*
     * Initializes the state of the widget.
     *
     * If the `schoolAdmin` object passed to the widget has a non-empty `id`,
     * it populates the text fields with the corresponding values from the object.
     * This ensures that the form is pre-filled with existing data when editing a
     * school admin.
     */
    if (widget.schoolAdmin.id.isNotEmpty) {
      SchoolAdmin schoolAdmin = widget.schoolAdmin;
      _firstNameTextEditingController.text = schoolAdmin.firstName;
      _lastNameTextEditingController.text = schoolAdmin.lastName;
      _emailTextEditingController.text = schoolAdmin.email;
      _phoneNumberTextEditingController.text = schoolAdmin.phoneNumber;
    }
    super.initState();
  }

  /*
   * Handles the submission of the first name text field.
   *
   * Parameters:
   * - `context`: The build context of the widget.
   * - `value`: The value entered in the first name text field.
   *
   * Explanation:
   * - Unfocused the current text field.
   * - Requests focus for the last name text field.
   * - Submits the first name value to the controller for validation and state update.
   */
  void onFirstNameTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_lastNameFocusNode);
    schoolAdminController.onFirstNameSubmitted(value, widget.index, _firstNameFieldKey);
  }

  /*
   * Handles the submission of the last name text field.
   *
   * Parameters:
   * - `context`: The build context of the widget.
   * - `value`: The value entered in the last name text field.
   *
   * Explanation:
   * - Unfocused the current text field.
   * - Requests focus for the email text field.
   * - Submits the last name value to the controller for validation and state update.
   */
  void onLastNameTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_emailFocusNode);
    schoolAdminController.onLastNameSubmitted(value, widget.index, _lastNameFieldKey);
  }

  /*
   * Handles the submission of the email text field.
   *
   * Parameters:
   * - `context`: The build context of the widget.
   * - `value`: The value entered in the email text field.
   *
   * Explanation:
   * - Unfocused the current text field.
   * - Requests focus for the phone number text field.
   * - Submits the email value to the controller for validation and state update.
   */
  void onEmailTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
    schoolAdminController.onEmailSubmitted(value, widget.index, _emailFieldKey);
  }

  /*
   * Handles the submission of the phone number text field.
   *
   * Parameters:
   * - `context`: The build context of the widget.
   * - `value`: The value entered in the phone number text field.
   *
   * Explanation:
   * - Unfocused the current text field.
   * - Calls the `onSubmitForm` method to handle form submission.
   */
  void onPhoneNumberTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    onSubmitForm(context);
  }

  /*
   * Handles the form submission.
   *
   * Parameters:
   * - `context`: The build context of the widget.
   *
   * Explanation:
   * - Unfocused any currently focused text field.
   * - Validates the form using `_formKey`.
   * - Calls the `onSubmitForm` callback with `true` if the form is valid, otherwise with `false`.
   */
  void onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmitForm(true);
    } else {
      widget.onSubmitForm(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: GetBuilder<SchoolAdminController>(
        builder: (schoolAdminControllerContext) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _firstNameFieldKey,
                    focusNode: _firstNameFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputAction: TextInputAction.next,
                    controller: _firstNameTextEditingController,
                    validator: schoolAdminControllerContext.firstNameValidator,
                    labelText: appLocalizations.firstNameTextFieldLabelText,
                    onChange: (String value) => schoolAdminControllerContext.onFirstNameChange(value, widget.index),
                    onFieldSubmitted: (String value) => onFirstNameTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _lastNameFieldKey,
                    focusNode: _lastNameFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputAction: TextInputAction.next,
                    controller: _lastNameTextEditingController,
                    validator: schoolAdminControllerContext.lastNameValidator,
                    labelText: appLocalizations.lastNameTextFieldLabelText,
                    onChange: (String value) => schoolAdminControllerContext.onLastNameChange(value, widget.index),
                    onFieldSubmitted: (String value) => onLastNameTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _emailFieldKey,
                    focusNode: _emailFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    controller: _emailTextEditingController,
                    validator: schoolAdminControllerContext.emailValidator,
                    labelText: appLocalizations.emailTextFieldLabelText,
                    onChange: (String value) => schoolAdminControllerContext.onEmailChange(value, widget.index),
                    onFieldSubmitted: (String value) => onEmailTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _phoneNumberFieldKey,
                    focusNode: _phoneNumberFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.phone,
                    controller: _phoneNumberTextEditingController,
                    validator: schoolAdminControllerContext.phoneNumberValidator,
                    labelText: appLocalizations.phoneNumberTextFieldLabelText,
                    onChange: (String value) => schoolAdminControllerContext.onPhoneNumberChange(value, widget.index),
                    onFieldSubmitted: (String value) => onPhoneNumberTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        margin: const EdgeInsets.only(left: 5),
                        child: ElevatedButtonWidget(
                          appColorScheme: AppColorScheme.primary,
                          buttonText: appLocalizations.submitButtonText,
                          disabled: false,
                          onPressed: () => onSubmitForm(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
