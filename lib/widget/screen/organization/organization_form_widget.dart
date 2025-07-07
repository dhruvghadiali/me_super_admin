import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/l10n/app_localizations.dart';
import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/model/zipcode/zipcode.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/model/area_name/area_name.dart';
import 'package:me_super_admin/model/state/state.dart' as state_model;
import 'package:me_super_admin/widget/common/alert/alert_widget.dart';
import 'package:me_super_admin/widget/common/form/city_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';
import 'package:me_super_admin/widget/common/form/state_selection_form_widget.dart';
import 'package:me_super_admin/controller/organization/organization_controller.dart';
import 'package:me_super_admin/widget/common/form/zipcode_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form/district_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form/area_name_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';

class OrganizationFormWidget extends StatefulWidget {
  const OrganizationFormWidget({super.key, required this.isStepperForm, this.onNextStep});

  final bool isStepperForm;
  final Function? onNextStep;

  @override
  State<OrganizationFormWidget> createState() => _OrganizationFormWidgetState();
}

class _OrganizationFormWidgetState extends State<OrganizationFormWidget> {
  // Importing the OrganizationController using GetX for state management.
  final OrganizationController organizationController = Get.put(OrganizationController());

  /*
   * Global keys used for form validation and accessing specific form field states.
   * _formKey: Tracks the overall form state (validation, submission).
   * _<fieldName>FieldKey: Allows direct access to specific form fields for validation, focus, or error handling.
   */
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> _nameFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _cityFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _stateFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _addressFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _zipcodeFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _districtFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _areaNameFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _shortNameFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _phoneNumberFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _governmentRegistrationNumberFieldKey =
      GlobalKey<FormFieldState>();

  /*
   * FocusNodes used to manage the focus state of individual form fields.
   * These nodes are responsible for controlling the focus and blur events of the corresponding form fields.
   * They are helpful in navigating between form fields and handling focus-related behaviors (e.g., moving to the next field on submit).
   */
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _shortNameFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _governmentRegistrationNumberFocusNode = FocusNode();

  /*
   * TextEditingControllers used to manage and manipulate the text input in form fields. These controllers allow you to:
   * 
   * - Retrieve and update the text entered by the user in each corresponding form field.
   * - Validate input, reset text fields, and retrieve user input for form submission.
   * 
   * Useful for controlling text field values programmatically and listening 
   * for changes in user input.
   */
  final TextEditingController _nameTextEditingController = TextEditingController();
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _addressTextEditingController = TextEditingController();
  final TextEditingController _shortNameTextEditingController = TextEditingController();
  final TextEditingController _phoneNumberTextEditingController = TextEditingController();
  final TextEditingController _governmentRegistrationNumberTextEditingController =
      TextEditingController();

  /*
   * The initState() method is called when the widget is inserted into the widget tree.
   * It is used here to initialize the form fields with data from the organizationController:
   * 
   * - If the organization ID is not empty, the relevant fields (name, email, address, etc.) are populated with the corresponding values 
   *  from the organizationController's organization object.
   * 
   * This ensures that the form fields are pre-filled with the organization's data when the screen is loaded.
   * 
   * The super.initState() call ensures that the parent class's initState is also called.
   */
  @override
  void initState() {
    _nameTextEditingController.text = organizationController.organization.name;
    _emailTextEditingController.text = organizationController.organization.email;
    _addressTextEditingController.text = organizationController.organization.address;
    _shortNameTextEditingController.text = organizationController.organization.shortName;
    _phoneNumberTextEditingController.text = organizationController.organization.phoneNumber;
    _governmentRegistrationNumberTextEditingController.text =
        organizationController.organization.governmentRegistrationNumber;
    super.initState();
  }

  /*
   * Displays an alert dialog when validation fails.
   *
   * This function shows a dialog with a validation alert message. The dialog
   * prevents dismissal by tapping outside and provides a button to close it.
   */
  void displayAlert() {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertWidget(
          message: appLocalizations.organizationMemberFormValidationAlertMessage,
          onPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  /*
   * The onNameTextFieldSubmit method is triggered when the user submits the name input field.
   * It performs the following actions:
   * 
   * 1. Unfocused the current focus node (i.e., removes the focus from the name text field).
   * 2. Requests focus on the next field (the short name text field) using the _shortNameFocusNode.
   * 3. Calls the organizationController.onNameSubmitted method to handle the submission logic.
   *    The _nameFieldKey is passed to provide access to the form field for validation or other actions.
   * 
   * This method ensures a smooth user experience by managing focus transitions and handling form submission.
   */
  void onNameTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_shortNameFocusNode);
    organizationController.onNameSubmitted(value, _nameFieldKey);
  }

  /*
   * The onShortNameTextFieldSubmit method is triggered when the user submits the short name input field.
   * It performs the following actions:
   * 
   * 1. Unfocused the current focus node (i.e., removes the focus from the short name text field).
   * 2. Requests focus on the next field (the email text field) using the _emailFocusNode.
   * 3. Calls the organizationController.onShortNameSubmitted method to handle the submission logic.
   *    The _shortNameFieldKey is passed to provide access to the form field for validation or other actions.
   * 
   * This method ensures a smooth user experience by managing focus transitions and handling form submission.
   */
  void onShortNameTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_emailFocusNode);
    organizationController.onShortNameSubmitted(value, _shortNameFieldKey);
  }

  /*
   * The onEmailTextFieldSubmit method is triggered when the user submits the email input field.
   * It performs the following actions:
   * 
   * 1. Unfocused the current focus node (i.e., removes the focus from the email text field).
   * 2. Requests focus on the next field (the phone number text field) using the _phoneNumberFocusNode.
   * 3. Calls the organizationController.onEmailSubmitted method to handle the submission logic.
   *    The _emailFieldKey is passed to provide access to the form field for validation or other actions.
   * 
   * This method ensures a smooth user experience by managing focus transitions and handling form submission.
   */
  void onEmailTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
    organizationController.onEmailSubmitted(value, _emailFieldKey);
  }

  /*
   * The onPhoneNumberTextFieldSubmit method is triggered when the user submits the phone number input field.
   * It performs the following actions:
   * 
   * 1. Unfocused the current focus node (i.e., removes the focus from the phone number text field).
   * 2. Requests focus on the next field (the government registration number text field) using the _governmentRegistrationNumberFocusNode.
   * 3. Calls the organizationController.onPhoneNumberSubmitted method to handle the submission logic.
   *    The _phoneNumberFieldKey is passed to provide access to the form field for validation or other actions.
   * 
   * This method ensures a smooth user experience by managing focus transitions and handling form submission.
   */
  void onPhoneNumberTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_governmentRegistrationNumberFocusNode);
    organizationController.onPhoneNumberSubmitted(value, _phoneNumberFieldKey);
  }

  /*
   * The onGovernmentRegistrationNumberTextFieldSubmit method is triggered when the user submits the 
   * government registration number input field.
   * It performs the following actions:
   * 
   * 1. Unfocused the current focus node (i.e., removes the focus from the government registration number text field).
   * 2. Requests focus on the next field (the address text field) using the _addressFocusNode.
   * 3. Calls the organizationController.onGovernmentRegistrationNumberSubmitted method to handle the submission logic.
   *    The _governmentRegistrationNumberFieldKey is passed to provide access to the form field for validation or other actions.
   * 
   * This method ensures a smooth user experience by managing focus transitions and handling form submission.
   */
  void onGovernmentRegistrationNumberTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_addressFocusNode);
    organizationController.onGovernmentRegistrationNumberSubmitted(
      value,
      _governmentRegistrationNumberFieldKey,
    );
  }

  /*
   * The onAddressTextFieldSubmit method is triggered when the user submits the address input field.
   * It performs the following actions:
   * 
   * 1. Unfocused the current focus node (i.e., removes the focus from the address text field).
   * 2. Calls the organizationController.onAddressSubmitted method to handle the submission logic.
   *    The _addressFieldKey is passed to provide access to the form field for validation or other actions.
   * 
   * This method ensures a smooth user experience by handling the form submission and removing focus from the field.
   */
  void onAddressTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    organizationController.onAddressSubmitted(value, _addressFieldKey);
  }

  /*
   * The onSubmitForm method is triggered when the user submits the entire form. It performs the following actions:
   *  
   * 1. Unfocused the current focus node (i.e., removes focus from any active field in the form).
   * 2. Checks if the organization is already created by verifying if the organization ID is not empty.
   *    - If the organization exists, it triggers the organizationController.onSubmitForm method to handle the update process.
   *    - If the organization is not yet created, it proceeds to validate the form.
   * 3. If the form is valid (via the _formKey.currentState?.validate()), it triggers the next step in the process by calling widget.onNextStep!().
   * 4. If the form is invalid, it displays an alert using the displayAlert() method.
   * 
   * This method handles the logic for both creating and updating an organization, ensuring that the form is validated before proceeding.
   */
  void onSubmitForm(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();

    if (organizationController.organization.id.isNotEmpty) {
      organizationController.onSubmitForm(_formKey);
    } else {
      if (_formKey.currentState?.validate() ?? false) {
        widget.onNextStep!();
      } else {
        displayAlert();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: GetBuilder<OrganizationController>(
        builder: (organizationControllerContext) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _nameFieldKey,
                    focusNode: _nameFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputAction: TextInputAction.next,
                    controller: _nameTextEditingController,
                    validator: organizationControllerContext.nameValidator,
                    labelText: appLocalizations.organizationFormOrganizationNameTextFieldLabelText,
                    onChange: (String value) => organizationControllerContext.onNameChange(value),
                    onFieldSubmitted: (String value) => onNameTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _shortNameFieldKey,
                    focusNode: _shortNameFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputAction: TextInputAction.next,
                    controller: _shortNameTextEditingController,
                    validator: organizationControllerContext.shortNameValidator,
                    labelText:
                        appLocalizations.organizationFormOrganizationShortNameTextFieldLabelText,
                    onChange:
                        (String value) => organizationControllerContext.onShortNameChange(value),
                    onFieldSubmitted: (String value) => onShortNameTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _emailFieldKey,
                    focusNode: _emailFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputAction: TextInputAction.next,
                    controller: _emailTextEditingController,
                    textInputType: TextInputType.emailAddress,
                    validator: organizationControllerContext.emailValidator,
                    labelText: appLocalizations.organizationFormOrganizationEmailTextFieldLabelText,
                    onChange: (String value) => organizationControllerContext.onEmailChange(value),
                    onFieldSubmitted: (String value) => onEmailTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _phoneNumberFieldKey,
                    focusNode: _phoneNumberFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputAction: TextInputAction.next,
                    controller: _phoneNumberTextEditingController,
                    textInputType: TextInputType.phone,
                    validator: organizationControllerContext.phoneNumberValidator,
                    labelText:
                        appLocalizations.organizationFormOrganizationPhoneNumberTextFieldLabelText,
                    onChange:
                        (String value) => organizationControllerContext.onPhoneNumberChange(value),
                    onFieldSubmitted:
                        (String value) => onPhoneNumberTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _governmentRegistrationNumberFieldKey,
                    focusNode: _governmentRegistrationNumberFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputAction: TextInputAction.next,
                    controller: _governmentRegistrationNumberTextEditingController,
                    validator: organizationControllerContext.governmentRegistrationNumberValidator,
                    labelText:
                        appLocalizations
                            .organizationFormOrganizationGovernmentRegistrationNumberTextFieldLabelText,
                    onChange:
                        (String value) => organizationControllerContext
                            .onGovernmentRegistrationNumberChange(value),
                    onFieldSubmitted:
                        (String value) =>
                            onGovernmentRegistrationNumberTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _addressFieldKey,
                    focusNode: _addressFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputAction: TextInputAction.done,
                    controller: _addressTextEditingController,
                    validator: organizationControllerContext.addressValidator,
                    labelText:
                        appLocalizations.organizationFormOrganizationAddressTextFieldLabelText,
                    onChange:
                        (String value) => organizationControllerContext.onAddressChange(value),
                    onFieldSubmitted: (String value) => onAddressTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: StateSelectionFormWidget(
                    formFieldKey: _stateFieldKey,
                    validator: organizationControllerContext.stateValidator,
                    selectedState: organizationControllerContext.organization.state,
                    onChange:
                        (state_model.State state) =>
                            organizationControllerContext.onStateChange(state, _stateFieldKey),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: DistrictSelectionFormWidget(
                    formFieldKey: _districtFieldKey,
                    validator: organizationControllerContext.districtValidator,
                    selectedDistrict: organizationControllerContext.organization.district,
                    selectedState: organizationControllerContext.organization.state,
                    onChange:
                        (District district) => organizationControllerContext.onDistrictChange(
                          district,
                          _districtFieldKey,
                        ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: CitySelectionFormWidget(
                    formFieldKey: _cityFieldKey,
                    validator: organizationControllerContext.cityValidator,
                    selectedCity: organizationControllerContext.organization.city,
                    selectedDistrict: organizationControllerContext.organization.district,
                    onChange:
                        (City city) =>
                            organizationControllerContext.onCityChange(city, _cityFieldKey),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: AreaNameSelectionFormWidget(
                    formFieldKey: _areaNameFieldKey,
                    validator: organizationControllerContext.areaNameValidator,
                    selectedAreaName: organizationControllerContext.organization.areaName,
                    selectedCity: organizationControllerContext.organization.city,
                    onChange:
                        (AreaName areaName) => organizationControllerContext.onAreaNameChange(
                          areaName,
                          _areaNameFieldKey,
                        ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: ZipcodeSelectionFormWidget(
                    formFieldKey: _zipcodeFieldKey,
                    validator: organizationControllerContext.zipcodeValidator,
                    selectedAreaName: organizationControllerContext.organization.areaName,
                    selectedZipcode: organizationControllerContext.organization.zipcode,
                    onChange:
                        (Zipcode zipcode) => organizationControllerContext.onZipcodeChange(
                          zipcode,
                          _zipcodeFieldKey,
                        ),
                  ),
                ),
                widget.isStepperForm
                    ? Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            margin: const EdgeInsets.only(left: 5),
                            child: ElevatedButtonWidget(
                              appColorScheme: AppColorScheme.primary,
                              buttonText: appLocalizations.nextButtonText.toUpperCase(),
                              disabled: false,
                              onPressed: () => onSubmitForm(context),
                            ),
                          ),
                        ],
                      ),
                    )
                    : Column(
                      children: [
                        organizationControllerContext.isLoader
                            ? const ApiRequestLoaderWidget(appColorScheme: AppColorScheme.primary)
                            : Container(),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: ElevatedButtonWidget(
                            appColorScheme: AppColorScheme.primary,
                            buttonText: appLocalizations.submitButtonText.toUpperCase(),
                            disabled: organizationControllerContext.isLoader,
                            onPressed: () => onSubmitForm(context),
                          ),
                        ),
                      ],
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}
