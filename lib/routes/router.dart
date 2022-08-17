import 'package:flutter/material.dart';
import 'package:nuclear/screens/shared/register.dart';
import 'package:nuclear/screens/shared/settings_responsive.dart';

import '../constants/route_constants.dart';
import '../screens/shared/home.dart';
import '../screens/shared/login.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const Home());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const Preference());
      case loginRoute:
        return MaterialPageRoute(builder: (context) => const LoginWidget());
      case signUpRoute:
        return MaterialPageRoute(builder: (context) => const SignUp());
      default:
        return MaterialPageRoute(builder: (_) => const Home());
    }
  }
}
