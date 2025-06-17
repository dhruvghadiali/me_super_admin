import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/model/zipcode/zipcode.dart';
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
import 'package:me_super_admin/utils/validation_message/zipcode_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/area_name_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/city_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/state_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/district_form_validation_message.dart';

class ZipcodeController extends GetxController {
  String snackbarTitle = "Zipcode Alert";
  List<Zipcode> zipcodes = [];
  Zipcode zipcode = Zipcode.defaultValues();
  bool isLoader = false;

  void resetZipcodeForm() {
    zipcode = Zipcode.defaultValues();
    update();
  }

  void setZipcodeForm(Zipcode zipcodeObj) {
    zipcode = zipcodeObj;
    update();

    if (zipcode.id.isNotEmpty) {
      Get.toNamed(RoutePaths.zipcodeForm);
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
    return ValidationBuilder(
      requiredMessage: AreaNameFormValidationMessage.areaNameRequired,
    ).required(AreaNameFormValidationMessage.areaNameRequired).build()(value?.trim());
  }

  String? zipcodeValidator(String? value) {
    return ValidationBuilder(requiredMessage: ZipcodeFormValidationMessage.zipcodeRequired)
        .required(ZipcodeFormValidationMessage.zipcodeRequired)
        .regExp(RegExp(r'^[1-9][0-9]{5}$'), ZipcodeFormValidationMessage.invalidZipcode)
        .build()(value?.trim());
  }

  void onStateChange(state_mode.State value, GlobalKey<FormFieldState> formFieldKey) {
    AreaName areaName = zipcode.areaName;
    City city = areaName.city;
    District district = city.district;

    district = district.copyWith(state: value, id: "", name: "");
    city = city.copyWith(district: district, id: "", name: "");
    areaName = areaName.copyWith(city: city, id: "", name: "");
    zipcode = zipcode.copyWith(areaName: areaName);

    formFieldKey.currentState?.validate();
    update();
  }

  void onDistrictChange(District value, GlobalKey<FormFieldState> formFieldKey) {
    AreaName areaName = zipcode.areaName;
    City city = areaName.city;

    city = city.copyWith(district: value, id: "", name: "");
    areaName = areaName.copyWith(city: city, id: "", name: "");
    zipcode = zipcode.copyWith(areaName: areaName);

    formFieldKey.currentState?.validate();

    update();
  }

  void onCityChange(City value, GlobalKey<FormFieldState> formFieldKey) {
    AreaName areaName = zipcode.areaName;

    areaName = areaName.copyWith(city: value, id: "", name: "");
    zipcode = zipcode.copyWith(areaName: areaName);

    formFieldKey.currentState?.validate();
    update();
  }

  void onAreaNameChange(AreaName value, GlobalKey<FormFieldState> formFieldKey) {
    zipcode = zipcode.copyWith(areaName: value);

    formFieldKey.currentState?.validate();
    update();
  }

  void onZipcodeChange(String value) {
    zipcode = zipcode.copyWith(zipcode: value.trim());
    update();
  }

  void onZipcodeSubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    zipcode = zipcode.copyWith(zipcode: value.trim());
    formFieldKey.currentState?.validate();
  }

  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      (zipcode.id.isEmpty) ? await postZipcode() : await putZipcode();
    }
  }

  Future<void> getZipcodes() async {
    String authToken = await Utils.getAuthToken();
    zipcodes = [];
    isLoader = true;
    update();

    GetHttpService getHttpService = GetHttpService(
      endPoint: 'super-admin/zipcodes',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/zipcodes/zipcodes_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.getRequest(getHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;

      for (var zipcodeJson in response.data) {
        final Zipcode zipcodeObj = Zipcode.fromJson(zipcodeJson);
        zipcodes.add(zipcodeObj);
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

  Future<void> postZipcode() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PostHttpService postHttpService = PostHttpService(
      endPoint: 'super-admin/zipcodes',
      headers: {"Authorization": 'Bearer $authToken'},
      body: zipcode.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/zipcodes/zipcodes_200.json',
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
      Get.offAllNamed(RoutePaths.zipcodes);
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

  Future<void> putZipcode() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/zipcodes/${zipcode.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: zipcode.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/zipcodes/zipcodes_200.json',
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
      Get.offAllNamed(RoutePaths.zipcodes);
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

  Future<void> deleteZipcode(String id) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    DeleteHttpService deleteHttpService = DeleteHttpService(
      endPoint: 'super-admin/zipcodes/$id',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/zipcodes/zipcodes_200.json',
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
      getZipcodes();
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
