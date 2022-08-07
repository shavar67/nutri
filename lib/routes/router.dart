import 'package:flutter/material.dart';

import '../constants/route_constants.dart';
import '../screens/shared/home.dart';
import '../screens/shared/settings.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const Home());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const Settings());

      default:
        return MaterialPageRoute(builder: (_) => const Home());
    }
  }
}
