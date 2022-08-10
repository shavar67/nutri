import 'package:flutter/material.dart';
import 'package:nuclear/screens/mobile/mobile.dart';
import 'package:nuclear/screens/tablet/tablet.dart';

import '../../layout/responsive_layout.dart';
import '../desktop/desktop.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        mobile: MobileView(), tablet: TabletView(), desktop: Desktop());
  }
}
