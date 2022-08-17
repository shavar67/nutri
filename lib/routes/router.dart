import 'package:flutter/material.dart';
import 'package:nuclear/screens/mobile/login.dart';
import 'package:nuclear/screens/shared/settings_responsive.dart';

import '../constants/route_constants.dart';
import '../screens/shared/home.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const Home());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const Preference());
      case loginRoute:
        return MaterialPageRoute(builder: (context) => const MobileLoginView());
      default:
        return MaterialPageRoute(builder: (_) => const Home());
    }
  }
}
