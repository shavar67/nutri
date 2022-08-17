import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nuclear/screens/mobile/mobile.dart';
import 'package:nuclear/screens/shared/auth.dart';
import 'package:nuclear/screens/shared/login.dart';
import 'package:nuclear/screens/tablet/tablet.dart';

import '../../layout/responsive_layout.dart';
import '../desktop/desktop.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChange,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ResponsiveLayout(
                mobile: MobileView(), tablet: TabletView(), desktop: Desktop());
          } else {
            return const LoginWidget();
          }
        });
  }
}
