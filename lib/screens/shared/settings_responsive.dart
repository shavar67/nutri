import 'package:flutter/material.dart';
import 'package:nuclear/layout/responsive_layout.dart';
import 'package:nuclear/widgets/mobile/mobile_setting_options.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';
import '../../widgets/desktop/desktop_setting_option.dart';
import '../../widgets/tablet/tablet_setting_options.dart';

class Preference extends StatefulWidget {
  const Preference({Key? key}) : super(key: key);

  @override
  State<Preference> createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    Size size = MediaQuery.of(context).size;
    return const Scaffold(
      body: ResponsiveLayout(
          mobile: MobileSettingOptions(),
          tablet: TabletSettingOptions(),
          desktop: DesktopSettingOptions()),
    );
  }
}
