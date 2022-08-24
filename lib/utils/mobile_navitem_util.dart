import 'package:flutter/material.dart';
import 'package:nuclear/screens/mobile/mobile_feed.dart';
import 'package:nuclear/screens/mobile/proto_create_recipe.dart';
import 'package:nuclear/screens/shared/settings_responsive.dart';

class NavSwitcher {
  static Widget switchWidgetCases(int cases) {
    switch (cases) {
      case 0:
        {
          return const CreateRecipeView();
        }

      case 1:
        {
          return const MobileFeed();
        }

      case 2:
        {
          return const Preference();
        }
      default:
        return const MobileFeed();
    }
  }
}
