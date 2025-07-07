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
import 'package:me_super_admin/model/school_address/school_address.dart';
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';
import 'package:me_super_admin/utils/validation_message/zipcode_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/area_name_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/city_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/state_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/school_address_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/district_form_validation_message.dart';

class SchoolAddressController extends GetxController {
  String snackbarTitle = "School Address Alert";
  List<SchoolAddress> schoolAddresses = [];
  List<bool> schoolAddressFormValidated = [];
  int selectedIndex = 0;
  bool isLoader = false;

  /*
   * Resets the school address form to its default values.
   *
   * This function sets the `schoolAddress` object back to its default values using the `SchoolAddress.defaultValues()` method.
   * This is useful for clearing the form or resetting it to its initial state when the user needs to start over.
   * After resetting the schoolAddress, the `update()` method is called to refresh the UI and reflect the changes.
   *
   * Parameters:
   * None
   */
  void resetSchoolAddressForm() {
    schoolAddresses = [SchoolAddress.defaultValues()];
    schoolAddressFormValidated = [false];
    update();
  }

  void setSchoolAddressesForm(List<SchoolAddress> schoolAddressList) {
    schoolAddresses = schoolAddressList;
    schoolAddressFormValidated = List.generate(schoolAddresses.length, (index) => false);
    update();
  }

  /*
   * Adds a new school address form to the list.
   */
  void addSchoolAddressForm() {
    schoolAddresses.add(SchoolAddress.defaultValues());
    schoolAddressFormValidated.add(false);
    update();
  }

  /*
   * Deletes a school address form at the specified index.
   */
  void deleteSchoolAddressForm(int index) {
    schoolAddresses.removeAt(index);
    schoolAddressFormValidated.removeAt(index);
    update();
  }

  /*
   * Updates the validation status of a specific school address form.
   */
  void changeSchoolAddressFormValidatedStatus(int index, bool status) {
    schoolAddressFormValidated[index] = status;
    update();
  }

  /*
   * Sets the school address form data for the active form index.
   */
  void setSchoolAddressForm(SchoolAddress schoolAddressObj) {
    schoolAddresses[selectedIndex] = schoolAddressObj;
    update();
  }

  /*
   * Validates the 'address' field of the school address form.
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
    return ValidationBuilder(requiredMessage: SchoolAddressValidationMessage.schoolAddressRequired)
        .required(SchoolAddressValidationMessage.schoolAddressRequired)
        .minLength(10, SchoolAddressValidationMessage.schoolAddressMinLength)
        .maxLength(500, SchoolAddressValidationMessage.schoolAddressMaxLength)
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
   * Handles the state change in the school address form.
   *
   * This function updates the 'state' field in the active school address object
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
  void onStateChange(state_mode.State value, int index, GlobalKey<FormFieldState> formFieldKey) {
    SchoolAddress schoolAddress = schoolAddresses[index];

    Zipcode zipcode = schoolAddress.zipcode;
    AreaName areaName = zipcode.areaName;
    City city = areaName.city;
    District district = city.district;

    district = district.copyWith(state: value, id: "", name: "");
    city = city.copyWith(district: district, id: "", name: "");
    areaName = areaName.copyWith(city: city, id: "", name: "");
    zipcode = zipcode.copyWith(areaName: areaName, id: "", zipcode: "");

    schoolAddress = schoolAddress.copyWith(state: value);
    schoolAddress = schoolAddress.copyWith(district: district);
    schoolAddress = schoolAddress.copyWith(city: city);
    schoolAddress = schoolAddress.copyWith(areaName: areaName);
    schoolAddress = schoolAddress.copyWith(zipcode: zipcode);

    schoolAddresses[index] = schoolAddress;

    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles the district change in the school address form.
   *
   * This function updates various nested objects (District, City, AreaName, Zipcode) in the 'schoolAddress' object
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
  void onDistrictChange(District value, int index, GlobalKey<FormFieldState> formFieldKey) {
    SchoolAddress schoolAddress = schoolAddresses[index];

    Zipcode zipcode = schoolAddress.zipcode;
    AreaName areaName = zipcode.areaName;
    City city = areaName.city;

    city = city.copyWith(district: value, id: "", name: "");
    areaName = areaName.copyWith(city: city, id: "", name: "");
    zipcode = zipcode.copyWith(areaName: areaName, id: "", zipcode: "");
    schoolAddress = schoolAddress.copyWith(district: value);
    schoolAddress = schoolAddress.copyWith(city: city);
    schoolAddress = schoolAddress.copyWith(areaName: areaName);
    schoolAddress = schoolAddress.copyWith(zipcode: zipcode);

    schoolAddresses[index] = schoolAddress;

    formFieldKey.currentState?.validate();

    update();
  }

  /*
   * Handles the city change in the school address form.
   *
   * This function updates the relevant nested objects (City, AreaName, Zipcode) in the 'schoolAddress' object
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
  void onCityChange(City value, int index, GlobalKey<FormFieldState> formFieldKey) {
    SchoolAddress schoolAddress = schoolAddresses[index];

    Zipcode zipcode = schoolAddress.zipcode;
    AreaName areaName = zipcode.areaName;

    areaName = areaName.copyWith(city: value, id: "", name: "");
    zipcode = zipcode.copyWith(areaName: areaName, id: "", zipcode: "");
    schoolAddress = schoolAddress.copyWith(city: value);
    schoolAddress = schoolAddress.copyWith(areaName: areaName);
    schoolAddress = schoolAddress.copyWith(zipcode: zipcode);

    schoolAddresses[index] = schoolAddress;

    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles the area name change in the school address form.
   *
   * This function updates the relevant nested objects (AreaName, Zipcode) in the 'schoolAddress' object
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
  void onAreaNameChange(AreaName value, int index, GlobalKey<FormFieldState> formFieldKey) {
    SchoolAddress schoolAddress = schoolAddresses[index];

    Zipcode zipcode = schoolAddress.zipcode;

    zipcode = zipcode.copyWith(areaName: value, id: "", zipcode: "");
    schoolAddress = schoolAddress.copyWith(areaName: value);
    schoolAddress = schoolAddress.copyWith(zipcode: zipcode);

    schoolAddresses[index] = schoolAddress;

    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles the zipcode change in the school address form.
   *
   * This function updates the 'zipcode' field in the 'schoolAddress' object
   * when the zipcode value changes. It triggers form validation and state update
   * to reflect the changes in the form and the UI.
   *
   * Steps:
   * - Updates the 'zipcode' field in the 'schoolAddress' object with the new value.
   * - Calls `validate()` on the form field to ensure the form reflects the updated zipcode.
   * - Calls `update()` to trigger any UI or state updates.
   *
   * Parameters:
   * - `value`: The new zipcode value selected by the user.
   * - `formFieldKey`: A key to access the form field state for validation.
   */
  void onZipcodeChange(Zipcode value, int index, GlobalKey<FormFieldState> formFieldKey) {
    SchoolAddress schoolAddress = schoolAddresses[index];

    schoolAddress = schoolAddress.copyWith(zipcode: value);

    schoolAddresses[index] = schoolAddress;

    formFieldKey.currentState?.validate();
    update();
  }

  /*
   * Handles the address change in the school address form.
   *
   * This function updates the 'address' field in the active school address object
   * whenever the address value changes. It trims any leading or trailing whitespace
   * from the input value before updating the state.
   *
   * After updating the address, the function calls `update()` to ensure the UI or
   * state reflects the new value.
   *
   * Parameters:
   * - `value`: The new address entered by the user, which will be trimmed of any extra spaces.
   */
  void onAddressChange(String value, int index) {
    SchoolAddress schoolAddress = schoolAddresses[index];

    schoolAddress = schoolAddress.copyWith(address: value.trim());
    schoolAddresses[index] = schoolAddress;

    update();
  }

  /*
   * Handles the submission of the address field in the school address form.
   *
   * This function is triggered when the user submits the address field. It updates
   * the 'address' field in the active school address object with the trimmed value
   * entered by the user. After updating the address, it triggers the validation
   * of the form field associated with the 'address' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The address entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onAddressSubmitted(String value, int index, GlobalKey<FormFieldState> formFieldKey) {
    SchoolAddress schoolAddress = schoolAddresses[index];

    schoolAddress = schoolAddress.copyWith(address: value.trim());
    schoolAddresses[index] = schoolAddress;

    formFieldKey.currentState?.validate();
  }

  /*
   * Handles the form submission and validates the form fields.
   *
   * This function first validates the form using the provided formKey. If the form is valid,
   * it checks if the schoolAddress already has an ID. If the schoolAddress ID is not empty,
   * it proceeds to update the schoolAddress by calling the `putSchoolAddress` method.
   * If the schoolAddress ID is empty, no action is performed.
   *
   * Parameters:
   * - `formKey`: The global key for the form, used to trigger form validation.
   */
  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      // (schoolAddress.id.isNotEmpty) ? await putSchoolAddress() : null;
    }
  }

  /*
   * Sends a PUT request to update the school address details.
   *
   * This function first retrieves the authentication token using `Utils.getAuthToken()`.
   * It then sets `isLoader` to true to indicate that the operation is in progress and updates the UI.
   * A PUT request is made using the `PutHttpService` with the necessary headers and body data (the school address data).
   * The `HttpService.putRequest` method sends the request and receives the response.
   *
   * If the request is successful (`AppHttpRequestStatus.isSuccessfullyServiced`), 
   * a success message is shown via a Snackbar, and the user is navigated to the schools page.
   * If the request fails, an error message is displayed using a Snackbar.
   *
   * Parameters: 
   * None
   */
  Future<void> putSchoolAddress(int index) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/schools/${schoolAddresses[index].id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: schoolAddresses[index].toJson(),
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

  /*
   * Deletes a school address from the server.
   *
   * This function sends a DELETE request to remove the specified school address
   * from the server. It uses the `DeleteHttpService` to construct the request with
   * the necessary endpoint and headers. The function also handles the response to
   * display appropriate success or error messages using a snackbar.
   *
   * Parameters:
   * - `id`: The unique identifier of the school address to be deleted.
   *
   * Returns:
   * - A `Future` that completes when the request is processed.
   */
  Future<void> deleteSchoolAddress(int index) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    DeleteHttpService deleteHttpService = DeleteHttpService(
      endPoint: 'super-admin/schools/${schoolAddresses[index].id}',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(endPoint: 'assets/mock_data/schools/schools_200.json', statusCode: 200),
    );

    HttpResponseService response = await HttpService.deleteRequest(deleteHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      Snackbar.getSnackbar(title: snackbarTitle, message: response.message, appSnackbarStatus: AppSnackbarStatus.success);

      // Remove the school address from the schoolAddresses list by index.
      schoolAddresses.removeAt(index);
    } else {
      isLoader = false;
      Snackbar.getSnackbar(title: snackbarTitle, message: response.message, appSnackbarStatus: AppSnackbarStatus.error);
    }

    update();
  }
}
