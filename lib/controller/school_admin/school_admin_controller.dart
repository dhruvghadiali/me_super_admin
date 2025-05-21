import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/school_admin/school_admin.dart';
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';
import 'package:me_super_admin/utils/validation_message/school_admin_validation_message.dart';

class SchoolAdminController extends GetxController {
  String snackbarTitle = "School Admin Alert";
  List<SchoolAdmin> schoolAdmins = [];
  List<bool> schoolAdminFormValidated = [];
  int selectedIndex = 0;
  bool isLoader = false;

  /*
   * Resets the school admin form to its default values.
   *
   * This function sets the `schoolAdmin` object back to its default values using the `SchoolAdmin.defaultValues()` method.
   * This is useful for clearing the form or resetting it to its initial state when the user needs to start over.
   * After resetting the schoolAdmin, the `update()` method is called to refresh the UI and reflect the changes.
   *
   * Parameters:
   * None
   */
  void resetSchoolAdminForm() {
    schoolAdmins = [SchoolAdmin.defaultValues()];
    schoolAdminFormValidated = [false];
    update();
  }

  /*
   * Adds a new school admin form to the list.
   */
  void addSchoolAdminForm() {
    schoolAdmins.add(SchoolAdmin.defaultValues());
    schoolAdminFormValidated.add(false);
    update();
  }

  /*
   * Deletes a school admin form at the specified index.
   */
  void deleteSchoolAdminForm(int index) {
    schoolAdmins.removeAt(index);
    schoolAdminFormValidated.removeAt(index);
    update();
  }

  /*
   * Updates the validation status of a specific school admin form.
   */
  void changeSchoolAdminFormValidatedStatus(int index, bool status) {
    schoolAdminFormValidated[index] = status;
    update();
  }

  /*
   * Sets the school admin form data for the active form index.
   */
  void setSchoolAdminForm(SchoolAdmin schoolAdminObj) {
    schoolAdmins[selectedIndex] = schoolAdminObj;
    update();

    // if (schoolAddress.id.isNotEmpty) {
    //   Get.offAllNamed(RoutePaths.zipcodeForm);
    // }
  }

  /*
   * Validates the 'first name' field in the form.
   *
   * Validation Rules:
   * - The field is required and displays a custom error message if left empty.
   * - The length of the first name must be between 2 and 25 characters.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? firstNameValidator(String? value) {
    return ValidationBuilder(requiredMessage: SchoolAdminValidationMessage.firstNameRequired)
        .required(SchoolAdminValidationMessage.firstNameRequired)
        .minLength(2, SchoolAdminValidationMessage.firstNameMinLength)
        .maxLength(25, SchoolAdminValidationMessage.firstNameMaxLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'last name' field in the form.
   *
   * Validation Rules:
   * - The field is required and displays a custom error message if left empty.
   * - The length of the last name must be between 2 and 25 characters.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? lastNameValidator(String? value) {
    return ValidationBuilder(requiredMessage: SchoolAdminValidationMessage.lastNameRequired)
        .required(SchoolAdminValidationMessage.lastNameRequired)
        .minLength(2, SchoolAdminValidationMessage.lastNameMinLength)
        .maxLength(25, SchoolAdminValidationMessage.lastNameMaxLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'email' field of the organization form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   * - Must be at least 10 characters long.
   * - Must not exceed 100 characters.
   * - Must be a valid email address.
   * 
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? emailValidator(String? value) {
    return ValidationBuilder(requiredMessage: SchoolAdminValidationMessage.schoolAdminEmailRequired)
        .required(SchoolAdminValidationMessage.schoolAdminEmailRequired)
        .minLength(10, SchoolAdminValidationMessage.schoolAdminEmailMinLength)
        .maxLength(100, SchoolAdminValidationMessage.schoolAdminEmailMaxLength)
        .email(SchoolAdminValidationMessage.schoolAdminEmailInvalid)
        .build()(value?.trim());
  }

  /*
   * Validates the 'phone number' field of the organization form.
   *
   * Validation Rules:
   * - This field is required (with a custom error message).
   * - Must be exactly 10 digits long (using both minLength and maxLength set to 10).
   * 
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input is valid.
   */
  String? phoneNumberValidator(String? value) {
    return ValidationBuilder(requiredMessage: SchoolAdminValidationMessage.schoolAdminPhoneNumberRequired)
        .required(SchoolAdminValidationMessage.schoolAdminPhoneNumberRequired)
        .minLength(10, SchoolAdminValidationMessage.schoolAdminPhoneNumberLength)
        .maxLength(10, SchoolAdminValidationMessage.schoolAdminPhoneNumberLength)
        .build()(value?.trim());
  }

  /*
   * Handles the first name change in the school admin form.
   *
   * This function updates the 'firstName' field in the active school admin object
   * whenever the first name value changes. It trims any leading or trailing whitespace
   * from the input value before updating the state.
   *
   * After updating the first name, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new first name entered by the user, which will be trimmed of any extra spaces.
   */
  void onFirstNameChange(String value, int index) {
    SchoolAdmin schoolAdmin = schoolAdmins[index];

    schoolAdmin = schoolAdmin.copyWith(firstName: value.trim());
    schoolAdmins[index] = schoolAdmin;

    update();
  }

  /*
   * Handles the submission of the first name field in the school admin form.
   *
   * This function is triggered when the user submits the first name field. It updates
   * the 'firstName' field in the active school admin object with the trimmed value
   * entered by the user. After updating the first name, it triggers the validation
   * of the form field associated with the 'firstName' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The first name entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onFirstNameSubmitted(String value, int index, GlobalKey<FormFieldState> formFieldKey) {
    SchoolAdmin schoolAdmin = schoolAdmins[index];

    schoolAdmin = schoolAdmin.copyWith(firstName: value.trim());
    schoolAdmins[index] = schoolAdmin;

    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the last name change in the school admin form.
   *
   * This function updates the 'lastName' field in the active school admin object
   * whenever the last name value changes. It trims any leading or trailing whitespace
   * from the input value before updating the state.
   *
   * After updating the last name, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new last name entered by the user, which will be trimmed of any extra spaces.
   */
  void onLastNameChange(String value, int index) {
    SchoolAdmin schoolAdmin = schoolAdmins[index];

    schoolAdmin = schoolAdmin.copyWith(lastName: value.trim());
    schoolAdmins[index] = schoolAdmin;

    update();
  }

  /*
   * Handles the submission of the last name field in the school admin form.
   *
   * This function is triggered when the user submits the last name field. It updates
   * the 'lastName' field in the active school admin object with the trimmed value
   * entered by the user. After updating the last name, it triggers the validation
   * of the form field associated with the 'lastName' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The last name entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onLastNameSubmitted(String value, int index, GlobalKey<FormFieldState> formFieldKey) {
    SchoolAdmin schoolAdmin = schoolAdmins[index];

    schoolAdmin = schoolAdmin.copyWith(lastName: value.trim());
    schoolAdmins[index] = schoolAdmin;

    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the email change in the school admin form.
   *
   * This function updates the 'email' field in the active school admin object
   * whenever the email value changes. It trims any leading or trailing whitespace
   * from the input value before updating the state.
   *
   * After updating the email, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new email entered by the user, which will be trimmed of any extra spaces.
   */
  void onEmailChange(String value, int index) {
    SchoolAdmin schoolAdmin = schoolAdmins[index];

    schoolAdmin = schoolAdmin.copyWith(email: value.trim());
    schoolAdmins[index] = schoolAdmin;

    update();
  }

  /*
   * Handles the submission of the email field in the school admin form.
   *
   * This function is triggered when the user submits the email field. It updates
   * the 'email' field in the active school admin object with the trimmed value
   * entered by the user. After updating the email, it triggers the validation
   * of the form field associated with the 'email' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The email entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onEmailSubmitted(String value, int index, GlobalKey<FormFieldState> formFieldKey) {
    SchoolAdmin schoolAdmin = schoolAdmins[index];

    schoolAdmin = schoolAdmin.copyWith(email: value.trim());
    schoolAdmins[index] = schoolAdmin;

    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the phone number change in the school admin form.
   *
   * This function updates the 'phoneNumber' field in the active school admin object
   * whenever the phone number value changes. It trims any leading or trailing whitespace
   * from the input value before updating the state.
   *
   * After updating the phone number, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new phone number entered by the user, which will be trimmed of any extra spaces.
   */
  void onPhoneNumberChange(String value, int index) {
    SchoolAdmin schoolAdmin = schoolAdmins[index];

    schoolAdmin = schoolAdmin.copyWith(phoneNumber: value.trim());
    schoolAdmins[index] = schoolAdmin;

    update();
  }

  /*
   * Handles the submission of the phone number field in the school admin form.
   *
   * This function is triggered when the user submits the phone number field. It updates
   * the 'phoneNumber' field in the active school admin object with the trimmed value
   * entered by the user. After updating the phone number, it triggers the validation
   * of the form field associated with the 'phoneNumber' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The phone number entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onPhoneNumberSubmitted(String value, int index, GlobalKey<FormFieldState> formFieldKey) {
    SchoolAdmin schoolAdmin = schoolAdmins[index];

    schoolAdmin = schoolAdmin.copyWith(phoneNumber: value.trim());
    schoolAdmins[index] = schoolAdmin;

    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the form submission and validates the form fields.
   *
   * This function first validates the form using the provided formKey. If the form is valid,
   * it checks if the schoolAdmin already has an ID. If the schoolAdmin ID is not empty,
   * it proceeds to update the schoolAdmin by calling the `putSchoolAdmin` method.
   * If the schoolAdmin ID is empty, no action is performed.
   *
   * Parameters:
   * - `formKey`: The global key for the form, used to trigger form validation.
   */
  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      // (schoolAdmin.id.isNotEmpty) ? await putSchoolAdmin() : null;
    }
  }

  /*
   * Sends a PUT request to update the school admin details.
   *
   * This function first retrieves the authentication token using `Utils.getAuthToken()`.
   * It then sets `isLoader` to true to indicate that the operation is in progress and updates the UI.
   * A PUT request is made using the `PutHttpService` with the necessary headers and body data (the school admin data).
   * The `HttpService.putRequest` method sends the request and receives the response.
   *
   * If the request is successful (`AppHttpRequestStatus.isSuccessfullyServiced`), 
   * a success message is shown via a Snackbar, and the user is navigated to the schools page.
   * If the request fails, an error message is displayed using a Snackbar.
   *
   * Parameters: 
   * None
   */
  Future<void> putSchoolAdmin(int index) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/schools/${schoolAdmins[index].id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: schoolAdmins[index].toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(endPoint: 'assets/mock_data/schools/schools_200.json', statusCode: 200),
    );

    HttpResponseService response = await HttpService.putRequest(putHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      Snackbar.getSnackbar(title: snackbarTitle, message: response.message, appSnackbarStatus: AppSnackbarStatus.success);
      Get.offAllNamed(RoutePaths.zipcodes); // schools
    } else {
      isLoader = false;
      Snackbar.getSnackbar(title: snackbarTitle, message: response.message, appSnackbarStatus: AppSnackbarStatus.error);
    }

    update();
  }
}
