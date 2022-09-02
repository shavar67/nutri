import 'package:flutter/material.dart';
import 'package:nuclear/screens/mobile/shimmer_loading_indicator.dart';
import 'package:nuclear/screens/shared/settings_responsive.dart';
import 'package:nuclear/widgets/mobile/recipe_input.dart';

class NavSwitcher {
  static Widget switchWidgetCases(int cases) {
    switch (cases) {
      case 0:
        {
          return const RecipeForm();
        }

      case 1:
        {
          return const ShimmerLoadingIndicator();
        }

      case 2:
        {
          return const Preference();
        }
      default:
        return const ShimmerLoadingIndicator();
    }
  }
}
