import 'package:shared_preferences/shared_preferences.dart';

class LocalDatabaseServices {
  LocalDatabaseServices._inistace();

  Future<SharedPreferences> share() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }
}
