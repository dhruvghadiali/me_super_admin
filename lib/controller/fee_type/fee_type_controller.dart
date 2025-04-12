import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/model/fee_type/fee_type.dart';
import 'package:me_super_admin/utils/validation_message.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/http_service/get_http_service.dart';
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/post_http_service.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';

class FeeTypeController extends GetxController {
  String snackbarTitle = "Fee Type Alert";
  bool isLoader = false;
  FeeType feeType = FeeType.defaultValues();
  List<FeeType> feeTypes = [];

  void resetFeeTypeForm() {
    feeType = FeeType.defaultValues();
    update();
  }

  void setFeeTypeForm(FeeType feeTypeObj) {
    feeType = feeTypeObj;
    update();

    if (feeType.id.isNotEmpty) {
      Get.offAllNamed(RoutePaths.feeTypeForm);
    }
  }

  String? feeTypeValidator(String? value) {
    return ValidationBuilder(requiredMessage: ValidationMessage.feeTypeRequired)
        .required(ValidationMessage.feeTypeRequired)
        .minLength(2, ValidationMessage.feeTypeMinLength)
        .maxLength(100, ValidationMessage.feeTypeMaxLength)
        .build()(value?.trim());
  }

  void onFeeTypeChange(String value) {
    feeType = feeType.copyWith(feeType: value.trim());
    update();
  }

  void onFeeTypeSubmitted(
    String value,
    GlobalKey<FormFieldState> formFieldKey,
    GlobalKey<FormState> formKey,
  ) {
    feeType = feeType.copyWith(feeType: value.trim());
    formFieldKey.currentState?.validate();
    onSubmitForm(formKey);
  }

  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      (feeType.id.isEmpty) ? await postFeeType() : await putFeeType();
    }
  }

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

    if (response.appHttpRequestStatus ==
        AppHttpRequestStatus.isSuccessfullyServiced) {
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

    HttpResponseService response = await HttpService.postRequest(
      postHttpService,
    );

    if (response.appHttpRequestStatus ==
        AppHttpRequestStatus.isSuccessfullyServiced) {
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

    if (response.appHttpRequestStatus ==
        AppHttpRequestStatus.isSuccessfullyServiced) {
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

    HttpResponseService response = await HttpService.deleteRequest(
      deleteHttpService,
    );

    if (response.appHttpRequestStatus ==
        AppHttpRequestStatus.isSuccessfullyServiced) {
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
