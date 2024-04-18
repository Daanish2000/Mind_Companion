import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? preferences;
  //For Initializing One Time And Use AnyWHere
  static Future<void> init() async {
    preferences ??= await SharedPreferences.getInstance();
  }
}
