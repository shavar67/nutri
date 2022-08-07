import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/route_constants.dart';
import '../../model/theme_provider.dart';

class Desktop extends StatefulWidget {
  const Desktop({Key? key}) : super(key: key);

  @override
  State<Desktop> createState() => _DesktopState();
}

class _DesktopState extends State<Desktop> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
            title: Text('Home',
                style: TextStyle(
                    color: themeProvider.getDarkTheme
                        ? Colors.black
                        : Colors.white)),
            actions: [
          GestureDetector(
            child: Icon(
              Icons.settings,
              color: themeProvider.getDarkTheme ? Colors.white : Colors.black,
            ),
            onTap: () async {
              await Navigator.of(context).pushNamed(settingsRoute);
            },
          )
        ]));
  }
}
