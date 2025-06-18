import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/academic_class/academic_class.dart';
import 'package:me_super_admin/model/http_service/get_http_service.dart';
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/post_http_service.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';
import 'package:me_super_admin/utils/validation_message/academic_class_validation_message.dart';

class AcademicClassController extends GetxController {
  String snackbarTitle = "Academic Class Alert";
  bool isLoader = false;
  AcademicClass academicClass = AcademicClass.defaultValues();
  List<AcademicClass> academicClasses = [];

  void resetAcademicClassForm() {
    academicClass = AcademicClass.defaultValues();
    update();
  }

  void setAcademicClassForm(AcademicClass academicClassObj) {
    academicClass = academicClassObj;
    update();

    if (academicClass.id.isNotEmpty) {
      Get.toNamed(RoutePaths.academicClassForm);
    }
  }

  String? academicClassValidator(String? value) {
    return ValidationBuilder(requiredMessage: AcademicClassValidationMessage.academicClassRequired)
        .required(AcademicClassValidationMessage.academicClassRequired)
        .minLength(2, AcademicClassValidationMessage.academicClassMinLength)
        .maxLength(100, AcademicClassValidationMessage.academicClassMaxLength)
        .build()(value?.trim());
  }

  void onAcademicClassChange(String value) {
    academicClass = academicClass.copyWith(academicClass: value.trim());
    update();
  }

  void onAcademicClassSubmitted(
    String value,
    GlobalKey<FormFieldState> formFieldKey,
    GlobalKey<FormState> formKey,
  ) {
    academicClass = academicClass.copyWith(academicClass: value.trim());
    formFieldKey.currentState?.validate();
    onSubmitForm(formKey);
  }

  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      (academicClass.id.isEmpty) ? await postAcademicClass() : await putAcademicClass();
    }
  }

  Future<void> getAcademicClasses() async {
    String authToken = await Utils.getAuthToken();
    academicClasses = [];
    isLoader = true;
    update();

    GetHttpService getHttpService = GetHttpService(
      endPoint: 'super-admin/academic-classes',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/academic_classes/academic_classes_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.getRequest(getHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      for (var academicClassJson in response.data) {
        final AcademicClass academicClassObj = AcademicClass.fromJson(academicClassJson);
        academicClasses.add(academicClassObj);
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

  Future<void> postAcademicClass() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PostHttpService postHttpService = PostHttpService(
      endPoint: 'super-admin/academic-classes',
      headers: {"Authorization": 'Bearer $authToken'},
      body: academicClass.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/academic_classes/academic_classes_200.json',
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
      Get.offAllNamed(RoutePaths.academicClasses);
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

  Future<void> putAcademicClass() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/academic-classes/${academicClass.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: academicClass.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/academic_classes/academic_classes_200.json',
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
      Get.offAllNamed(RoutePaths.academicClasses);
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

  Future<void> deleteAcademicClass(String id) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    DeleteHttpService deleteHttpService = DeleteHttpService(
      endPoint: 'super-admin/academic-classes/$id',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/academic_classes/academic_classes_200.json',
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
      getAcademicClasses();
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
