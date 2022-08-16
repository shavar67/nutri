import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nuclear/screens/mobile/mobile.dart';
import 'package:nuclear/screens/shared/auth.dart';
import 'package:nuclear/screens/tablet/tablet.dart';

import '../../layout/responsive_layout.dart';
import '../desktop/desktop.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        mobile: MobileView(), tablet: TabletView(), desktop: Desktop());
  }
}
