import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/model/theme_provider.dart';
import 'package:nuclear/utils/spacers.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var logger = Logger(printer: PrettyPrinter());

  bool _isDarkModeOn = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: AutoSizeText('Settings',
              style: TextStyle(
                  color: themeProvider.getDarkTheme
                      ? Colors.white
                      : Colors.black)),
          leading: FittedBox(
            child: SizedBox(
              height: size.height * 0.03,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.blue,
                    ),
                    AutoSizeText(
                      'Home',
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: KSpacers.space12, horizontal: KSpacers.space12 * 2),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: size.height * 0.03,
                child: const FittedBox(
                  child: AutoSizeText(
                    'Appearance',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: size.width * 90,
                height:
                    size.width > 850 ? size.height * 0.24 : size.height * 0.20,
                decoration: BoxDecoration(
                    color: themeProvider.getDarkTheme
                        ? Colors.grey[900]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: KSpacers.space12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: KSpacers.space10 * 3),
                      const Divider(),
                      const SizedBox(height: KSpacers.space10 - 4),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isDarkModeOn = !_isDarkModeOn;
                          });
                          themeProvider.setDarkTheme = _isDarkModeOn;
                          logger.d(
                              'toggle dark mode on: ${themeProvider.getDarkTheme}');
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: themeProvider.getDarkTheme == true
                                  ? Colors.black
                                  : Colors.grey.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      const SizedBox(height: KSpacers.space10),
                      CupertinoSwitch(
                        activeColor: Colors.green,
                        value: themeProvider.getDarkTheme,
                        onChanged: (val) {
                          setState(() {
                            themeProvider.setDarkTheme = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
