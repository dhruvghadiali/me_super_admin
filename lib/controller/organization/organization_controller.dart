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
import 'package:me_super_admin/model/organization/organization.dart';
import 'package:me_super_admin/model/state/state.dart' as state_mode;
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';
import 'package:me_super_admin/utils/validation_message/zipcode_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/area_name_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/city_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/state_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/organization_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/district_form_validation_message.dart';

class OrganizationController extends GetxController {
  String snackbarTitle = "Organization Alert";
  Organization organization = Organization.defaultValues();
  bool isLoader = false;

  /*
   * Resets the organization form to its default values.
   *
   * This function sets the `organization` object back to its default values using the `Organization.defaultValues()` method. 
   * This is useful for clearing the form or resetting it to its initial state when the user needs to start over. 
   * After resetting the organization, the `update()` method is called to refresh the UI and reflect the changes.
   *
   * Parameters: 
   * None
   */
  void resetOrganizationForm() {
    organization = Organization.defaultValues();
    update();
  }

  void setOrganizationForm(Organization organizationObj) {
    organization = organizationObj;
    update();

    // if (organization.id.isNotEmpty) {
    //   Get.offAllNamed(RoutePaths.zipcodeForm);
    // }
  }

  /*
   * Validates the 'name' field of the organization form.
   *
   *  Applies the following rules:
   * - Field is required (shows custom required message).
   * - Must be at least 2 characters long.
   * - Must not exceed 100 characters.
   * 
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? nameValidator(String? value) {
    return ValidationBuilder(requiredMessage: OrganizationValidationMessage.organizationNameRequired)
        .required(OrganizationValidationMessage.organizationNameRequired)
        .minLength(2, OrganizationValidationMessage.organizationNameMinLength)
        .maxLength(100, OrganizationValidationMessage.organizationNameMaxLength)
        .build()(value?.trim());
  }

  /*
   * Validates the optional 'short name' field of the organization form.
   *
   *  Applies the following rules:
   * - Field is optional.
   * - If provided, it must be at least 2 characters long.
   * - Must not exceed 50 characters.
   * 
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid or empty.
   */
  String? shortNameValidator(String? value) {
    return ValidationBuilder(optional: true)
        .minLength(2, OrganizationValidationMessage.organizationShortNameMinLength)
        .maxLength(50, OrganizationValidationMessage.organizationShortNameMaxLength)
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
    return ValidationBuilder(requiredMessage: OrganizationValidationMessage.organizationEmailRequired)
        .required(OrganizationValidationMessage.organizationEmailRequired)
        .minLength(10, OrganizationValidationMessage.organizationEmailMinLength)
        .maxLength(100, OrganizationValidationMessage.organizationEmailMaxLength)
        .email(OrganizationValidationMessage.organizationEmailInvalid)
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
    return ValidationBuilder(requiredMessage: OrganizationValidationMessage.organizationPhoneNumberRequired)
        .required(OrganizationValidationMessage.organizationPhoneNumberRequired)
        .minLength(10, OrganizationValidationMessage.organizationPhoneNumberLength)
        .maxLength(10, OrganizationValidationMessage.organizationPhoneNumberLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'government registration number' field of the organization form.
   *
   * Validation Rules:
   * - This field is required and shows a custom error message if left empty.
   * - The input must be at least 5 characters long.
   * - The input must not exceed 50 characters.
   * 
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? governmentRegistrationNumberValidator(String? value) {
    return ValidationBuilder(requiredMessage: OrganizationValidationMessage.organizationGovernmentRegistrationNumberRequired)
        .required(OrganizationValidationMessage.organizationGovernmentRegistrationNumberRequired)
        .minLength(5, OrganizationValidationMessage.organizationGovernmentRegistrationNumberMinLength)
        .maxLength(50, OrganizationValidationMessage.organizationGovernmentRegistrationNumberMaxLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'address' field of the organization form.
   *
   * Validation Rules:
   * - This field is required and displays a custom error message if empty.
   * - The address must be at least 10 characters long.
   * - The address must not exceed 500 characters in length.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? addressValidator(String? value) {
    return ValidationBuilder(requiredMessage: OrganizationValidationMessage.organizationAddressRequired)
        .required(OrganizationValidationMessage.organizationAddressRequired)
        .minLength(10, OrganizationValidationMessage.organizationAddressMinLength)
        .maxLength(500, OrganizationValidationMessage.organizationAddressMaxLength)
        .build()(value?.trim());
  }

  /*
   * Validates the 'state' field in the form.
   *
   * Validation Rules:
   * - The field is required and displays a custom error message if left empty.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? stateValidator(String? value) {
    return ValidationBuilder(requiredMessage: StateFormValidationMessage.stateRequired).required(StateFormValidationMessage.stateRequired).build()(
      value?.trim(),
    );
  }

  /*
   * Validates the 'district' field in the form.
   *
   * Validation Rules:
   * - The field is mandatory.
   * - A custom error message is shown if the field is left empty.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input is valid.
   */
  String? districtValidator(String? value) {
    return ValidationBuilder(requiredMessage: DistrictFormValidationMessage.districtRequired).required(DistrictFormValidationMessage.districtRequired).build()(
      value?.trim(),
    );
  }

  /*
   * Validates the 'city' field in the form.
   *
   * Validation Rules:
   * - The field is required and displays a custom error message if left empty.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? cityValidator(String? value) {
    return ValidationBuilder(requiredMessage: CityFormValidationMessage.cityRequired).required(CityFormValidationMessage.cityRequired).build()(value?.trim());
  }

  /*
   * Validates the 'area name' field in the form.
   *
   * Validation Rules:
   * - The field is required and displays a custom error message if left empty.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? areaNameValidator(String? value) {
    return ValidationBuilder(requiredMessage: AreaNameFormValidationMessage.areaNameRequired).required(AreaNameFormValidationMessage.areaNameRequired).build()(
      value?.trim(),
    );
  }

  /*
   * Validates the 'zipcode' field in the form.
   *
   * Validation Rules:
   * - The field is required and displays a custom error message if left empty.
   *
   * Returns:
   * - A validation error message string if the input is invalid.
   * - Null if the input passes all validation checks.
   */
  String? zipcodeValidator(String? value) {
    return ValidationBuilder(requiredMessage: ZipcodeFormValidationMessage.zipcodeRequired).required(ZipcodeFormValidationMessage.zipcodeRequired).build()(
      value?.trim(),
    );
  }

  /*
   * Handles the state change in the organization form.
   *
   * This function updates various nested objects (State, District, City, AreaName, Zipcode) in the 'organization' object 
   * when the state value changes. It then triggers form validation and updates the state.
   *
   * Steps:
   * - Extracts and updates the relevant nested objects (State, District, City, AreaName, Zipcode).
   * - Resets the 'id' and 'name' fields of each nested object to empty strings.
   * - Calls `validate()` on the form field to ensure it reflects the updated state.
   * - Calls `update()` to trigger any UI or state updates.
   *
   * Parameters:
   * - `value`: The new state value selected by the user.
   * - `formFieldKey`: A key to access the form field state for validation.
   */
  void onStateChange(state_mode.State value, GlobalKey<FormFieldState> formFieldKey) {
    Zipcode zipcode = organization.zipcode;
    AreaName areaName = zipcode.areaName;
    City city = areaName.city;
    District district = city.district;

    district = district.copyWith(state: value, id: "", name: "");
    city = city.copyWith(district: district, id: "", name: "");
    areaName = areaName.copyWith(city: city, id: "", name: "");
    zipcode = zipcode.copyWith(areaName: areaName, id: "", zipcode: "");
    organization = organization.copyWith(state: value);
    organization = organization.copyWith(district: district);
    organization = organization.copyWith(city: city);
    organization = organization.copyWith(areaName: areaName);
    organization = organization.copyWith(zipcode: zipcode);

    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles the district change in the organization form.
   *
   * This function updates various nested objects (District, City, AreaName, Zipcode) in the 'organization' object 
   * when the district value changes. It resets the 'id' and 'name' fields of each nested object to empty strings 
   * and then triggers form validation and updates the state.
   *
   * Steps:
   * - Extracts and updates the relevant nested objects (District, City, AreaName, Zipcode).
   * - Resets the 'id' and 'name' fields of each nested object to empty strings.
   * - Calls `validate()` on the form field to ensure the form reflects the updated district.
   * - Calls `update()` to trigger any UI or state updates.
   *
   * Parameters:
   * - `value`: The new district value selected by the user.
   * - `formFieldKey`: A key to access the form field state for validation.
   */
  void onDistrictChange(District value, GlobalKey<FormFieldState> formFieldKey) {
    Zipcode zipcode = organization.zipcode;
    AreaName areaName = zipcode.areaName;
    City city = areaName.city;

    city = city.copyWith(district: value, id: "", name: "");
    areaName = areaName.copyWith(city: city, id: "", name: "");
    zipcode = zipcode.copyWith(areaName: areaName, id: "", zipcode: "");
    organization = organization.copyWith(district: value);
    organization = organization.copyWith(city: city);
    organization = organization.copyWith(areaName: areaName);
    organization = organization.copyWith(zipcode: zipcode);

    formFieldKey.currentState?.validate();

    update();
  }

  /*
   * Handles the city change in the organization form.
   *
   * This function updates the relevant nested objects (City, AreaName, Zipcode) in the 'organization' object 
   * when the city value changes. It resets the 'id' and 'name' fields of the nested objects to empty strings 
   * and triggers form validation and state update.
   *
   * Steps:
   * - Extracts and updates the relevant nested objects (City, AreaName, Zipcode).
   * - Resets the 'id' and 'name' fields of the nested objects to empty strings.
   * - Calls `validate()` on the form field to ensure the form reflects the updated city.
   * - Calls `update()` to trigger any UI or state updates.
   *
   * Parameters:
   * - `value`: The new city value selected by the user.
   * - `formFieldKey`: A key to access the form field state for validation.
   */
  void onCityChange(City value, GlobalKey<FormFieldState> formFieldKey) {
    Zipcode zipcode = organization.zipcode;
    AreaName areaName = zipcode.areaName;

    areaName = areaName.copyWith(city: value, id: "", name: "");
    zipcode = zipcode.copyWith(areaName: areaName, id: "", zipcode: "");
    organization = organization.copyWith(city: value);
    organization = organization.copyWith(areaName: areaName);
    organization = organization.copyWith(zipcode: zipcode);

    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles the area name change in the organization form.
   *
   * This function updates the relevant nested objects (AreaName, Zipcode) in the 'organization' object 
   * when the area name value changes. It resets the 'id' and 'zipcode' fields to empty strings 
   * and triggers form validation and state update.
   *
   * Steps:
   * - Extracts and updates the relevant nested objects (AreaName, Zipcode).
   * - Resets the 'id' and 'zipcode' fields of the nested objects to empty strings.
   * - Calls `validate()` on the form field to ensure the form reflects the updated area name.
   * - Calls `update()` to trigger any UI or state updates.
   *
   * Parameters:
   * - `value`: The new area name value selected by the user.
   * - `formFieldKey`: A key to access the form field state for validation.
   */
  void onAreaNameChange(AreaName value, GlobalKey<FormFieldState> formFieldKey) {
    Zipcode zipcode = organization.zipcode;

    zipcode = zipcode.copyWith(areaName: value, id: "", zipcode: "");
    organization = organization.copyWith(areaName: value);
    organization = organization.copyWith(zipcode: zipcode);

    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles the zipcode change in the organization form.
   *
   * This function updates the 'zipcode' field in the 'organization' object 
   * when the zipcode value changes. It triggers form validation and state update 
   * to reflect the changes in the form and the UI.
   *
   * Steps:
   * - Updates the 'zipcode' field in the 'organization' object with the new value.
   * - Calls `validate()` on the form field to ensure the form reflects the updated zipcode.
   * - Calls `update()` to trigger any UI or state updates.
   *
   * Parameters:
   * - `value`: The new zipcode value selected by the user.
   * - `formFieldKey`: A key to access the form field state for validation.
   */
  void onZipcodeChange(Zipcode value, GlobalKey<FormFieldState> formFieldKey) {
    organization = organization.copyWith(zipcode: value);

    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles the name change in the organization form.
   *
   * This function updates the 'name' field in the 'organization' object 
   * whenever the name value changes. It trims any leading or trailing whitespace 
   * from the input value before updating the state.
   *
   * After updating the name, the function calls `update()` to ensure the UI or 
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new name entered by the user, which will be trimmed of any extra spaces.
   */
  void onNameChange(String value) {
    organization = organization.copyWith(name: value.trim());
    update();
  }

  /*
   * Handles the submission of the name field in the organization form.
   *
   * This function is triggered when the user submits the name field. It updates 
   * the 'name' field in the 'organization' object with the trimmed value 
   * entered by the user. After updating the name, it triggers the validation 
   * of the form field associated with the 'name' field using the provided 
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The name entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onNameSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    organization = organization.copyWith(name: value.trim());
    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the change in the short name field of the organization form.
   *
   * This function is triggered whenever the user modifies the short name field. It 
   * updates the 'shortName' field in the 'organization' object with the trimmed 
   * value entered by the user. After updating the short name, it calls the `update` 
   * method to apply any necessary changes or refresh the UI.
   *
   * Parameters:
   * - `value`: The short name entered by the user, which will be trimmed of any extra spaces.
   */
  void onShortNameChange(String value) {
    organization = organization.copyWith(shortName: value.trim());
    update();
  }

  /*
   * Handles the submission of the short name field in the organization form.
   *
   * This function is triggered when the user submits the short name field (e.g., by pressing 
   * the 'Enter' key or moving to the next field). It updates the 'shortName' field in the 
   * 'organization' object with the trimmed value entered by the user. After updating the 
   * short name, it triggers validation for the form field using the `formFieldKey`.
   *
   * Parameters:
   * - `value`: The short name entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: The key associated with the form field, used to trigger validation.
   */
  void onShortNameSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    organization = organization.copyWith(shortName: value.trim());
    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the change in the email field of the organization form.
   *
   * This function is called whenever the user modifies the email field. It updates 
   * the 'email' property of the 'organization' object with the trimmed value entered 
   * by the user. The `update()` function is called to trigger any necessary UI updates 
   * or state changes after the email value has been updated.
   *
   * Parameters:
   * - `value`: The email entered by the user, which is trimmed of any extra spaces.
   */
  void onEmailChange(String value) {
    organization = organization.copyWith(email: value.trim());
    update();
  }

  /*
   * Handles the submission of the email field in the organization form.
   *
   * This function is triggered when the user submits the email field (e.g., pressing 
   * "Enter" or moving to the next field). It updates the 'email' property of the 
   * 'organization' object with the trimmed value entered by the user. The validation 
   * of the form field is then triggered by calling `validate()` on the form field's 
   * current state to ensure that the submitted value adheres to any validation rules.
   *
   * Parameters:
   * - `value`: The email entered by the user, which is trimmed of any extra spaces.
   * - `formFieldKey`: A reference to the form field's state, used to trigger validation.
   */
  void onEmailSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    organization = organization.copyWith(email: value.trim());
    formFieldKey.currentState?.validate();
  }

  /*
   * Updates the phone number in the organization object when the user modifies the value.
   *
   * This function is triggered whenever the phone number is changed. It updates the 
   * 'phoneNumber' property of the 'organization' object with the trimmed value entered by 
   * the user. The `update()` function is called to notify the framework that the organization 
   * state has been updated, ensuring any dependent UI elements are refreshed with the new 
   * phone number.
   *
   * Parameters:
   * - `value`: The phone number entered by the user, which is trimmed of any extra spaces.
   */
  void onPhoneNumberChange(String value) {
    organization = organization.copyWith(phoneNumber: value.trim());
    update();
  }

  /*
   * Handles the submission of the phone number form field.
   *
   * This function is called when the user submits the phone number input field. It updates 
   * the 'phoneNumber' property of the 'organization' object with the trimmed value entered by 
   * the user. After updating the organization state, it triggers the validation of the form field 
   * using the provided formFieldKey to ensure the entered phone number is valid.
   *
   * Parameters:
   * - `value`: The phone number entered by the user, which is trimmed of any extra spaces.
   * - `formFieldKey`: The form field key used to validate the phone number input.
   */
  void onPhoneNumberSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    organization = organization.copyWith(phoneNumber: value.trim());
    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the change of the government registration number form field.
   *
   * This function is called when the user changes the value of the government registration number 
   * input field. It updates the 'governmentRegistrationNumber' property of the 'organization' 
   * object with the trimmed value entered by the user. After updating the organization state, it 
   * calls the `update()` method to ensure the UI reflects the changes made to the organization's 
   * government registration number.
   *
   * Parameters:
   * - `value`: The government registration number entered by the user, which is trimmed of 
   *   any extra spaces.
   */
  void onGovernmentRegistrationNumberChange(String value) {
    organization = organization.copyWith(governmentRegistrationNumber: value.trim());
    update();
  }

  /*
 * Handles the submission of the government registration number form field.
 *
 * This function is called when the user submits the government registration number input 
 * field. It updates the 'governmentRegistrationNumber' property of the 'organization' 
 * object with the trimmed value entered by the user. After updating the organization state, 
 * it triggers the validation of the form field using the provided `formFieldKey`.
 * This ensures that the form field is validated after the value has been submitted.
 *
 * Parameters:
 * - `value`: The government registration number entered by the user, which is trimmed of 
 *   any extra spaces.
 * - `formFieldKey`: A reference to the form field's state, used to trigger validation.
 */
  void onGovernmentRegistrationNumberSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    organization = organization.copyWith(governmentRegistrationNumber: value.trim());
    formFieldKey.currentState?.validate();
  }

  /*
   * Updates the address of the organization when the input changes.
   *
   * This function is called whenever the user modifies the address input field. It trims 
   * the entered value to remove any leading or trailing spaces and updates the 'address' 
   * property of the 'organization' object. After updating the address, it calls the 
   * `update()` method to ensure that the UI is refreshed with the new value.
   * 
   * Parameters:
   * - `value`: The address entered by the user, which is trimmed to remove extra spaces.
   */
  void onAddressChange(String value) {
    organization = organization.copyWith(address: value.trim());
    update();
  }

  /*
   * Handles the submission of the address field and updates the organization object.
   *
   * This function is triggered when the user submits the address input. It trims any 
   * leading or trailing spaces from the address value and updates the 'address' property 
   * of the 'organization' object. After updating the address, it triggers the validation 
   * for the form field to ensure the input is correct before moving forward.
   * 
   * Parameters:
   * - `value`: The address entered by the user, which is trimmed to remove any extra spaces.
   * - `formFieldKey`: A reference to the form field state used to trigger validation on the form field.
   */
  void onAddressSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    organization = organization.copyWith(address: value.trim());
    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the form submission and validates the form fields.
   *
   * This function first validates the form using the provided formKey. If the form is valid, 
   * it checks if the organization already has an ID. If the organization ID is not empty, 
   * it proceeds to update the organization by calling the `putOrganization` method.
   * If the organization ID is empty, no action is performed.
   *
   * Parameters:
   * - `formKey`: The global key for the form, used to trigger form validation.
   */
  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      (organization.id.isNotEmpty) ? await putOrganization() : null;
    }
  }

  /*
   * Sends a PUT request to update the organization details.
   *
   * This function first retrieves the authentication token using `Utils.getAuthToken()`. 
   * It then sets `isLoader` to true to indicate that the operation is in progress and updates the UI. 
   * A PUT request is made using the `PutHttpService` with the necessary headers and body data (the organization's data).
   * The `HttpService.putRequest` method sends the request and receives the response.
   *
   * If the request is successful (`AppHttpRequestStatus.isSuccessfullyServiced`), 
   * a success message is shown via a Snackbar, and the user is navigated to the schools page.
   * If the request fails, an error message is displayed using a Snackbar.
   *
   * Parameters: 
   * None
   */
  Future<void> putOrganization() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/organizations/${organization.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: organization.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(endPoint: 'assets/mock_data/organizations/organizations_200.json', statusCode: 200),
    );

    HttpResponseService response = await HttpService.putRequest(putHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      Snackbar.getSnackbar(title: snackbarTitle, message: response.message, appSnackbarStatus: AppSnackbarStatus.success);
      Get.offAllNamed(RoutePaths.schoolForm);
    } else {
      isLoader = false;
      Snackbar.getSnackbar(title: snackbarTitle, message: response.message, appSnackbarStatus: AppSnackbarStatus.error);
    }

    update();
  }
}
