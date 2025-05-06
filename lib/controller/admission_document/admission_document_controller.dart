import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/http_service/get_http_service.dart';
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/post_http_service.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/admission_document/admission_document.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';
import 'package:me_super_admin/utils/validation_message/admission_document_validation_message.dart';

class AdmissionDocumentController extends GetxController {
  String snackbarTitle = "Admission Document Alert";
  bool isLoader = false;
  AdmissionDocument admissionDocument = AdmissionDocument.defaultValues();
  List<AdmissionDocument> admissionDocuments = [];

  void resetAdmissionDocumentForm() {
    admissionDocument = AdmissionDocument.defaultValues();
    update();
  }

  void setAdmissionDocumentForm(AdmissionDocument admissionDocumentObj) {
    admissionDocument = admissionDocumentObj;
    update();

    if (admissionDocument.id.isNotEmpty) {
      Get.offAllNamed(RoutePaths.admissionDocumentForm);
    }
  }

  String? admissionDocumentValidator(String? value) {
    return ValidationBuilder(
          requiredMessage: AdmissionDocumentValidationMessage.admissionDocumentRequired,
        )
        .required(AdmissionDocumentValidationMessage.admissionDocumentRequired)
        .minLength(2, AdmissionDocumentValidationMessage.admissionDocumentMinLength)
        .maxLength(100, AdmissionDocumentValidationMessage.admissionDocumentMaxLength)
        .build()(value?.trim());
  }

  void onAdmissionDocumentChange(String value) {
    admissionDocument = admissionDocument.copyWith(admissionDocument: value.trim());
    update();
  }

  void onAdmissionDocumentSubmitted(
    String value,
    GlobalKey<FormFieldState> formFieldKey,
    GlobalKey<FormState> formKey,
  ) {
    admissionDocument = admissionDocument.copyWith(admissionDocument: value.trim());
    formFieldKey.currentState?.validate();
    onSubmitForm(formKey);
  }

  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      (admissionDocument.id.isEmpty)
          ? await postAdmissionDocument()
          : await putAdmissionDocument();
    }
  }

  Future<void> getAdmissionDocuments() async {
    String authToken = await Utils.getAuthToken();
    admissionDocuments = [];
    isLoader = true;
    update();

    GetHttpService getHttpService = GetHttpService(
      endPoint: 'super-admin/admission-documents',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/admission_documents/admission_documents_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.getRequest(getHttpService);

    if (response.appHttpRequestStatus ==
        AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;
      for (var admissionDocumentJson in response.data) {
        final AdmissionDocument admissionDocumentObj = AdmissionDocument.fromJson(
          admissionDocumentJson,
        );
        admissionDocuments.add(admissionDocumentObj);
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

  Future<void> postAdmissionDocument() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PostHttpService postHttpService = PostHttpService(
      endPoint: 'super-admin/admission-documents',
      headers: {"Authorization": 'Bearer $authToken'},
      body: admissionDocument.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/admission_documents/admission_documents_200.json',
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
      Get.offAllNamed(RoutePaths.admissionDocuments);
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

  Future<void> putAdmissionDocument() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/admission-documents/${admissionDocument.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: admissionDocument.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/admission_documents/admission_documents_200.json',
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
      Get.offAllNamed(RoutePaths.admissionDocuments);
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

  Future<void> deleteAdmissionDocument(String id) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    DeleteHttpService deleteHttpService = DeleteHttpService(
      endPoint: 'super-admin/admission-documents/$id',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/admission_documents/admission_documents_200.json',
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
      getAdmissionDocuments();
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
