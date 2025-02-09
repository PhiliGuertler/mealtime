import 'package:flutter/material.dart';
import 'package:mealtime/features/root_page/root_ingredients/widgets/root_ingredients_app_bar.dart';
import 'package:mealtime/features/root_page/root_ingredients/widgets/root_ingredients_destination.dart';
import 'package:mealtime/features/root_page/root_settings/widgets/root_settings_app_bar.dart';
import 'package:mealtime/features/root_page/root_settings/widgets/root_settings_destination.dart';

enum RootTabs {
  // recipes,
  ingredients,
  // intolerances,
  settings,
  ;

  PreferredSizeWidget appBar(ScrollController scrollController) {
    switch (this) {
      // case RootTabs.recipes:
      //   return RootGamesAppBar(
      //     scrollController: scrollController,
      //   );
      case RootTabs.ingredients:
        return RootIngredientsAppBar();
      // case RootTabs.intolerances:
      //   return RootIntolerancesAppBar();
      case RootTabs.settings:
        return RootSettingsAppBar();
    }
  }

  Widget? fab(BuildContext context, [bool isExtended = false]) {
    switch (this) {
      // case RootTabs.games:
      // case RootTabs.library:
      //   return RootGamesFab(isExtended: isExtended);
      // case RootTabs.hardware:
      //   return RootHardwareFab(isExtended: isExtended);
      default:
        return null;
    }
  }

  NavigationDestination destination(BuildContext context) {
    switch (this) {
      case RootTabs.ingredients:
        return rootIngredientsDestination(context);
      case RootTabs.settings:
        return rootSettingsDestination(context);
    }
  }

  Widget? drawer(BuildContext context) {
    switch (this) {
      // case RootTabs.ingredients:
      //   return const GameSorterDrawer();
      // case RootTabs.settings:
      //   return const HardwareSorterDrawer();
      default:
        return null;
    }
  }

  Widget? endDrawer(BuildContext context) {
    switch (this) {
      // case RootTabs.games:
      //   return const GameFilterDrawer();
      default:
        return null;
    }
  }

  Widget wrapper(Widget child) {
    return child;
  }
}
