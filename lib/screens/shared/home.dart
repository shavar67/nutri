import 'package:flutter/material.dart';
import 'package:nuclear/screens/mobile/mobile.dart';
import 'package:nuclear/screens/tablet/tablet.dart';

import '../../layout/responsive_layout.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobile: const MobileView(),
        tablet: const TabletView(),
        desktop: Container());
  }
}
