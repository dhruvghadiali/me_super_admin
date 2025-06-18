import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/model/zipcode/zipcode.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/model/area_name/area_name.dart';
import 'package:me_super_admin/model/state/state.dart' as state_model;
import 'package:me_super_admin/model/organization_member/organization_member.dart';
import 'package:me_super_admin/widget/common/form/city_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form/state_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form/zipcode_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form/district_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form/area_name_selection_form_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/dropdown/dropdown_widget.dart';
import 'package:me_super_admin/widget/common/form_fields/elevated_button/elevated_button.dart';
import 'package:me_super_admin/controller/organization_member/organization_member_controller.dart';
import 'package:me_super_admin/widget/common/form_fields/text_fields/floating_text_field_widget.dart';
import 'package:me_super_admin/widget/common/loader/api_request_loader_widget.dart';

class OrganizationMemberFormWidget extends StatefulWidget {
  const OrganizationMemberFormWidget({super.key, required this.organizationMember, required this.index, required this.isStepper, required this.onSubmitForm});

  final OrganizationMember organizationMember;
  final int index;
  final bool isStepper;
  final Function onSubmitForm;

  @override
  State<OrganizationMemberFormWidget> createState() => _OrganizationMemberFormWidgetState();
}

class _OrganizationMemberFormWidgetState extends State<OrganizationMemberFormWidget> {
  // Importing the OrganizationMemberController using GetX for state management.
  final OrganizationMemberController organizationMemberController = Get.put(OrganizationMemberController());

  /*
   * Global keys used for form validation and accessing specific form field states.
   * _formKey: Tracks the overall form state (validation, submission).
   * _<fieldName>FieldKey: Allows direct access to specific form fields for validation, focus, or error handling.
   */
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState> _cityFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _stateFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _emailFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _zipcodeFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _addressFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _districtFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _positionFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _lastNameFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _areaNameFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _firstNameFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _phoneNumberFieldKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _aadhaarNumberFieldKey = GlobalKey<FormFieldState>();

  /*
   * FocusNodes used to manage the focus state of individual form fields.
   * These nodes are responsible for controlling the focus and blur events of the corresponding form fields.
   * They are helpful in navigating between form fields and handling focus-related behaviors (e.g., moving to the next field on submit).
   */
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();
  final FocusNode _positionFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _aadhaarNumberFocusNode = FocusNode();

  /*
   * TextEditingControllers used to manage and manipulate the text input in form fields. These controllers allow you to:
   * 
   * - Retrieve and update the text entered by the user in each corresponding form field.
   * - Validate input, reset text fields, and retrieve user input for form submission.
   * 
   * Useful for controlling text field values programmatically and listening 
   * for changes in user input.
   */
  final TextEditingController _emailTextEditingController = TextEditingController();
  final TextEditingController _addressTextEditingController = TextEditingController();
  final TextEditingController _positionTextEditingController = TextEditingController();
  final TextEditingController _lastNameTextEditingController = TextEditingController();
  final TextEditingController _firstNameTextEditingController = TextEditingController();
  final TextEditingController _phoneNumberTextEditingController = TextEditingController();
  final TextEditingController _aadhaarNumberTextEditingController = TextEditingController();

  @override
  void initState() {
    /*
     * Initializes the state of the widget.
     *
     * If the `organizationMember` object passed to the widget has a non-empty `id`,
     * it populates the text fields with the corresponding values from the object.
     * This ensures that the form is pre-filled with existing data when editing an
     * organization member.
     */
    OrganizationMember organizationMember = widget.organizationMember;
    _emailTextEditingController.text = organizationMember.email;
    _addressTextEditingController.text = organizationMember.address;
    _positionTextEditingController.text = organizationMember.position;
    _lastNameTextEditingController.text = organizationMember.lastName;
    _firstNameTextEditingController.text = organizationMember.firstName;
    _phoneNumberTextEditingController.text = organizationMember.phoneNumber;
    _aadhaarNumberTextEditingController.text = organizationMember.aadhaarNumber;

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
   * - Moves the focus to the last name text field.
   * - Submits the first name value to the controller for validation and state update.
   */
  void onFirstNameTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_lastNameFocusNode);
    organizationMemberController.onFirstNameSubmitted(value, widget.index, _firstNameFieldKey);
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
   * - Moves the focus to the email text field.
   * - Submits the last name value to the controller for validation and state update.
   */
  void onLastNameTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_emailFocusNode);
    organizationMemberController.onLastNameSubmitted(value, widget.index, _lastNameFieldKey);
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
   * - Moves the focus to the phone number text field.
   * - Submits the email value to the controller for validation and state update.
   */
  void onEmailTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_phoneNumberFocusNode);
    organizationMemberController.onEmailSubmitted(value, widget.index, _emailFieldKey);
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
   * - Moves the focus to the position text field.
   * - Submits the phone number value to the controller for validation and state update.
   */
  void onPhoneNumberTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_positionFocusNode);
    organizationMemberController.onPhoneNumberSubmitted(value, widget.index, _phoneNumberFieldKey);
  }

  /*
   * Handles the submission of the Aadhaar number text field.
   *
   * Parameters:
   * - `context`: The build context of the widget.
   * - `value`: The value entered in the Aadhaar number text field.
   *
   * Explanation:
   * - Unfocused the current text field.
   * - Moves the focus to the address text field.
   * - Submits the Aadhaar number value to the controller for validation and state update.
   */
  void onAadhaarNumberTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).requestFocus(_addressFocusNode);
    organizationMemberController.onAadhaarNumberSubmitted(value, widget.index, _aadhaarNumberFieldKey);
  }

  /*
   * Handles the submission of the address text field.
   *
   * Parameters:
   * - `context`: The build context of the widget.
   * - `value`: The value entered in the address text field.
   *
   * Explanation:
   * - Unfocused the current text field.
   * - Submits the address value to the controller for validation and state update.
   */
  void onAddressTextFieldSubmit(BuildContext context, String value) {
    FocusManager.instance.primaryFocus?.unfocus();
    organizationMemberController.onAddressSubmitted(value, widget.index, _addressFieldKey);
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
      child: GetBuilder<OrganizationMemberController>(
        builder: (organizationMemberControllerContext) {
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
                    controller: _firstNameTextEditingController,
                    labelText: appLocalizations.organizationMemberFormFirstNameTextFieldLabelText,
                    textInputAction: TextInputAction.next,
                    validator: organizationMemberControllerContext.firstNameValidator,
                    onChange: (String value) => organizationMemberControllerContext.onFirstNameChange(value, widget.index),
                    onFieldSubmitted: (String value) => onFirstNameTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _lastNameFieldKey,
                    focusNode: _lastNameFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    controller: _lastNameTextEditingController,
                    labelText: appLocalizations.organizationMemberFormLastNameTextFieldLabelText,
                    textInputAction: TextInputAction.next,
                    validator: organizationMemberControllerContext.lastNameValidator,
                    onChange: (String value) => organizationMemberControllerContext.onLastNameChange(value, widget.index),
                    onFieldSubmitted: (String value) => onLastNameTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _emailFieldKey,
                    focusNode: _emailFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputType: TextInputType.emailAddress,
                    controller: _emailTextEditingController,
                    labelText: appLocalizations.organizationMemberFormEmailTextFieldLabelText,
                    textInputAction: TextInputAction.next,
                    validator: organizationMemberControllerContext.emailValidator,
                    onChange: (String value) => organizationMemberControllerContext.onEmailChange(value, widget.index),
                    onFieldSubmitted: (String value) => onEmailTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _phoneNumberFieldKey,
                    focusNode: _phoneNumberFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputType: TextInputType.phone,
                    controller: _phoneNumberTextEditingController,
                    labelText: appLocalizations.organizationMemberFormPhoneNumberTextFieldLabelText,
                    textInputAction: TextInputAction.next,
                    validator: organizationMemberControllerContext.phoneNumberValidator,
                    onChange: (String value) => organizationMemberControllerContext.onPhoneNumberChange(value, widget.index),
                    onFieldSubmitted: (String value) => onPhoneNumberTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _aadhaarNumberFieldKey,
                    focusNode: _aadhaarNumberFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    textInputType: TextInputType.phone,
                    controller: _aadhaarNumberTextEditingController,
                    labelText: appLocalizations.organizationMemberFormAadhaarNumberTextFieldLabelText,
                    textInputAction: TextInputAction.next,
                    validator: organizationMemberControllerContext.aadhaarNumberValidator,
                    onChange: (String value) => organizationMemberControllerContext.onAadhaarNumberChange(value, widget.index),
                    onFieldSubmitted: (String value) => onAadhaarNumberTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: FloatingTextFieldWidget(
                    fieldKey: _addressFieldKey,
                    focusNode: _addressFocusNode,
                    appColorScheme: AppColorScheme.primary,
                    controller: _addressTextEditingController,
                    labelText: appLocalizations.organizationMemberFormAddressTextFieldLabelText,
                    textInputAction: TextInputAction.next,
                    validator: organizationMemberControllerContext.addressValidator,
                    onChange: (String value) => organizationMemberControllerContext.onAddressChange(value, widget.index),
                    onFieldSubmitted: (String value) => onAddressTextFieldSubmit(context, value),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: DropdownWidget(
                    fieldKey: _positionFieldKey,
                    validator: organizationMemberControllerContext.positionValidator,
                    labelText: appLocalizations.organizationMemberFormPositionDropdownFieldLabelText,
                    selectedItem: organizationMemberControllerContext.organizationMembers[widget.index].position.toLowerCase(),
                    appColorScheme: AppColorScheme.primary,
                    onChanged: (String value) => organizationMemberControllerContext.onPositionChange(value, widget.index, _positionFieldKey),
                    items: [
                      {"value": "president", "label": "President"},
                      {"value": "vice president", "label": "Vice President"},
                      {"value": "secretary", "label": "Secretary"},
                      {"value": "joint secretary", "label": "Joint Secretary"},
                      {"value": "treasurer", "label": "Treasurer"},
                      {"value": "member", "label": "Member"},
                      {"value": "principal", "label": "Principal"},
                      {"value": "other", "label": "Other"},
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: StateSelectionFormWidget(
                    formFieldKey: _stateFieldKey,
                    validator: organizationMemberControllerContext.stateValidator,
                    selectedState: organizationMemberControllerContext.organizationMembers[widget.index].state,
                    onChange: (state_model.State state) => organizationMemberControllerContext.onStateChange(state, widget.index, _stateFieldKey),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: DistrictSelectionFormWidget(
                    formFieldKey: _districtFieldKey,
                    validator: organizationMemberControllerContext.districtValidator,
                    selectedDistrict: organizationMemberControllerContext.organizationMembers[widget.index].district,
                    selectedState: organizationMemberControllerContext.organizationMembers[widget.index].state,
                    onChange: (District district) => organizationMemberControllerContext.onDistrictChange(district, widget.index, _districtFieldKey),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: CitySelectionFormWidget(
                    formFieldKey: _cityFieldKey,
                    validator: organizationMemberControllerContext.cityValidator,
                    selectedCity: organizationMemberControllerContext.organizationMembers[widget.index].city,
                    selectedDistrict: organizationMemberControllerContext.organizationMembers[widget.index].district,
                    onChange: (City city) => organizationMemberControllerContext.onCityChange(city, widget.index, _cityFieldKey),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: AreaNameSelectionFormWidget(
                    formFieldKey: _areaNameFieldKey,
                    validator: organizationMemberControllerContext.areaNameValidator,
                    selectedAreaName: organizationMemberControllerContext.organizationMembers[widget.index].areaName,
                    selectedCity: organizationMemberControllerContext.organizationMembers[widget.index].city,
                    onChange: (AreaName areaName) => organizationMemberControllerContext.onAreaNameChange(areaName, widget.index, _areaNameFieldKey),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: ZipcodeSelectionFormWidget(
                    formFieldKey: _zipcodeFieldKey,
                    validator: organizationMemberControllerContext.zipcodeValidator,
                    selectedAreaName: organizationMemberControllerContext.organizationMembers[widget.index].areaName,
                    selectedZipcode: organizationMemberControllerContext.organizationMembers[widget.index].zipcode,
                    onChange: (Zipcode zipcode) => organizationMemberControllerContext.onZipcodeChange(zipcode, widget.index, _zipcodeFieldKey),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      widget.isStepper
                          ? Container()
                          : organizationMemberControllerContext.isLoader
                          ? const ApiRequestLoaderWidget(appColorScheme: AppColorScheme.primary)
                          : Container(),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            margin: const EdgeInsets.only(left: 5),
                            child: ElevatedButtonWidget(
                              appColorScheme: AppColorScheme.primary,
                              buttonText: appLocalizations.submitButtonText.toUpperCase(),
                              disabled: false,
                              onPressed: () => onSubmitForm(context),
                            ),
                          ),
                        ],
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
