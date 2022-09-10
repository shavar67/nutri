import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/theme/styles.dart';
import 'package:nuclear/widgets/mobile/switch_navbar_item.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';

class MobileView extends StatefulWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  final GlobalKey _bottomNavigationKey = GlobalKey();
  var logger = Logger(
      printer: PrettyPrinter(
    lineLength: 200,
    printTime: false,
    printEmojis: true,
  ));
  int _selectedIndex = 0;
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  final _titles = ['Home', 'Recipes', 'Settings'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: LiquidPullToRefresh(
          backgroundColor: themeProvider.getDarkTheme
              ? Styles.greyShade900
              : Styles.lightBgColor,
          onRefresh: _onRefresh,
          height: 150,
          springAnimationDurationInMilliseconds: 500,
          animSpeedFactor: 1.0,
          showChildOpacityTransition: false,
          key: _refreshIndicatorKey,
          child: NavSwitcher.switchWidgetCases(_selectedIndex),
          // child: _switchWidgetCases(_selectedIndex),
        ),
        appBar: AppBar(
          leading: null,
          title: AutoSizeText(
            _titles[_selectedIndex],
            style: TextStyle(
                color: themeProvider.getDarkTheme
                    ? Styles.white
                    : Styles.defaultDarkModeBg),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            currentIndex: _selectedIndex,
            unselectedItemColor:
                themeProvider.getDarkTheme ? Styles.white : Colors.grey,
            selectedItemColor: Colors.blue,
            onTap: ((value) {
              setState(() {
                _selectedIndex = value;
              });
              logger.i(_selectedIndex);
            }),
            items: [
              BottomNavigationBarItem(
                  label: _titles[0], icon: const Icon(Icons.home_outlined)),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.menu_book_outlined),
                  label: _titles[1]),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.settings_outlined), label: _titles[2]),
            ]));
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2)).whenComplete(() {
      if (_selectedIndex == 1) {
        EasyLoading.showToast(
            toastPosition: EasyLoadingToastPosition.bottom,
            'refresh complete.');
      }
    });
  }
}
