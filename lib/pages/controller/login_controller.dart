import 'dart:convert';

import 'package:flutter_auth/pages/dasboard.dart';
import 'package:flutter_auth/pages/login.dart';
import 'package:flutter_auth/pages/services/api_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  bool isLogin = false;
  void skipLogin() async {
    SharedPreferences prep = await SharedPreferences.getInstance();
    String? token = prep.getString("token");
    Map<String, dynamic>? res = await ApiServices.dashboard(token: token ?? "");
    if (res["statusCode"] == 200) {
      Map message = jsonDecode(res["data"]);
      Get.off(Dashboard(message: message["message"]));
      print(message["message"]);
    } else {
      Get.off(const Login());
      print(res["statusCode"]);
    }
  }
}
