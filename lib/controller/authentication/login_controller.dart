import 'dart:convert';
import 'package:get/get.dart';
import 'package:me_super_admin/app_enum.dart';
import 'package:me_super_admin/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:me_super_admin/utils/snackbar/snackbar.dart';
import 'package:me_super_admin/model/authentication/user.dart';
import 'package:me_super_admin/service/http/http_service.dart';
import 'package:me_super_admin/model/authentication/login.dart';
import 'package:me_super_admin/model/http_service/post_http_service.dart';
import 'package:me_super_admin/model/http_service/http_response_service.dart';
import 'package:me_super_admin/model/http_service/mock_http_api_property_service.dart';

class LoginController extends GetxController {
  bool isLoader = false;
  bool showUsernameTextfieldError = false;
  bool showPasswordTextfieldError = false;

  void usernameValidation(String username) {
    if (username.length < 5 || username.length > 200) {
      showUsernameTextfieldError = true;
      Snackbar.getSnackbar(
        title: 'Authentication Issue',
        message: 'Invalid username formate',
        appSnackbarStatus: AppSnackbarStatus.error,
      );
    } else {
      showUsernameTextfieldError = false;
    }

    update();
  }

  void passwordValidation(String password) {
    if (password.length < 5 || password.length > 200) {
      showPasswordTextfieldError = true;
      Snackbar.getSnackbar(
        title: 'Authentication Issue',
        message: 'Invalid password formate',
        appSnackbarStatus: AppSnackbarStatus.error,
      );
    } else {
      showPasswordTextfieldError = false;
    }

    update();
  }

  Future<void> checkActiveUser() async {
    User user = await Utils.getUser();

    if (user.username.isNotEmpty && user.token.isNotEmpty) {
      Get.offAllNamed('/dashboard');
    }
  }

  Future<void> login(Login loginDetails) async {
    final prefs = await SharedPreferences.getInstance();

    isLoader = true;
    update();

    PostHttpService postHttpService = PostHttpService(
      endPoint: 'super-admin/signin',
      headers: {},
      mockHttpAPIProperty: MockHttpAPIPropertyService(
        endPoint: 'assets/mock_data/login/login_200.json',
        statusCode: 200,
      ),
      body: loginDetails.toJson(),
    );

    HttpResponseService response =
        await HttpService.postRequest(postHttpService);

    if (response.appHttpRequestStatus ==
        AppHttpRequestStatus.isSuccessfullyServiced) {
      final User user = User.fromJson(response.data[0]);
      await prefs.setString('user', jsonEncode(response.data[0]));
      await prefs.setString('token', user.token);
      isLoader = false;
      Get.offAllNamed('/dashboard');
    } else {
      isLoader = false;
      Snackbar.getSnackbar(
        title: 'Authentication Issue',
        message: response.message,
        appSnackbarStatus: AppSnackbarStatus.error,
      );
    }

    update();
  }
}
