import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nuclear/constants/route_constants.dart';
import 'package:nuclear/theme/styles.dart';
import 'package:provider/provider.dart';

import '../../../utils/spacers.dart';
import '../../constants/strings.dart';
import '../../firebase_auth/auth_service..dart';
import '../../provider/theme_provider.dart';

class MobileSettingOptions extends StatelessWidget {
  const MobileSettingOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    final auth = context.watch<AuthService>();

    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: KSpacers.space12, horizontal: KSpacers.space12 * 2),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AutoSizeText(Strings.accountPanelHeader,
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Container(
              width: size.width * 90,
              height: size.height * 0.10,
              decoration: BoxDecoration(
                  color: themeProvider.getDarkTheme
                      ? Styles.greyShade900
                      : Styles.white,
                  borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                title: const Text('Account Status'),
                leading: CircleAvatar(
                  child: Text(
                      auth.currentUser?.uid.substring(0, 2).toUpperCase() ??
                          ''),
                ),
                subtitle: Row(children: const [
                  Text('Active'),
                  SizedBox(width: 10),
                  CircleAvatar(radius: 6, backgroundColor: Colors.green)
                ]),
                trailing: GestureDetector(
                  child: const Icon(Icons.logout_outlined),
                  onTap: () {
                    auth.signOut();
                    /**
                     * !! hmm, shouldn't have to call this method explicitly.
                     * 
                     */
                    Navigator.of(context).popAndPushNamed(authRoute);
                  },
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 20),
            const AutoSizeText(
              Strings.settingsPanelHeader,
              style: TextStyle(fontWeight: FontWeight.bold),
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
                    leading: CircleAvatar(
                      child: !themeProvider.getDarkTheme
                          ? const Icon(Icons.light_mode_outlined)
                          : const Icon(Icons.mode_night_outlined),
                    ),
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
