import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nuclear/constants/strings.dart';
import 'package:nuclear/model/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../theme/styles.dart';
import '../../utils/spacers.dart';

class TabletSettingOptions extends StatefulWidget {
  const TabletSettingOptions({Key? key}) : super(key: key);

  @override
  State<TabletSettingOptions> createState() => _TabletSettingOptionsState();
}

class _TabletSettingOptionsState extends State<TabletSettingOptions> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: KSpacers.space12, horizontal: KSpacers.space12 * 2),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const AutoSizeText(
              Strings.settingsPanelHeader,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Container(
              width: size.width * 90,
              height: size.height * 0.22,
              decoration: BoxDecoration(
                  color: themeProvider.getDarkTheme
                      ? Styles.greyShade900
                      : Styles.white,
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: KSpacers.space10 - 8),
                  ListTile(
                    subtitle: themeProvider.getDarkTheme
                        ? const AutoSizeText(Strings.darkModeDescription)
                        : const AutoSizeText(Strings.lightModeDescription),
                    leading: !themeProvider.getDarkTheme
                        ? const Icon(Icons.light_mode_outlined)
                        : const Icon(Icons.mode_night_outlined),
                    title: const AutoSizeText(Strings.settingsPanelHeader),
                    trailing: Switch.adaptive(
                        value: themeProvider.getDarkTheme,
                        onChanged: (bool val) {
                          themeProvider.setDarkTheme = val;
                        }),
                  ),
                  const Divider()
                ],
              ),
            )
          ]),
    );
  }
}
