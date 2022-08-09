import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nuclear/constants/strings.dart';
import 'package:nuclear/theme/styles.dart';
import 'package:provider/provider.dart';

import '../../constants/route_constants.dart';
import '../../model/theme_provider.dart';

class MobileView extends StatefulWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
            title: AutoSizeText(
              Strings.homeTitle,
              style: TextStyle(
                  color: themeProvider.getDarkTheme
                      ? Styles.white
                      : Styles.defaultDarkModeBg),
            ),
            actions: [
          GestureDetector(
            child: Icon(Icons.settings_outlined,
                color: themeProvider.getDarkTheme
                    ? Styles.white
                    : Styles.defaultDarkModeBg),
            onTap: () async {
              await Navigator.of(context).pushNamed(settingsRoute);
            },
          )
        ]));
  }
}
