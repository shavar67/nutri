import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/services/app_preferences.dart';

class ThemeProvider with ChangeNotifier {
  AppPreference appPreference = AppPreference();
  var logger = Logger(printer: PrettyPrinter());
  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    appPreference.saveTheme(value);
    notifyListeners();
    logger.i('loggin from themeProvider class: dark theme on? $_darkTheme');
  }
}
