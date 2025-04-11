import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/utils/validation_message.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/academic_grade/academic_grade.dart';
import 'package:me_super_admin/model/http_service/get_http_service.dart';
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/post_http_service.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';

class AcademicGradeController extends GetxController {
  String snackbarTitle = "Academic Grade Alert";
  bool isLoader = false;
  AcademicGrade academicGrade = AcademicGrade.defaultValues();
  List<AcademicGrade> academicGrades = [];

  void resetAcademicGradeForm() {
    academicGrade = AcademicGrade.defaultValues();
    update();
  }

  void setAcademicGradeForm(AcademicGrade academicGradeObj) {
    academicGrade = academicGradeObj;
    update();

    if (academicGrade.id.isNotEmpty) {
      Get.offAllNamed(RoutePaths.academicGradeForm);
    }
  }

  String? academicGradeValidator(String? value) {
    return ValidationBuilder(
          requiredMessage: ValidationMessage.academicGradeRequired,
        )
        .required(ValidationMessage.academicGradeRequired)
        .minLength(2, ValidationMessage.academicGradeMinLength)
        .maxLength(100, ValidationMessage.academicGradeMaxLength)
        .build()(value?.trim());
  }

  void onAcademicGradeChange(String value) {
    academicGrade = academicGrade.copyWith(academicGrade: value.trim());
    update();
  }

  void onAcademicGradeSubmitted(
    String value,
    GlobalKey<FormFieldState> formFieldKey,
    GlobalKey<FormState> formKey,
  ) {
    academicGrade = academicGrade.copyWith(academicGrade: value.trim());
    formFieldKey.currentState?.validate();
    onSubmitForm(formKey);
  }

  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      if (academicGrade.id.isEmpty) {
        await postAcademicGrade();
      } else {
        await putAcademicGrade();
      }
    }
  }

  Future<void> getAcademicGrades() async {
    String authToken = await Utils.getAuthToken();
    academicGrades = [];
    isLoader = true;
    update();

    GetHttpService getHttpService = GetHttpService(
      endPoint: 'super-admin/academic-grades',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/academic_grades/academic_grades_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.getRequest(getHttpService);

    if (response.appHttpRequestStatus ==
        AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      for (var academicGradeJson in response.data) {
        final AcademicGrade academicGradeObj = AcademicGrade.fromJson(
          academicGradeJson,
        );
        academicGrades.add(academicGradeObj);
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

  Future<void> postAcademicGrade() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PostHttpService postHttpService = PostHttpService(
      endPoint: 'super-admin/academic-grades',
      headers: {"Authorization": 'Bearer $authToken'},
      body: academicGrade.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/academic_grades/academic_grades_200.json',
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
      Get.offAllNamed(RoutePaths.academicGrades);
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

  Future<void> putAcademicGrade() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/academic-grades/${academicGrade.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: academicGrade.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/academic_grades/academic_grades_200.json',
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
      Get.offAllNamed(RoutePaths.academicGrades);
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

  Future<void> deleteAcademicGrade(String id) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    DeleteHttpService deleteHttpService = DeleteHttpService(
      endPoint: 'super-admin/academic-grades/$id',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/academic_grades/academic_grades_200.json',
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
      getAcademicGrades();
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
