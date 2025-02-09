import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';

class RootIngredientsAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  final preferredSizeAppBar = AppBar();

  RootIngredientsAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.ingredients),
    );
  }

  @override
  Size get preferredSize => preferredSizeAppBar.preferredSize;
}
