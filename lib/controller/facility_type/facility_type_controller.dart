import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/model/facility_type/facility_type.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/http_service/get_http_service.dart';
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/post_http_service.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';
import 'package:me_super_admin/utils/validation_message/facility_type_validation_message.dart';

class FacilityTypeController extends GetxController {
  /*
   * This controller manages the state and operations related to facility types.
   * It includes functionalities for reading, adding, deleting, and updating facility type forms,
   * as well as handling form validation. The controller also provides validation methods 
   * for various fields and integrates with HTTP services to perform CRUD operations on facility type data.
   */

  String snackbarTitle = "Facility Type Alert";
  bool isLoader = false;
  FacilityType facilityType = FacilityType.defaultValues();
  List<FacilityType> facilityTypes = [];

  /*
   * Resets the facility type form to its default state.
   */
  void resetFacilityTypeForm() {
    facilityType = FacilityType.defaultValues();
    update();
  }

  /*
   * Sets the facility type form with the provided FacilityType object.
   * If the facility type has an ID, it navigates to the facility type form screen.
   */
  void setFacilityTypeForm(FacilityType facilityTypeObj) {
    facilityType = facilityTypeObj;
    update();

    if (facilityType.id.isNotEmpty) {
      Get.toNamed(RoutePaths.facilityTypeForm);
    }
  }

  /*
   * Validates the 'facility type' field of the facility type form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   * - Must be at least 10 characters long.
   * - Must not exceed 100 characters.
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? facilityTypeValidator(String? value) {
    return ValidationBuilder(requiredMessage: FacilityTypeValidationMessage.facilityTypeRequired)
        .required(FacilityTypeValidationMessage.facilityTypeRequired)
        .minLength(10, FacilityTypeValidationMessage.facilityTypeMinLength)
        .maxLength(100, FacilityTypeValidationMessage.facilityTypeMaxLength)
        .build()(value?.trim());
  }

  /*
   * Handles the state change in the facility type form.
   *
   * This function updates the 'facility type' field in the active facility type object
   * whenever the facility type value changes.
   *
   * Parameters:
   * - The new facility type entered by the user, which will be trimmed of any extra spaces.
   */
  void onFacilityTypeChange(String value) {
    facilityType = facilityType.copyWith(facilityType: value.trim());
    update();
  }

  /*
   * Handles the submission of the facility type field in the facility type form.
   *
   * This function is triggered when the user submits the facility type field. It updates
   * the 'facilityType' field in the active facility type object with the trimmed value
   * entered by the user. After updating the facility type, it triggers the validation
   * of the form field associated with the 'facilityType' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The facility type entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onFacilityTypeSubmitted(
    String value,
    GlobalKey<FormFieldState> formFieldKey,
    GlobalKey<FormState> formKey,
  ) {
    facilityType = facilityType.copyWith(facilityType: value.trim());
    formFieldKey.currentState?.validate();
    onSubmitForm(formKey);
  }

  /*
   * Handles the submission of the facility type form.
   *
   * This function validates the form using the provided `formKey`. If the form is valid,
   * it either creates a new facility type (if `facilityType.id` is empty) or updates an existing facility type
   * (if `facilityType.id` is not empty).
   *
   * Parameters:
   * - `formKey`: A GlobalKey used to access the form's state for validation.
   */
  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      (facilityType.id.isEmpty) ? await postFacilityType() : await putFacilityType();
    }
  }

  /*
   * Fetches the list of facility types from the server.
   *
   * This function retrieves the facility types using a GET request to the 'super-admin/facility-types' endpoint.
   * It updates the `facilityTypes` list with the fetched data and manages the loading state.
   */
  Future<void> getFacilityTypes() async {
    String authToken = await Utils.getAuthToken();
    facilityTypes = [];
    isLoader = true;
    update();

    GetHttpService getHttpService = GetHttpService(
      endPoint: 'super-admin/facility-types',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/facility_types/facility_types_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.getRequest(getHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      for (var facilityTypeJson in response.data) {
        final FacilityType facilityTypeObj = FacilityType.fromJson(facilityTypeJson);
        facilityTypes.add(facilityTypeObj);
      }
    } else {
      isLoader = false;
      Snackbar.getSnackbar(
        title: snackbarTitle,
        message: response.message,
        appSnackbarStatus: AppSnackbarStatus.error,
      );
    }

    update();
  }

  /*
   * Posts a new facility type to the server.
   *
   * This function sends a POST request to the 'super-admin/facility-types' endpoint with the facility type data.
   * It manages the loading state and displays success or error messages based on the response.
   */
  Future<void> postFacilityType() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PostHttpService postHttpService = PostHttpService(
      endPoint: 'super-admin/facility-types',
      headers: {"Authorization": 'Bearer $authToken'},
      body: facilityType.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/facility_types/facility_types_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.postRequest(postHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      Snackbar.getSnackbar(
        title: snackbarTitle,
        message: response.message,
        appSnackbarStatus: AppSnackbarStatus.success,
      );
      Get.offAllNamed(RoutePaths.facilityTypes);
    } else {
      isLoader = false;
      Snackbar.getSnackbar(
        title: snackbarTitle,
        message: response.message,
        appSnackbarStatus: AppSnackbarStatus.error,
      );
    }

    update();
  }

  /*
   * Updates an existing facility type on the server.
   *
   * This function sends a PUT request to the 'super-admin/facility-types/{id}' endpoint with the facility type data.
   * It manages the loading state and displays success or error messages based on the response.
   */
  Future<void> putFacilityType() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/facility-types/${facilityType.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: facilityType.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/facility_types/facility_types_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.putRequest(putHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      Snackbar.getSnackbar(
        title: snackbarTitle,
        message: response.message,
        appSnackbarStatus: AppSnackbarStatus.success,
      );
      Get.offAllNamed(RoutePaths.facilityTypes);
    } else {
      isLoader = false;
      Snackbar.getSnackbar(
        title: snackbarTitle,
        message: response.message,
        appSnackbarStatus: AppSnackbarStatus.error,
      );
    }

    update();
  }

  /*
   * Deletes a facility type from the server.
   *
   * This function sends a DELETE request to the 'super-admin/facility-types/{id}' endpoint.
   * It manages the loading state and displays success or error messages based on the response.
   */
  Future<void> deleteFacilityType(String id) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    DeleteHttpService deleteHttpService = DeleteHttpService(
      endPoint: 'super-admin/facility-types/$id',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/facility_types/facility_types_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.deleteRequest(deleteHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      Snackbar.getSnackbar(
        title: snackbarTitle,
        message: response.message,
        appSnackbarStatus: AppSnackbarStatus.success,
      );
      getFacilityTypes();
    } else {
      isLoader = false;
      Snackbar.getSnackbar(
        title: snackbarTitle,
        message: response.message,
        appSnackbarStatus: AppSnackbarStatus.error,
      );
    }

    update();
  }
}
