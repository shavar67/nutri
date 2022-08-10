import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreference {
  var logger = Logger(printer: PrettyPrinter());
  static const themeStatus = 'theme';
  saveTheme(bool val) async {
    Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    SharedPreferences pref = await sharedPreferences;
    pref.setBool(themeStatus, val);
  }

  getTheme() async {
    Future<SharedPreferences> sharedPreferences =
        SharedPreferences.getInstance();
    SharedPreferences pref = await sharedPreferences;
    bool? isOn = pref.getBool(themeStatus);
    logger.d('key present in shared pref: $isOn');
    return pref.getBool('theme') ?? false;
  }
}
