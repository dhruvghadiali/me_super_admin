import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/utils/validation_message.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/http_service/get_http_service.dart';
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/post_http_service.dart';
import 'package:me_super_admin/model/education_board/education_board.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';

class EducationBoardController extends GetxController {
  String snackbarTitle = "Education Board Alert";
  bool isLoader = false;
  EducationBoard educationBoard = EducationBoard.defaultValues();
  List<EducationBoard> educationBoards = [];

  void resetEducationBoardForm() {
    educationBoard = EducationBoard.defaultValues();
    update();
  }

  void setEducationBoardForm(EducationBoard educationBoardObj) {
    educationBoard = educationBoardObj;
    update();

    if (educationBoard.id.isNotEmpty) {
      Get.offAllNamed(RoutePaths.educationBoardForm);
    }
  }

  String? educationBoardValidator(String? value) {
    return ValidationBuilder(
          requiredMessage: ValidationMessage.educationBoardRequired,
        )
        .required(ValidationMessage.educationBoardRequired)
        .minLength(2, ValidationMessage.educationBoardMinLength)
        .maxLength(100, ValidationMessage.educationBoardMaxLength)
        .build()(value?.trim());
  }

  void onEducationBoardChange(String value) {
    educationBoard = educationBoard.copyWith(educationBoard: value.trim());
    update();
  }

  void onEducationBoardSubmitted(
    String value,
    GlobalKey<FormFieldState> formFieldKey,
    GlobalKey<FormState> formKey,
  ) {
    educationBoard = educationBoard.copyWith(educationBoard: value.trim());
    formFieldKey.currentState?.validate();
    onSubmitForm(formKey);
  }

  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      (educationBoard.id.isEmpty)
          ? await postEducationBoard()
          : await putEducationBoard();
    }
  }

  Future<void> getEducationBoards() async {
    String authToken = await Utils.getAuthToken();
    educationBoards = [];
    isLoader = true;
    update();

    GetHttpService getHttpService = GetHttpService(
      endPoint: 'super-admin/education-boards',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/education_boards/education_boards_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.getRequest(getHttpService);

    if (response.appHttpRequestStatus ==
        AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      for (var educationBoardJson in response.data) {
        final EducationBoard educationBoardObj = EducationBoard.fromJson(
          educationBoardJson,
        );
        educationBoards.add(educationBoardObj);
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

  Future<void> postEducationBoard() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PostHttpService postHttpService = PostHttpService(
      endPoint: 'super-admin/education-boards',
      headers: {"Authorization": 'Bearer $authToken'},
      body: educationBoard.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/education_boards/education_boards_200.json',
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
      Get.offAllNamed(RoutePaths.educationBoards);
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

  Future<void> putEducationBoard() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/education-boards/${educationBoard.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: educationBoard.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/education_boards/education_boards_200.json',
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
      Get.offAllNamed(RoutePaths.educationBoards);
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

  Future<void> deleteEducationBoard(String id) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    DeleteHttpService deleteHttpService = DeleteHttpService(
      endPoint: 'super-admin/education-boards/$id',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/education_boards/education_boards_200.json',
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
      getEducationBoards();
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
