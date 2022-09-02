import 'package:flutter/material.dart';
import 'package:nuclear/theme/styles.dart';

class AppTheme {
  static get lightTheme => ThemeData(
      appBarTheme: const AppBarTheme(elevation: 0, color: Styles.white),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Styles.lightBgColor);

  static get darkTheme => ThemeData.dark().copyWith(
      // useMaterial3: true,
      // applyElevationOverlayColor: true,
      appBarTheme:
          const AppBarTheme(elevation: 0, color: Styles.defaultDarkModeBg),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Styles.defaultDarkModeBg);
}
