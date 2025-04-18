import 'package:flutter/material.dart';
import 'package:flutter_auth/pages/controller/login_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Map<String, dynamic>? res;
  late SharedPreferences prep;
  String? token;

  final LoginController loginController = LoginController();

  @override
  void initState() {
    // Future.delayed(const Duration(seconds: 5), getLogin);
    loginController.skipLogin();
    super.initState();
  }

  Future<void> getLogin() async {
    prep = await SharedPreferences.getInstance();

    token = prep.getString("token");
    // res = await ApiServices.dashboard(token: token ?? "");
    // print(res!["statusCode"]);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(appBar: AppBar()),
      debugShowCheckedModeBanner: false,
    );
  }
}
