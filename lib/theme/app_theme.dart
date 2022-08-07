import 'package:flutter/material.dart';

class AppTheme {
  static get lightTheme => ThemeData(
      appBarTheme: const AppBarTheme(elevation: 0, color: Colors.white),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white.withOpacity(0.95));

  static get darkTheme => ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(elevation: 0, color: Colors.black),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black);
}
