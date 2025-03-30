import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:me_super_admin/model/authentication/user.dart';

class Utils {
  static Future<String> getAuthToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? '';
  }

  static Future<User> getUser() async {
    final pref = await SharedPreferences.getInstance();
    User user = User.defaultValues();
    Map<String, dynamic> userJson = jsonDecode(pref.getString('user') ?? '{}');
    if (userJson.isNotEmpty) {
      user = User.fromJson(userJson);
    }
    return user;
  }

  static Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();

    await pref.setString('token', '');
    await pref.setString('user', '{}');
    Get.offAllNamed('/');
  }
}
