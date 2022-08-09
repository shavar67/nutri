import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/theme/styles.dart';
import 'package:provider/provider.dart';

import '../../../model/theme_provider.dart';
import '../../../utils/spacers.dart';
import '../../constants/strings.dart';

class MobileSettingOptions extends StatefulWidget {
  const MobileSettingOptions({Key? key}) : super(key: key);

  @override
  State<MobileSettingOptions> createState() => _MobileSettingOptionsState();
}

class _MobileSettingOptionsState extends State<MobileSettingOptions> {
  var logger = Logger(printer: PrettyPrinter());

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
            const SizedBox(height: 20),
            SizedBox(
              height: size.height * 0.03,
              child: const FittedBox(
                child: AutoSizeText(
                  Strings.settingsPanelHeader,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
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
