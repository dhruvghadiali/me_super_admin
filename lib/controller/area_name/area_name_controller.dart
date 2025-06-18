import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/area_name/area_name.dart';
import 'package:me_super_admin/model/state/state.dart' as state_mode;
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/get_http_service.dart';
import 'package:me_super_admin/model/http_service/post_http_service.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';
import 'package:me_super_admin/utils/validation_message/area_name_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/city_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/state_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/district_form_validation_message.dart';

class AreaNameController extends GetxController {
  String snackbarTitle = "Area Name Alert";
  List<AreaName> areaNames = [];
  AreaName areaName = AreaName.defaultValues();
  bool isLoader = false;

  void resetAreaNameForm() {
    areaName = AreaName.defaultValues();
    update();
  }

  void setAreaNameForm(AreaName areaNameObj) {
    areaName = areaNameObj;
    update();

    if (areaName.id.isNotEmpty) {
      Get.toNamed(RoutePaths.areaNameForm);
    }
  }

  String? stateValidator(String? value) {
    return ValidationBuilder(
      requiredMessage: StateFormValidationMessage.stateRequired,
    ).required(StateFormValidationMessage.stateRequired).build()(value?.trim());
  }

  String? districtValidator(String? value) {
    return ValidationBuilder(
      requiredMessage: DistrictFormValidationMessage.districtRequired,
    ).required(DistrictFormValidationMessage.districtRequired).build()(value?.trim());
  }

  String? cityValidator(String? value) {
    return ValidationBuilder(
      requiredMessage: CityFormValidationMessage.cityRequired,
    ).required(CityFormValidationMessage.cityRequired).build()(value?.trim());
  }

  String? areaNameValidator(String? value) {
    return ValidationBuilder(requiredMessage: AreaNameFormValidationMessage.areaNameRequired)
        .required(AreaNameFormValidationMessage.areaNameRequired)
        .minLength(2, AreaNameFormValidationMessage.areaNameMinLength)
        .maxLength(100, AreaNameFormValidationMessage.areaNameMaxLength)
        .build()(value?.trim());
  }

  void onStateChange(state_mode.State value, GlobalKey<FormFieldState> formFieldKey) {
    City city = areaName.city;
    District district = city.district;

    district = district.copyWith(state: value, id: "", name: "");
    city = city.copyWith(district: district, id: "", name: "");
    areaName = areaName.copyWith(city: city);

    formFieldKey.currentState?.validate();
    update();
  }

  void onDistrictChange(District value, GlobalKey<FormFieldState> formFieldKey) {
    City city = areaName.city;
    city = city.copyWith(district: value, id: "", name: "");

    areaName = areaName.copyWith(city: city);
    formFieldKey.currentState?.validate();

    update();
  }

  void onCityChange(City value, GlobalKey<FormFieldState> formFieldKey) {
    areaName = areaName.copyWith(city: value);
    formFieldKey.currentState?.validate();
    update();
  }

  void onAreaNameChange(String value) {
    areaName = areaName.copyWith(name: value.trim());
    update();
  }

  void onAreaNameSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    areaName = areaName.copyWith(name: value.trim());
    formFieldKey.currentState?.validate();
  }

  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      (areaName.id.isEmpty) ? await postAreaName() : await putAreaName();
    }
  }

  Future<void> getAreaNames() async {
    String authToken = await Utils.getAuthToken();
    areaNames = [];
    isLoader = true;
    update();

    GetHttpService getHttpService = GetHttpService(
      endPoint: 'super-admin/area-names',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/area-names/area-names_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.getRequest(getHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;

      for (var areaNameJson in response.data) {
        final AreaName areaNameObj = AreaName.fromJson(areaNameJson);
        areaNames.add(areaNameObj);
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

  Future<void> postAreaName() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PostHttpService postHttpService = PostHttpService(
      endPoint: 'super-admin/area-names',
      headers: {"Authorization": 'Bearer $authToken'},
      body: areaName.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/area-names/area-names_200.json',
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
      Get.offAllNamed(RoutePaths.areaNames);
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

  Future<void> putAreaName() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/area-names/${areaName.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: areaName.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/area-names/area-names_200.json',
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
      Get.offAllNamed(RoutePaths.areaNames);
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

  Future<void> deleteAreaName(String id) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    DeleteHttpService deleteHttpService = DeleteHttpService(
      endPoint: 'super-admin/area-names/$id',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/area-names/area-names_200.json',
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
      getAreaNames();
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
