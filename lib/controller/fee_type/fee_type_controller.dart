import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/model/fee_type/fee_type.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/http_service/get_http_service.dart';
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/post_http_service.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';
import 'package:me_super_admin/utils/validation_message/fee_type_validation_message.dart';

class FeeTypeController extends GetxController {
  /*
   * This controller manages the state and operations related to fee types.
   * It includes functionalities for reading, adding, deleting, and updating fee type forms,
   * as well as handling form validation. The controller also provides validation methods 
   * for various fields and integrates with HTTP services to perform CRUD operations on fee type data.
   */

  String snackbarTitle = "Fee Type Alert";
  bool isLoader = false;
  FeeType feeType = FeeType.defaultValues();
  List<FeeType> feeTypes = [];

  /*
   * Resets the fee type form to its default state.
   */
  void resetFeeTypeForm() {
    feeType = FeeType.defaultValues();
    update();
  }

  /*
   * Sets the fee type form with the provided FeeType object.
   * If the fee type has an ID, it navigates to the fee type form screen.
   */
  void setFeeTypeForm(FeeType feeTypeObj) {
    feeType = feeTypeObj;
    update();

    if (feeType.id.isNotEmpty) {
      Get.toNamed(RoutePaths.feeTypeForm);
    }
  }

  /*
   * Validates the 'fee type' field of the fee type form.
   *
   * Applies the following rules:
   * - Field is required (shows custom required message).
   * - Must be at least 2 characters long.
   * - Must not exceed 100 characters.
   *
   * Returns:
   * - A validation error message string if invalid.
   * - Null if the input is valid.
   */
  String? feeTypeValidator(String? value) {
    return ValidationBuilder(requiredMessage: FeeTypeValidationMessage.feeTypeRequired)
        .required(FeeTypeValidationMessage.feeTypeRequired)
        .minLength(2, FeeTypeValidationMessage.feeTypeMinLength)
        .maxLength(100, FeeTypeValidationMessage.feeTypeMaxLength)
        .build()(value?.trim());
  }

  /*
   * Handles the state change in the fee type form.
   *
   * This function updates the 'fee type' field in the active fee type object
   * whenever the fee type value changes.
   *
   * Parameters:
   * - The new fee type entered by the user, which will be trimmed of any extra spaces.
   */
  void onFeeTypeChange(String value) {
    feeType = feeType.copyWith(feeType: value.trim());
    update();
  }

  /*
   * Handles the submission of the fee type field in the fee type form.
   *
   * This function is triggered when the user submits the fee type field. It updates
   * the 'feeType' field in the active fee type object with the trimmed value
   * entered by the user. After updating the fee type, it triggers the validation
   * of the form field associated with the 'feeType' field using the provided
   * `formFieldKey`.
   *
   * Parameters:
   * - `value`: The fee type entered by the user, which will be trimmed of any extra spaces.
   * - `formFieldKey`: A GlobalKey used to access the form field's state for validation.
   */
  void onFeeTypeSubmitted(
    String value,
    GlobalKey<FormFieldState> formFieldKey,
    GlobalKey<FormState> formKey,
  ) {
    feeType = feeType.copyWith(feeType: value.trim());
    formFieldKey.currentState?.validate();
    onSubmitForm(formKey);
  }

  /*
   * Handles the submission of the fee type form.
   *
   * This function validates the form using the provided `formKey`. If the form is valid,
   * it either creates a new fee type (if `feeType.id` is empty) or updates an existing fee type
   * (if `feeType.id` is not empty).
   *
   * Parameters:
   * - `formKey`: A GlobalKey used to access the form's state for validation.
   */
  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      (feeType.id.isEmpty) ? await postFeeType() : await putFeeType();
    }
  }

  /*
   * Fetches the list of fee types from the server.
   *
   * This function retrieves the fee types using a GET request to the 'super-admin/fee-types' endpoint.
   * It updates the `feeTypes` list with the fetched data and manages the loading state.
   */
  Future<void> getFeeTypes() async {
    String authToken = await Utils.getAuthToken();
    feeTypes = [];
    isLoader = true;
    update();

    GetHttpService getHttpService = GetHttpService(
      endPoint: 'super-admin/fee-types',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/fee_types/fee_types_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.getRequest(getHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      for (var feeTypeJson in response.data) {
        final FeeType feeTypeObj = FeeType.fromJson(feeTypeJson);
        feeTypes.add(feeTypeObj);
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
   * Posts a new fee type to the server.
   *
   * This function sends a POST request to the 'super-admin/fee-types' endpoint with the fee type data.
   * It manages the loading state and displays success or error messages based on the response.
   */
  Future<void> postFeeType() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PostHttpService postHttpService = PostHttpService(
      endPoint: 'super-admin/fee-types',
      headers: {"Authorization": 'Bearer $authToken'},
      body: feeType.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/fee_types/fee_types_200.json',
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
      Get.offAllNamed(RoutePaths.feeTypes);
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
   * Updates an existing fee type on the server.
   *
   * This function sends a PUT request to the 'super-admin/fee-types/{id}' endpoint with the fee type data.
   * It manages the loading state and displays success or error messages based on the response.
   */
  Future<void> putFeeType() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/fee-types/${feeType.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: feeType.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/fee_types/fee_types_200.json',
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
      Get.offAllNamed(RoutePaths.feeTypes);
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
   * Deletes a fee type from the server.
   *
   * This function sends a DELETE request to the 'super-admin/fee-types/{id}' endpoint.
   * It manages the loading state and displays success or error messages based on the response.
   */
  Future<void> deleteFeeType(String id) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    DeleteHttpService deleteHttpService = DeleteHttpService(
      endPoint: 'super-admin/fee-types/$id',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/fee_types/fee_types_200.json',
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
      getFeeTypes();
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
