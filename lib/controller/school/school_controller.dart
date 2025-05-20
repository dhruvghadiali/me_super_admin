import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/model/school/school.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/school_type/school_type.dart';
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/education_board/education_board.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';
import 'package:me_super_admin/utils/validation_message/school_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/school_type_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/education_board_validation_message.dart';

class SchoolController extends GetxController {
  String snackbarTitle = "School Alert";
  School school = School.defaultValues();
  bool isLoader = false;

  void resetSchoolForm() {
    school = School.defaultValues();
    update();
  }

  void setSchoolForm(School schoolObj) {
    school = schoolObj;
    update();

    // if (organization.id.isNotEmpty) {
    //   Get.offAllNamed(RoutePaths.zipcodeForm);
    // }
  }

  /*
   * Validates the 'affiliate number' field in the form.
   *
   * Validation Rules:
   * - The field is required and displays a custom error message if left empty.
   * - Must be at least 5 characters.
   * - Must not exceed 50 characters.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? affiliateNumberValidator(String? value) {
    return ValidationBuilder(requiredMessage: SchoolValidationMessage.schoolAffiliateNumberRequired)
        .required(SchoolValidationMessage.schoolAffiliateNumberRequired)
        .minLength(5, SchoolValidationMessage.schoolAffiliateNumberMinLength)
        .maxLength(50, SchoolValidationMessage.schoolAffiliateNumberMaxLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'school name' field in the form.
   *
   * Validation Rules:
   * - The field is required and displays a custom error message if left empty.
   * - Must be at least 2 characters.
   * - Must not exceed 200 characters.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? nameValidator(String? value) {
    return ValidationBuilder(requiredMessage: SchoolValidationMessage.schoolNameRequired)
        .required(SchoolValidationMessage.schoolNameRequired)
        .minLength(2, SchoolValidationMessage.schoolNameMinLength)
        .maxLength(200, SchoolValidationMessage.schoolNameMaxLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'school short name' field in the form.
   *
   * Validation Rules:
   * - The field is optional.
   * - Must be at least 2 characters.
   * - Must not exceed 50 characters.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? shortNameValidator(String? value) {
    return ValidationBuilder(
      optional: true,
    ).minLength(2, SchoolValidationMessage.schoolShortNameMinLength).maxLength(50, SchoolValidationMessage.schoolShortNameMaxLength).build()(value?.trim());
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
    return ValidationBuilder(requiredMessage: SchoolValidationMessage.schoolEmailRequired)
        .required(SchoolValidationMessage.schoolEmailRequired)
        .minLength(10, SchoolValidationMessage.schoolEmailMinLength)
        .maxLength(100, SchoolValidationMessage.schoolEmailMaxLength)
        .email(SchoolValidationMessage.schoolEmailInvalid)
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
    return ValidationBuilder(requiredMessage: SchoolValidationMessage.schoolPhoneNumberRequired)
        .required(SchoolValidationMessage.schoolPhoneNumberRequired)
        .minLength(10, SchoolValidationMessage.schoolPhoneNumberLength)
        .maxLength(10, SchoolValidationMessage.schoolPhoneNumberLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'established year' field in the form.
   *
   * Validation Rules:
   * - The field is required and displays a custom error message if left empty.
   * - Must be a 4-digit year.
   * - Must be between 1700 and the current year.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? establishedYearValidator(String? value) {
    final currentYear = DateTime.now().year;
    return ValidationBuilder(requiredMessage: SchoolValidationMessage.schoolEstablishedYearRequired)
        .required(SchoolValidationMessage.schoolEstablishedYearRequired)
        .add((value) {
          if (value != null && value.isNotEmpty) {
            final year = int.tryParse(value);
            if (year == null || year < 1700 || year > currentYear) {
              return "${SchoolValidationMessage.schoolEstablishedYearInvalid} $currentYear";
            } else {
              return null;
            }
          } else {
            return SchoolValidationMessage.schoolEstablishedYearRequired;
          }
        })
        .regExp(RegExp(r'^\d{4}$'), SchoolValidationMessage.schoolEstablishedYearLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'school type' field in the form.
   *
   * Validation Rules:
   * - The field is required and displays a custom error message if left empty.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? schoolTypeValidator(String? value) {
    return ValidationBuilder(requiredMessage: SchoolTypeValidationMessage.schoolTypeRequired).required(SchoolTypeValidationMessage.schoolTypeRequired).build()(
      value?.trim(),
    );
  }

  /*
   * Validates the 'education board' field in the form.
   *
   * Validation Rules:
   * - The field is required and displays a custom error message if left empty.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? educationBoardValidator(String? value) {
    return ValidationBuilder(
      requiredMessage: EducationBoardValidationMessage.educationBoardRequired,
    ).required(EducationBoardValidationMessage.educationBoardRequired).build()(value?.trim());
  }

  /*
   * Handles the affiliate number change in the school form.
   *
   * This function updates the 'affiliate number' field in the 'school' object
   * whenever the affiliate number value changes. It trims any leading or trailing whitespace
   * from the input value before updating the affiliate number.
   *
   * After updating the affiliate number, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new affiliate number entered by the user, which will be trimmed of any extra spaces.
   */
  void onAffiliateNumberChange(String value) {
    school = school.copyWith(affiliateNumber: value.trim());
    update();
  }

  /*
   * Handles the submission of the affiliate number field in the school form.
   *
   * This function is triggered when the user submits the affiliate number field. It updates
   * the 'affiliate number' field in the 'school' object with the trimmed value
   * entered by the user. After updating the affiliate number, it triggers the validation
   * of the form field associated with the 'affiliate number' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The affiliate number entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onAffiliateNumberSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    school = school.copyWith(affiliateNumber: value.trim());
    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the name change in the school form.
   *
   * This function updates the 'name' field in the 'school' object
   * whenever the name value changes. It trims any leading or trailing whitespace
   * from the input value before updating the name.
   *
   * After updating the name, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new name entered by the user, which will be trimmed of any extra spaces.
   */
  void onNameChange(String value) {
    school = school.copyWith(name: value.trim());
    update();
  }

  /*
   * Handles the submission of the name field in the school form.
   *
   * This function is triggered when the user submits the name field. It updates
   * the 'name' field in the 'school' object with the trimmed value
   * entered by the user. After updating the name, it triggers the validation
   * of the form field associated with the 'name' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The name entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onNameSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    school = school.copyWith(name: value.trim());
    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the short name change in the school form.
   *
   * This function updates the 'short name' field in the 'school' object
   * whenever the short name value changes. It trims any leading or trailing whitespace
   * from the input value before updating the short name.
   *
   * After updating the short name, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new short name entered by the user, which will be trimmed of any extra spaces.
   */
  void onShortNameChange(String value) {
    school = school.copyWith(shortName: value.trim());
    update();
  }

  /*
   * Handles the submission of the short name field in the school form.
   *
   * This function is triggered when the user submits the short name field. It updates
   * the 'short name' field in the 'school' object with the trimmed value
   * entered by the user. After updating the short name, it triggers the validation
   * of the form field associated with the 'short name' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The short name entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onShortNameSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    school = school.copyWith(shortName: value.trim());
    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the email change in the school form.
   *
   * This function updates the 'email' field in the 'school' object
   * whenever the email value changes. It trims any leading or trailing whitespace
   * from the input value before updating the email.
   *
   * After updating the email, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new email entered by the user, which will be trimmed of any extra spaces.
   */
  void onEmailChange(String value) {
    school = school.copyWith(email: value.trim());
    update();
  }

  /*
   * Handles the submission of the email field in the school form.
   *
   * This function is triggered when the user submits the email field. It updates
   * the 'email' field in the 'school' object with the trimmed value
   * entered by the user. After updating the email, it triggers the validation
   * of the form field associated with the 'email' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The email entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onEmailSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    school = school.copyWith(email: value.trim());
    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the phone number change in the school form.
   *
   * This function updates the 'phone number' field in the 'school' object
   * whenever the phone number value changes. It trims any leading or trailing whitespace
   * from the input value before updating the phone number.
   *
   * After updating the phone number, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new phone number entered by the user, which will be trimmed of any extra spaces.
   */
  void onPhoneNumberChange(String value) {
    school = school.copyWith(phoneNumber: value.trim());
    update();
  }

  /*
   * Handles the submission of the phone number field in the school form.
   *
   * This function is triggered when the user submits the phone number field. It updates
   * the 'phone number' field in the 'school' object with the trimmed value
   * entered by the user. After updating the phone number, it triggers the validation
   * of the form field associated with the 'phone number' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The phone number entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onPhoneNumberSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    school = school.copyWith(phoneNumber: value.trim());
    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the established year change in the school form.
   *
   * This function updates the 'established year' field in the 'school' object
   * whenever the established year value changes. It trims any leading or trailing whitespace
   * from the input value before updating the established year.
   *
   * After updating the established year, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new established year entered by the user, which will be trimmed of any extra spaces.
   */
  void onEstablishedYearChange(String value) {
    school = school.copyWith(establishedYear: int.tryParse(value.trim()) ?? 0);
    update();
  }

  /*
   * Handles the submission of the established year field in the school form.
   *
   * This function is triggered when the user submits the established year field. It updates
   * the 'established year' field in the 'school' object with the trimmed value
   * entered by the user. After updating the established year, it triggers the validation
   * of the form field associated with the 'established year' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The established year entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onEstablishedYearSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    school = school.copyWith(establishedYear: int.tryParse(value.trim()) ?? 0);
    formFieldKey.currentState?.validate();
  }

  /*
   * Handles changes to the 'school type' field in the form.
   *
   * This function updates the school model's schoolType property with the selected value,
   * triggers validation on the provided form field key, and calls update() to notify listeners and refresh the UI.
   *
   * Steps:
   * - Updates the schoolType property of the school model with the selected value.
   * - Triggers validation on the provided form field key.
   * - Calls update() to refresh the UI.
   *
   * Parameters:
   * - value: The selected SchoolType object.
   * - formFieldKey: The key of the form field to validate.
   */
  void onSchoolTypeChange(SchoolType value, GlobalKey<FormFieldState> formFieldKey) {
    school = school.copyWith(schoolType: value);
    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles changes to the 'education boards' field (multi-select).
   *
   * This function updates the school model's educationBoards property with the selected list,
   * triggers validation on the provided form field key, and calls update() to notify listeners and refresh the UI.
   *
   * Steps:
   * - Updates the educationBoards property of the school model with the selected list.
   * - Triggers validation on the provided form field key.
   * - Calls update() to refresh the UI.
   *
   * Parameters:
   * - values: The list of selected EducationBoard objects.
   * - formFieldKey: The key of the form field to validate.
   */
  void onEducationBoardsChange(List<EducationBoard> values, GlobalKey<FormFieldState> formFieldKey) {
    school = school.copyWith(educationBoards: values);
    formFieldKey.currentState?.validate();
    update();
  }

  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      (school.id.isNotEmpty) ? await putSchool() : null;
    }
  }

  Future<void> putSchool() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/schools/${school.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: {}, // school.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(endPoint: 'assets/mock_data/schools/schools_200.json', statusCode: 200),
    );

    HttpResponseService response = await HttpService.putRequest(putHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      Snackbar.getSnackbar(title: snackbarTitle, message: response.message, appSnackbarStatus: AppSnackbarStatus.success);
      // Get.offAllNamed(RoutePaths.schools);
    } else {
      isLoader = false;
      Snackbar.getSnackbar(title: snackbarTitle, message: response.message, appSnackbarStatus: AppSnackbarStatus.error);
    }

    update();
  }
}
