import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nuclear/screens/mobile/mobile.dart';
import 'package:nuclear/screens/tablet/tablet.dart';
import 'package:provider/provider.dart';

import '../../firebase_auth/auth.dart';
import '../../firebase_auth/authenticator.dart';
import '../../layout/responsive_layout.dart';
import '../desktop/desktop.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return StreamBuilder<User?>(
        initialData: authService.currentUser,
        stream: authService.authStateChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ResponsiveLayout(
                mobile: MobileView(), tablet: TabletView(), desktop: Desktop());
          } else {
            return const Authenticator();
          }
        });
  }
}
