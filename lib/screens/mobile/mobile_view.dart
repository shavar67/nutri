import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:logger/logger.dart';
import 'package:nuclear/provider/recipe_provider.dart';
import 'package:nuclear/theme/styles.dart';
import 'package:nuclear/utils/mobile_navitem_util.dart';
import 'package:provider/provider.dart';

import '../../constants/route_constants.dart';
import '../../model/theme_provider.dart';

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
  final _titles = [
    'Home',
    'Discover',
    'Recipes',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final recipeProvder = context.read<RecipeProvider>();
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                child: Icon(Icons.menu_open_sharp,
                    color: themeProvider.getDarkTheme
                        ? Styles.white
                        : Styles.defaultDarkModeBg),
                onTap: () async {
                  await Navigator.of(context).pushNamed(settingsRoute);
                },
              ),
            )
          ]),
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
                label: _titles[0], icon: const Icon(Icons.home)),
            BottomNavigationBarItem(
                icon: const Icon(Icons.explore_outlined), label: _titles[1]),
            BottomNavigationBarItem(
                icon: const Icon(Icons.menu_book_sharp), label: _titles[2]),
          ]),
      floatingActionButton: FloatingActionButton(
          backgroundColor:
              themeProvider.getDarkTheme ? Styles.greyShade900 : Styles.white,
          onPressed: () async {
            await recipeProvder.getRecipe('chicken');
          },
          child: Icon(
            Icons.add,
            color: themeProvider.getDarkTheme
                ? Styles.defaultIconColor
                : Colors.green,
          )),
    );
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 2))
        .whenComplete(() => logger.i('done'));
  }
}
