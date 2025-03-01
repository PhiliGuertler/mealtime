import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealtime/extensions/locale_extensions.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';
import 'package:mealtime/widgets/app_scaffold.dart';
import 'package:theming/theming.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.language),
      ),
      body: SingleChildScrollView(
        child: LanguageSelectionRadioGroup(
          supportedLocales: AppLocalizations.supportedLocales,
          localeToImage: (locale) => Center(
            child: Text(
              locale.countryAssetEmoji(),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          localeToName: (locale) => locale.fullName(),
          systemLanguageLabel: AppLocalizations.of(context)!.systemLanguage,
        ),
      ),
    );
  }
}
