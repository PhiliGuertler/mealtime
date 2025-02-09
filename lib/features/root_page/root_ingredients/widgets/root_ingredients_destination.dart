import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';

NavigationDestination rootIngredientsDestination(BuildContext context) {
  return NavigationDestination(
    key: const ValueKey('ingredients'),
    icon: const Icon(Icons.egg_outlined),
    selectedIcon: const Icon(Icons.egg_rounded)
        .animate()
        .rotate(begin: 0, end: 2.0 / 6.0)
        .moveY(begin: -10.0, end: 0.0, curve: Curves.bounceOut)
        .scale(end: const Offset(1.5, 1.5))
        .then()
        .scale(end: const Offset(1.0 / 1.5, 1.0 / 1.5)),
    label: AppLocalizations.of(context)!.ingredients,
  );
}
