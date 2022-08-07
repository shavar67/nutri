import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/route_constants.dart';
import '../../model/theme_provider.dart';

class TabletView extends StatefulWidget {
  const TabletView({Key? key}) : super(key: key);

  @override
  State<TabletView> createState() => _TabletViewState();
}

class _TabletViewState extends State<TabletView> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
            title: Text('Home',
                style: TextStyle(
                    color: themeProvider.getDarkTheme
                        ? Colors.white
                        : Colors.black)),
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
