import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealtime/features/settings/about/screens/about_screen.dart';
import 'package:mealtime/features/settings/appearance/screens/appearance_screen.dart';
import 'package:mealtime/features/settings/language/screens/language_screen.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';
import 'package:mealtime/models/assets.dart';
import 'package:mealtime/providers/debug_provider.dart';
import 'package:mealtime/utils/constants.dart';
import 'package:misc_utils/misc_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends ConsumerWidget {
  final ScrollController scrollController;

  const SettingsScreen({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDebugMode = ref.watch(debugFeatureAccessProvider);

    final errorContainer = Theme.of(context).colorScheme.errorContainer;
    final onErrorContainer = Theme.of(context).colorScheme.onErrorContainer;

    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: scrollController,
        slivers: [
          SliverFancyImageHeader(
            imagePath: ImageAssets.settings.value,
            height: 250,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                top: 24.0,
                bottom: 8.0,
              ),
              child: Text(
                AppLocalizations.of(context)!.appSettings,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SegmentedActionCard(
              isDebugMode: isDebugMode,
              items: [
                SegmentedActionCardItem(
                  leading: const Icon(Icons.dark_mode),
                  title: Text(AppLocalizations.of(context)!.appearance),
                  subtitle:
                      Text(AppLocalizations.of(context)!.comeToTheDarkSide),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AppearanceScreen(),
                      ),
                    );
                  },
                ),
                SegmentedActionCardItem(
                  leading: const Icon(Icons.translate),
                  title: Text(AppLocalizations.of(context)!.language),
                  subtitle:
                      Text(AppLocalizations.of(context)!.languageSubtitle),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LanguageScreen(),
                      ),
                    );
                  },
                ),
                SegmentedActionCardItem(
                  leading: const Icon(Icons.info),
                  title: Text(AppLocalizations.of(context)!.aboutThisApp),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AboutScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                top: 24.0,
                bottom: 8.0,
              ),
              child: Text(
                AppLocalizations.of(context)!.importExport,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SegmentedActionCard(
              isDebugMode: isDebugMode,
              items: [
                SegmentedActionCardItem.debug(
                  leading: const Icon(Icons.engineering),
                  title: const Text("Debug-Menu"),
                  subtitle: const Text("This is where the magic happens"),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Placeholder(),
                      ),
                    );
                  },
                ),
                SegmentedActionCardItem(
                  leading: const Icon(Icons.file_download),
                  title: Text(AppLocalizations.of(context)!.importDatabase),
                  subtitle: Text(
                    AppLocalizations.of(context)!.importDatabaseFromAJSONFile,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Placeholder(),
                      ),
                    );
                  },
                ),
                SegmentedActionCardItem(
                  leading: const Icon(Icons.file_upload),
                  title: Text(AppLocalizations.of(context)!.exportDatabase),
                  subtitle: Text(
                    AppLocalizations.of(context)!.exportDatabaseToAJSONFile,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const Placeholder(),
                      ),
                    );
                  },
                ),
                SegmentedActionCardItem(
                  leading: Icon(
                    Icons.delete_forever,
                    color: onErrorContainer,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.deleteDatabase,
                    style: TextStyle(color: onErrorContainer),
                  ),
                  trailing: Icon(
                    Icons.warning,
                    color: onErrorContainer,
                  ),
                  tileColor: errorContainer,
                  subtitle: Text(
                    AppLocalizations.of(context)!.thisActionCannotBeUndone,
                    style: TextStyle(color: onErrorContainer),
                  ),
                  onTap: () async {
                    final bool? response = await showAdaptiveDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog.adaptive(
                        title: Text(
                          AppLocalizations.of(context)!
                              .deleteAllGamesAndHardware,
                        ),
                        content: Text(
                          AppLocalizations.of(context)!
                              .thisActionCannotBeUndone,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text(AppLocalizations.of(context)!.cancel),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: Text(AppLocalizations.of(context)!.yes),
                          ),
                        ],
                      ),
                    );
                    // if (response != null && response) {
                    //   final databaseStorage = ref.read(databaseStorageProvider);
                    //   databaseStorage.persistDatabase(
                    //     const Database(games: [], hardware: []),
                    //   );

                    //   if (context.mounted) {
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         content: Text(
                    //           AppLocalizations.of(context)!.allGamesDeleted,
                    //         ),
                    //       ),
                    //     );
                    //   }
                    // }
                  },
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(defaultPaddingX),
                child: DebugSecretCodeInput(
                  secretCode: const [MorseCode.p, MorseCode.s],
                  onSecretEnteredCorrectly: () {
                    final newDebugState = ref
                        .read(debugFeatureAccessProvider.notifier)
                        .toggleDebugMode();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Developer mode is now $newDebugState"),
                      ),
                    );
                  },
                  child: FutureBuilder(
                    future: PackageInfo.fromPlatform(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          'App-Version: ${snapshot.data!.version} (${snapshot.data!.buildNumber})',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.5),
                          ),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
