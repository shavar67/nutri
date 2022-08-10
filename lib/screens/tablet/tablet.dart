import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nuclear/constants/route_constants.dart';
import 'package:nuclear/constants/strings.dart';

class TabletView extends StatefulWidget {
  const TabletView({Key? key}) : super(key: key);

  @override
  State<TabletView> createState() => _TabletViewState();
}

class _TabletViewState extends State<TabletView> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /**
           *TODO: @shavar67 -  implement navigation rail.
    
           */
          NavigationRail(
            selectedIndex: _selectedIndex,
            leading: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: GestureDetector(
                child: const Icon(Icons.settings_outlined),
                onTap: () => Navigator.of(context).pushNamed(settingsRoute),
              ),
            ),
            labelType: NavigationRailLabelType.all,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            destinations: const [
              NavigationRailDestination(
                  icon: Icon(Icons.home_outlined),
                  label: AutoSizeText(Strings.homeTitle)),
              NavigationRailDestination(
                  icon: Icon(Icons.feed_outlined),
                  label: AutoSizeText('Lorem Ipsum')),
            ],
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.05),
              ],
            ),
          ))),
        ],
      ),
    );
  }
}
