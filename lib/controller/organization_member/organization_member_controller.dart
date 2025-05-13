import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/model/zipcode/zipcode.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/area_name/area_name.dart';
import 'package:me_super_admin/model/state/state.dart' as state_mode;
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/organization_member/organization_member.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';
import 'package:me_super_admin/utils/validation_message/zipcode_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/area_name_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/city_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/state_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/district_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/organization_member_validation_message.dart';

class OrganizationMemberController extends GetxController {
  /*
   * This controller manages the state and operations related to organization members.
   * It includes functionalities for adding, deleting, and updating organization member forms,
   * as well as handling form validation and state changes for nested fields like state, district, city, etc.
   * The controller also provides validation methods for various fields and integrates with HTTP services
   * to perform CRUD operations on organization member data.
   */

  String snackbarTitle = "Organization Member Alert";
  int activeOrganizationMemberFormIndex = 0;
  List<OrganizationMember> organizationMembers = [];
  List<bool> organizationMemberFormValidated = [];
  bool isLoader = false;

  /*
   * Resets the organization member form to its default state with two empty forms.
   */
  void resetOrganizationMemberForm() {
    organizationMembers = [OrganizationMember.defaultValues(), OrganizationMember.defaultValues()];
    organizationMemberFormValidated = [false, false];
    activeOrganizationMemberFormIndex = 0;
    update();
  }

  /*
   * Adds a new organization member form to the list.
   */
  void addOrganizationMemberForm() {
    organizationMembers.add(OrganizationMember.defaultValues());
    organizationMemberFormValidated.add(false);
    update();
  }

  /*
   * Deletes an organization member form at the specified index.
   */
  void deleteOrganizationMemberForm(int index) {
    organizationMembers.removeAt(index);
    organizationMemberFormValidated.removeAt(index);
    update();
  }

  /*
   * Updates the validation status of a specific organization member form.
   */
  void changeOrganizationMemberFormValidatedStatus(int index, bool status) {
    organizationMemberFormValidated[index] = status;
    update();
  }

  /*
   * Changes the active organization member form index.
   */
  void changeActiveOrganizationMemberFormIndex(int index) {
    activeOrganizationMemberFormIndex = index;
    update();
  }

  /*
   * Sets the organization member form data for the active form index.
   */
  void setOrganizationMemberForm(OrganizationMember organizationMemberObj) {
    // organizationMember = organizationMemberObj;
    update();

    // if (organization.id.isNotEmpty) {
    //   Get.offAllNamed(RoutePaths.zipcodeForm);
    // }
  }

  /*
   * Validates the 'first name' field of the organization member form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   * - Must be at least 2 characters long.
   * - Must not exceed 25 characters.
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? firstNameValidator(String? value) {
    return ValidationBuilder(requiredMessage: OrganizationMemberValidationMessage.organizationMemberFirstNameRequired)
        .required(OrganizationMemberValidationMessage.organizationMemberFirstNameRequired)
        .minLength(2, OrganizationMemberValidationMessage.organizationMemberFirstNameMinLength)
        .maxLength(25, OrganizationMemberValidationMessage.organizationMemberFirstNameMaxLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'last name' field of the organization member form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   * - Must be at least 2 characters long.
   * - Must not exceed 25 characters.
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? lastNameValidator(String? value) {
    return ValidationBuilder(requiredMessage: OrganizationMemberValidationMessage.organizationMemberLastNameRequired)
        .required(OrganizationMemberValidationMessage.organizationMemberLastNameRequired)
        .minLength(2, OrganizationMemberValidationMessage.organizationMemberLastNameMinLength)
        .maxLength(25, OrganizationMemberValidationMessage.organizationMemberLastNameMaxLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'email' field of the organization member form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   * - Must be at least 5 characters long.
   * - Must not exceed 100 characters.
   * - Must be a valid email address.
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? emailValidator(String? value) {
    return ValidationBuilder(requiredMessage: OrganizationMemberValidationMessage.organizationMemberEmailRequired)
        .required(OrganizationMemberValidationMessage.organizationMemberEmailRequired)
        .minLength(5, OrganizationMemberValidationMessage.organizationMemberEmailMinLength)
        .maxLength(100, OrganizationMemberValidationMessage.organizationMemberEmailMaxLength)
        .email(OrganizationMemberValidationMessage.organizationMemberEmailInvalid)
        .build()(value?.trim());
  }

  /*
   * Validates the 'phone number' field of the organization member form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   * - Must be exactly 10 digits long.
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? phoneNumberValidator(String? value) {
    return ValidationBuilder(requiredMessage: OrganizationMemberValidationMessage.organizationMemberPhoneNumberRequired)
        .required(OrganizationMemberValidationMessage.organizationMemberPhoneNumberRequired)
        .minLength(10, OrganizationMemberValidationMessage.organizationMemberPhoneNumberLength)
        .maxLength(10, OrganizationMemberValidationMessage.organizationMemberPhoneNumberLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'position' field of the organization member form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? positionValidator(String? value) {
    return ValidationBuilder(
      requiredMessage: OrganizationMemberValidationMessage.organizationMemberPositionRequired,
    ).required(OrganizationMemberValidationMessage.organizationMemberPositionRequired).build()(value?.trim());
  }

  /*
   * Validates the 'Aadhaar number' field of the organization member form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   * - Must be exactly 12 digits long.
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? aadhaarNumberValidator(String? value) {
    return ValidationBuilder(requiredMessage: OrganizationMemberValidationMessage.organizationMemberAadhaarNumberRequired)
        .required(OrganizationMemberValidationMessage.organizationMemberAadhaarNumberRequired)
        .minLength(12, OrganizationMemberValidationMessage.organizationMemberAadhaarNumberLength)
        .maxLength(12, OrganizationMemberValidationMessage.organizationMemberAadhaarNumberLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'address' field of the organization member form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   * - Must be at least 10 characters long.
   * - Must not exceed 500 characters.
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? addressValidator(String? value) {
    return ValidationBuilder(requiredMessage: OrganizationMemberValidationMessage.organizationMemberAddressRequired)
        .required(OrganizationMemberValidationMessage.organizationMemberAddressRequired)
        .minLength(10, OrganizationMemberValidationMessage.organizationMemberAddressMinLength)
        .maxLength(500, OrganizationMemberValidationMessage.organizationMemberAddressMaxLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'state' field of the organization member form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? stateValidator(String? value) {
    return ValidationBuilder(requiredMessage: StateFormValidationMessage.stateRequired).required(StateFormValidationMessage.stateRequired).build()(
      value?.trim(),
    );
  }

  /*
   * Validates the 'district' field of the organization member form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? districtValidator(String? value) {
    return ValidationBuilder(requiredMessage: DistrictFormValidationMessage.districtRequired).required(DistrictFormValidationMessage.districtRequired).build()(
      value?.trim(),
    );
  }

  /*
   * Validates the 'city' field of the organization member form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? cityValidator(String? value) {
    return ValidationBuilder(requiredMessage: CityFormValidationMessage.cityRequired).required(CityFormValidationMessage.cityRequired).build()(value?.trim());
  }

  /*
   * Validates the 'area name' field of the organization member form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? areaNameValidator(String? value) {
    return ValidationBuilder(requiredMessage: AreaNameFormValidationMessage.areaNameRequired).required(AreaNameFormValidationMessage.areaNameRequired).build()(
      value?.trim(),
    );
  }

  /*
   * Validates the 'zipcode' field of the organization member form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? zipcodeValidator(String? value) {
    return ValidationBuilder(requiredMessage: ZipcodeFormValidationMessage.zipcodeRequired).required(ZipcodeFormValidationMessage.zipcodeRequired).build()(
      value?.trim(),
    );
  }

  /*
   * Handles the state change in the organization member form.
   *
   * This function updates the 'state' field in the active organization member object
   * whenever the state value changes. It also resets dependent fields such as 'district',
   * 'city', 'areaName', and 'zipcode' to their default states.
   *
   * After updating the state and dependent fields, the function validates the form field
   * associated with the 'state' field using the provided `formFieldKey` and calls `update()`
   * to ensure the UI reflects the changes.
   *
   * Parameters:
   * - `value`: The new state selected by the user.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onStateChange(state_mode.State value, GlobalKey<FormFieldState> formFieldKey) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    Zipcode zipcode = organizationMember.zipcode;
    AreaName areaName = zipcode.areaName;
    City city = areaName.city;
    District district = city.district;

    district = district.copyWith(state: value, id: "", name: "");
    city = city.copyWith(district: district, id: "", name: "");
    areaName = areaName.copyWith(city: city, id: "", name: "");
    zipcode = zipcode.copyWith(areaName: areaName, id: "", zipcode: "");

    organizationMember = organizationMember.copyWith(state: value);
    organizationMember = organizationMember.copyWith(district: district);
    organizationMember = organizationMember.copyWith(city: city);
    organizationMember = organizationMember.copyWith(areaName: areaName);
    organizationMember = organizationMember.copyWith(zipcode: zipcode);

    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles the district change in the organization member form.
   *
   * This function updates the 'district' field in the active organization member object
   * whenever the district value changes. It also resets dependent fields such as 'city',
   * 'areaName', and 'zipcode' to their default states.
   *
   * After updating the district and dependent fields, the function validates the form field
   * associated with the 'district' field using the provided `formFieldKey` and calls `update()`
   * to ensure the UI reflects the changes.
   *
   * Parameters:
   * - `value`: The new district selected by the user.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onDistrictChange(District value, GlobalKey<FormFieldState> formFieldKey) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    Zipcode zipcode = organizationMember.zipcode;
    AreaName areaName = zipcode.areaName;
    City city = areaName.city;

    city = city.copyWith(district: value, id: "", name: "");
    areaName = areaName.copyWith(city: city, id: "", name: "");
    zipcode = zipcode.copyWith(areaName: areaName, id: "", zipcode: "");
    organizationMember = organizationMember.copyWith(district: value);
    organizationMember = organizationMember.copyWith(city: city);
    organizationMember = organizationMember.copyWith(areaName: areaName);
    organizationMember = organizationMember.copyWith(zipcode: zipcode);

    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    formFieldKey.currentState?.validate();

    update();
  }

  /*
   * Handles the city change in the organization member form.
   *
   * This function updates the 'city' field in the active organization member object
   * whenever the city value changes. It also resets dependent fields such as 'areaName'
   * and 'zipcode' to their default states.
   *
   * After updating the city and dependent fields, the function validates the form field
   * associated with the 'city' field using the provided `formFieldKey` and calls `update()`
   * to ensure the UI reflects the changes.
   *
   * Parameters:
   * - `value`: The new city selected by the user.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onCityChange(City value, GlobalKey<FormFieldState> formFieldKey) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    Zipcode zipcode = organizationMember.zipcode;
    AreaName areaName = zipcode.areaName;

    areaName = areaName.copyWith(city: value, id: "", name: "");
    zipcode = zipcode.copyWith(areaName: areaName, id: "", zipcode: "");
    organizationMember = organizationMember.copyWith(city: value);
    organizationMember = organizationMember.copyWith(areaName: areaName);
    organizationMember = organizationMember.copyWith(zipcode: zipcode);

    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles the area name change in the organization member form.
   *
   * This function updates the 'areaName' field in the active organization member object
   * whenever the area name value changes. It also resets the 'zipcode' field to its default state.
   *
   * After updating the area name and dependent fields, the function validates the form field
   * associated with the 'areaName' field using the provided `formFieldKey` and calls `update()`
   * to ensure the UI reflects the changes.
   *
   * Parameters:
   * - `value`: The new area name selected by the user.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onAreaNameChange(AreaName value, GlobalKey<FormFieldState> formFieldKey) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    Zipcode zipcode = organizationMember.zipcode;

    zipcode = zipcode.copyWith(areaName: value, id: "", zipcode: "");
    organizationMember = organizationMember.copyWith(areaName: value);
    organizationMember = organizationMember.copyWith(zipcode: zipcode);

    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles the zipcode change in the organization member form.
   *
   * This function updates the 'zipcode' field in the active organization member object
   * whenever the zipcode value changes.
   *
   * After updating the zipcode, the function validates the form field associated with
   * the 'zipcode' field using the provided `formFieldKey` and calls `update()` to ensure
   * the UI reflects the changes.
   *
   * Parameters:
   * - `value`: The new zipcode entered by the user.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onZipcodeChange(Zipcode value, GlobalKey<FormFieldState> formFieldKey) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(zipcode: value);

    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles the position change in the organization member form.
   *
   * This function updates the 'position' field in the active organization member object
   * whenever the position value changes. It trims any leading or trailing whitespace
   * from the input value before updating the state.
   *
   * After updating the position, the function validates the form field associated with
   * the 'position' field using the provided `formFieldKey` and calls `update()` to ensure
   * the UI reflects the changes.
   *
   * Parameters:
   * - `value`: The new position entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onPositionChange(String value, GlobalKey<FormFieldState> formFieldKey) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(position: value.trim());
    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles the first name change in the organization member form.
   *
   * This function updates the 'firstName' field in the active organization member object
   * whenever the first name value changes. It trims any leading or trailing whitespace
   * from the input value before updating the state.
   *
   * After updating the first name, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new first name entered by the user, which will be trimmed of any extra spaces.
   */
  void onFirstNameChange(String value) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(firstName: value.trim());
    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    update();
  }

  /*
   * Handles the submission of the first name field in the organization member form.
   *
   * This function is triggered when the user submits the first name field. It updates
   * the 'firstName' field in the active organization member object with the trimmed value
   * entered by the user. After updating the first name, it triggers the validation
   * of the form field associated with the 'firstName' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The first name entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onFirstNameSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(firstName: value.trim());
    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the last name change in the organization member form.
   *
   * This function updates the 'lastName' field in the active organization member object
   * whenever the last name value changes. It trims any leading or trailing whitespace
   * from the input value before updating the state.
   *
   * After updating the last name, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new last name entered by the user, which will be trimmed of any extra spaces.
   */
  void onLastNameChange(String value) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(lastName: value.trim());
    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    update();
  }

  /*
   * Handles the submission of the last name field in the organization member form.
   *
   * This function is triggered when the user submits the last name field. It updates
   * the 'lastName' field in the active organization member object with the trimmed value
   * entered by the user. After updating the last name, it triggers the validation
   * of the form field associated with the 'lastName' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The last name entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onLastNameSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(lastName: value.trim());
    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the email change in the organization member form.
   *
   * This function updates the 'email' field in the active organization member object
   * whenever the email value changes. It trims any leading or trailing whitespace
   * from the input value before updating the state.
   *
   * After updating the email, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new email entered by the user, which will be trimmed of any extra spaces.
   */
  void onEmailChange(String value) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(email: value.trim());
    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    update();
  }

  /*
   * Handles the submission of the email field in the organization member form.
   *
   * This function is triggered when the user submits the email field. It updates
   * the 'email' field in the active organization member object with the trimmed value
   * entered by the user. After updating the email, it triggers the validation
   * of the form field associated with the 'email' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The email entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onEmailSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(email: value.trim());
    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the phone number change in the organization member form.
   *
   * This function updates the 'phoneNumber' field in the active organization member object
   * whenever the phone number value changes. It trims any leading or trailing whitespace
   * from the input value before updating the state.
   *
   * After updating the phone number, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new phone number entered by the user, which will be trimmed of any extra spaces.
   */
  void onPhoneNumberChange(String value) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(phoneNumber: value.trim());
    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    update();
  }

  /*
   * Handles the submission of the phone number field in the organization member form.
   *
   * This function is triggered when the user submits the phone number field. It updates
   * the 'phoneNumber' field in the active organization member object with the trimmed value
   * entered by the user. After updating the phone number, it triggers the validation
   * of the form field associated with the 'phoneNumber' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The phone number entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onPhoneNumberSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(phoneNumber: value.trim());
    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the Aadhaar number change in the organization member form.
   *
   * This function updates the 'aadhaarNumber' field in the active organization member object
   * whenever the Aadhaar number value changes. It trims any leading or trailing whitespace
   * from the input value before updating the state.
   *
   * After updating the Aadhaar number, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new Aadhaar number entered by the user, which will be trimmed of any extra spaces.
   */
  void onAadhaarNumberChange(String value) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(aadhaarNumber: value.trim());
    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    update();
  }

  /*
   * Handles the submission of the Aadhaar number field in the organization member form.
   *
   * This function is triggered when the user submits the Aadhaar number field. It updates
   * the 'aadhaarNumber' field in the active organization member object with the trimmed value
   * entered by the user. After updating the Aadhaar number, it triggers the validation
   * of the form field associated with the 'aadhaarNumber' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The Aadhaar number entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onAadhaarNumberSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(aadhaarNumber: value.trim());
    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the address change in the organization member form.
   *
   * This function updates the 'address' field in the active organization member object
   * whenever the address value changes. It trims any leading or trailing whitespace
   * from the input value before updating the state.
   *
   * After updating the address, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new address entered by the user, which will be trimmed of any extra spaces.
   */
  void onAddressChange(String value) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(address: value.trim());
    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    update();
  }

  /*
   * Handles the submission of the address field in the organization member form.
   *
   * This function is triggered when the user submits the address field. It updates
   * the 'address' field in the active organization member object with the trimmed value
   * entered by the user. After updating the address, it triggers the validation
   * of the form field associated with the 'address' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The address entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onAddressSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    OrganizationMember organizationMember = organizationMembers[activeOrganizationMemberFormIndex];

    organizationMember = organizationMember.copyWith(address: value.trim());
    organizationMembers[activeOrganizationMemberFormIndex] = organizationMember;

    formFieldKey.currentState?.validate();
  }

  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      // (organizationMember.id.isNotEmpty) ? await putOrganizationMember() : null;
    }
  }

  /*
   * Updates an existing organization member's details on the server.
   *
   * This function sends a PUT request to update the details of the specified
   * organization member. It uses the `PutHttpService` to construct the request
   * with the necessary endpoint, headers, and body. The function also handles
   * the response to display appropriate success or error messages using a snackbar.
   *
   * Parameters:
   * - `organizationMember`: The organization member object containing updated details.
   *
   * Returns:
   * - A `Future` that completes when the request is processed.
   */
  Future<void> putOrganizationMember(OrganizationMember organizationMember) async {
    String authToken = await Utils.getAuthToken();
    // isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/organization-members/${organizationMember.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: organizationMember.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(endPoint: 'assets/mock_data/organization_members/organization_members_200.json', statusCode: 200),
    );

    HttpResponseService response = await HttpService.putRequest(putHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      Snackbar.getSnackbar(title: snackbarTitle, message: response.message, appSnackbarStatus: AppSnackbarStatus.success);
      Get.offAllNamed(RoutePaths.zipcodes);
    } else {
      isLoader = false;
      Snackbar.getSnackbar(title: snackbarTitle, message: response.message, appSnackbarStatus: AppSnackbarStatus.error);
    }

    update();
  }

  /*
   * Deletes an organization member from the server.
   *
   * This function sends a DELETE request to remove the specified organization member
   * from the server. It uses the `DeleteHttpService` to construct the request with
   * the necessary endpoint and headers. The function also handles the response to
   * display appropriate success or error messages using a snackbar.
   *
   * Parameters:
   * - `id`: The unique identifier of the organization member to be deleted.
   *
   * Returns:
   * - A `Future` that completes when the request is processed.
   */
  Future<void> deleteOrganizationMember(String id) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    DeleteHttpService deleteHttpService = DeleteHttpService(
      endPoint: 'super-admin/organization-members/$id',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(endPoint: 'assets/mock_data/organization_members/organization_members_200.json', statusCode: 200),
    );

    HttpResponseService response = await HttpService.deleteRequest(deleteHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      Snackbar.getSnackbar(title: snackbarTitle, message: response.message, appSnackbarStatus: AppSnackbarStatus.success);
    } else {
      isLoader = false;
      Snackbar.getSnackbar(title: snackbarTitle, message: response.message, appSnackbarStatus: AppSnackbarStatus.error);
    }

    update();
  }
}
