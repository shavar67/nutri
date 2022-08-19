import 'package:flutter/material.dart';
import 'package:nuclear/screens/mobile/mobile_feed.dart';

class NavSwitcher {
  static Widget switchWidgetCases(int cases) {
    switch (cases) {
      case 0:
        {
          return const MobileFeed();
        }

      case 1:
        {
          return Container(
            child: const Center(
              child: Text('Discovery new recipes'),
            ),
          );
        }

      case 2:
        {
          return Container(
              child: const Center(
            child: Text('No favorite recipes at the moment.'),
          ));
        }

      default:
        return const MobileFeed();
    }
  }
}
