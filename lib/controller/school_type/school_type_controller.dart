import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/utils/validation_message.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/school_type/school_type.dart';
import 'package:me_super_admin/model/http_service/get_http_service.dart';
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/post_http_service.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';

class SchoolTypeController extends GetxController {
  String snackbarTitle = "School Type Alert";
  bool isLoader = false;
  SchoolType schoolType = SchoolType.defaultValues();
  List<SchoolType> schoolTypes = [];

  final schoolTypeValidator =
      ValidationBuilder()
          .required(ValidationMessage.schoolTypeNameRequired)
          .minLength(2, ValidationMessage.schoolTypeNameMinLength)
          .maxLength(100, ValidationMessage.schoolTypeNameMaxLength)
          .build();

  void resetSchoolTypeForm() {
    schoolType = SchoolType.defaultValues();
    update();
  }

  void setSchoolTypeForm(SchoolType schoolTypeObj) {
    schoolType = schoolTypeObj;
    update();

    if (schoolType.id.isNotEmpty) {
      Get.offAllNamed(RoutePaths.schoolTypesRegistration);
    }
  }

  void onSchoolTypeChange(String value) {
    schoolType = schoolType.copyWith(schoolType: value);
    update();
  }

  void onSchoolTypeSubmitted(
    String value,
    GlobalKey<FormFieldState> formFieldKey,
  ) {
    schoolType = schoolType.copyWith(schoolType: value);
    formFieldKey.currentState?.validate();
    update();
  }

  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      if (schoolType.id.isEmpty) {
        await postSchoolType();
      } else {
        await putSchoolType();
      }
    }
  }

  Future<void> getSchoolTypes() async {
    String authToken = await Utils.getAuthToken();
    schoolTypes = [];
    isLoader = true;
    update();

    GetHttpService getHttpService = GetHttpService(
      endPoint: 'super-admin/school-types',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/school_types/school_types_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.getRequest(getHttpService);

    if (response.appHttpRequestStatus ==
        AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      for (var schoolTypeJson in response.data) {
        final SchoolType schoolTypeObj = SchoolType.fromJson(schoolTypeJson);
        schoolTypes.add(schoolTypeObj);
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

  Future<void> postSchoolType() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PostHttpService postHttpService = PostHttpService(
      endPoint: 'super-admin/school-types',
      headers: {"Authorization": 'Bearer $authToken'},
      body: schoolType.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/school_types/school_types_200.json',
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
      Get.offAllNamed(RoutePaths.schoolTypes);
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

  Future<void> putSchoolType() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/school-types/${schoolType.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: schoolType.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/school_types/school_types_200.json',
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
      Get.offAllNamed(RoutePaths.schoolTypes);
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

  Future<void> deleteSchoolTypes(String id) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    DeleteHttpService deleteHttpService = DeleteHttpService(
      endPoint: 'super-admin/school-types/$id',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/school_types/school_types_200.json',
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
      getSchoolTypes();
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
