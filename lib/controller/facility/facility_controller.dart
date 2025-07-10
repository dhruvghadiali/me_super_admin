import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/model/facility/facility.dart';
import 'package:me_super_admin/model/facility_type/facility_type.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/state/state.dart' as state_mode;
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/get_http_service.dart';
import 'package:me_super_admin/model/http_service/post_http_service.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';
import 'package:me_super_admin/utils/validation_message/facility_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/state_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/district_form_validation_message.dart';

class FacilityController extends GetxController {
  String snackbarTitle = "Facility Alert";
  List<Facility> facilities = [];
  Facility facility = Facility.defaultValues();
  bool isLoader = false;

  void resetFacilityForm() {
    facility = Facility.defaultValues();
    update();
  }

  void setFacilityForm(Facility facilityObj) {
    facility = facilityObj;
    update();

    if (facility.id.isNotEmpty) {
      Get.toNamed(RoutePaths.facilityForm);
    }
  }

  String? facilityTypeValidator(String? value) {
    return ValidationBuilder(
      requiredMessage: FacilityFormValidationMessage.facilityTypeRequired,
    ).required(FacilityFormValidationMessage.facilityTypeRequired).build()(value?.trim());
  }

  String? facilityNameValidator(String? value) {
    return ValidationBuilder(requiredMessage: FacilityFormValidationMessage.facilityNameRequired)
        .required(FacilityFormValidationMessage.facilityNameRequired)
        .minLength(2, FacilityFormValidationMessage.facilityNameMinLength)
        .maxLength(100, FacilityFormValidationMessage.facilityNameMaxLength)
        .build()(value?.trim());
  }

  void onFacilityTypeChange(FacilityType value, GlobalKey<FormFieldState> formFieldKey) {
    facility = facility.copyWith(facilityType: value);
    formFieldKey.currentState?.validate();
    update();
  }

  void onFacilityNameChange(String value) {
    facility = facility.copyWith(facilityName: value.trim());
    update();
  }

  void onFacilityTypeSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    facility = facility.copyWith(facilityName: value.trim());
    formFieldKey.currentState?.validate();
  }

  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      (facility.id.isEmpty) ? await postFacility() : await putFacility();
    }
  }

  Future<void> getFacilities() async {
    String authToken = await Utils.getAuthToken();
    facilities = [];
    isLoader = true;
    update();

    GetHttpService getHttpService = GetHttpService(
      endPoint: 'super-admin/facilities',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/facilities/facilities_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.getRequest(getHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      for (var facilityJson in response.data) {
        final Facility facilityObj = Facility.fromJson(facilityJson);
        facilities.add(facilityObj);
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

  Future<void> postFacility() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PostHttpService postHttpService = PostHttpService(
      endPoint: 'super-admin/facilities',
      headers: {"Authorization": 'Bearer $authToken'},
      body: facility.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/facilities/facilities_200.json',
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
      Get.offAllNamed(RoutePaths.facilities);
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

  Future<void> putFacility() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/facilities/${facility.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: facility.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/facilities/facilities_200.json',
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
      Get.offAllNamed(RoutePaths.facilities);
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

  Future<void> deleteFacility(String id) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    DeleteHttpService deleteHttpService = DeleteHttpService(
      endPoint: 'super-admin/facilities/$id',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/facilities/facilities_200.json',
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
      getFacilities();
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
