import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:me_super_admin/utils/routes.dart';
import 'package:me_super_admin/model/city/city.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/model/district/district.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/state/state.dart' as state_mode;
import 'package:me_super_admin/model/http_service/put_http_service.dart';
import 'package:me_super_admin/model/http_service/get_http_service.dart';
import 'package:me_super_admin/model/http_service/post_http_service.dart';
import 'package:me_super_admin/model/http_service/delete_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';
import 'package:me_super_admin/utils/validation_message/city_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/state_form_validation_message.dart';
import 'package:me_super_admin/utils/validation_message/district_form_validation_message.dart';

class CityController extends GetxController {
  String snackbarTitle = "City Alert";
  List<City> cities = [];
  City city = City.defaultValues();
  bool isLoader = false;

  void resetCityForm() {
    city = City.defaultValues();
    update();
  }

  void setCityForm(City cityObj) {
    city = cityObj;
    update();

    if (city.id.isNotEmpty) {
      Get.toNamed(RoutePaths.cityForm);
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
    return ValidationBuilder(requiredMessage: CityFormValidationMessage.cityRequired)
        .required(CityFormValidationMessage.cityRequired)
        .minLength(2, CityFormValidationMessage.cityMinLength)
        .maxLength(100, CityFormValidationMessage.cityMaxLength)
        .build()(value?.trim());
  }

  void onStateChange(state_mode.State value, GlobalKey<FormFieldState> formFieldKey) {
    District district = city.district;
    district = district.copyWith(state: value, id: "", name: "");
    city = city.copyWith(district: district);
    formFieldKey.currentState?.validate();
    update();
  }

  void onDistrictChange(District value, GlobalKey<FormFieldState> formFieldKey) {
    city = city.copyWith(district: value);
    formFieldKey.currentState?.validate();
    update();
  }

  void onCityChange(String value) {
    city = city.copyWith(name: value.trim());
    update();
  }

  void onCitySubmitted(String value, GlobalKey<FormFieldState> formFieldKey) {
    city = city.copyWith(name: value.trim());
    formFieldKey.currentState?.validate();
  }

  void onSubmitForm(GlobalKey<FormState> formKey) async {
    if (formKey.currentState?.validate() ?? false) {
      (city.id.isEmpty) ? await postCity() : await putCity();
    }
  }

  Future<void> getCities() async {
    String authToken = await Utils.getAuthToken();
    cities = [];
    isLoader = true;
    update();

    GetHttpService getHttpService = GetHttpService(
      endPoint: 'super-admin/cities',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/cities/cities_200.json',
        statusCode: 200,
      ),
    );

    HttpResponseService response = await HttpService.getRequest(getHttpService);

    if (response.appHttpRequestStatus == AppHttpRequestStatus.isSuccessfullyServiced) {
      isLoader = false;

      for (var cityJson in response.data) {
        final City cityObj = City.fromJson(cityJson);
        cities.add(cityObj);
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

  Future<void> postCity() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PostHttpService postHttpService = PostHttpService(
      endPoint: 'super-admin/cities',
      headers: {"Authorization": 'Bearer $authToken'},
      body: city.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/cities/cities_200.json',
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
      Get.offAllNamed(RoutePaths.cities);
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

  Future<void> putCity() async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    PutHttpService putHttpService = PutHttpService(
      endPoint: 'super-admin/cities/${city.id}',
      headers: {"Authorization": 'Bearer $authToken'},
      body: city.toJson(),
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/cities/cities_200.json',
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
      Get.offAllNamed(RoutePaths.cities);
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

  Future<void> deleteCity(String id) async {
    String authToken = await Utils.getAuthToken();
    isLoader = true;
    update();

    DeleteHttpService deleteHttpService = DeleteHttpService(
      endPoint: 'super-admin/cities/$id',
      headers: {"Authorization": 'Bearer $authToken'},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/cities/cities_200.json',
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
      getCities();
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
