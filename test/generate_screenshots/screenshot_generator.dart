import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mealtime/features/root_page/root_page.dart';
import 'package:mealtime/providers/database/database_file_provider.dart';
import 'package:mealtime/providers/file_provider.dart';
import 'package:misc_utils/misc_utils.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:theming/theming.dart';

@GenerateNiceMocks([MockSpec<FileUtils>(), MockSpec<File>()])
import 'screenshot_generator.mocks.dart';
import 'screenshot_utils.dart';

const Color appColor = Color(0xFF5393FF);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late MockFileUtils mockFileUtils;

  const screenSizes = [
    ScreenSizes.android,
    ScreenSizes.android7Inch,
    ScreenSizes.android10Inch,
  ];
  const themeModes = [
    ThemeMode.dark,
    ThemeMode.light,
  ];

  setUp(() {
    mockFileUtils = MockFileUtils();

    container = ProviderContainer(
      overrides: [
        fileUtilsProvider.overrideWithValue(mockFileUtils),
      ],
    );

    when(mockFileUtils.openFile(databaseFileName)).thenAnswer(
      (realInvocation) async => File('test_resources/mealtime-store.json'),
    );
  });

  testGoldens("Recipes Screen", (tester) async {
    const String pageName = "recipes_screen";

    const languages = {
      "de": "Füge Deine Rezepte hinzu",
      "en": "Add your recipes",
    };

    for (final language in languages.entries) {
      for (final themeMode in themeModes) {
        for (final screenSize in screenSizes) {
          await ScreenshotUtils.takeDecoratedScreenshot(
            tester: tester,
            pageName: pageName,
            screen: const RootPage(),
            screenSize: screenSize,
            appTheme: AppTheme(
              locale: language.key,
              themeMode: themeMode,
              primaryColor: appColor,
            ),
            description: language.value,
            container: container,
            interactBeforeScreenshot: (tester) async {
              await ScreenshotUtils.pumpIt(tester);
            },
          );
        }
      }
    }
  });
  testGoldens("Settings Screen", (tester) async {
    const String pageName = "settings_screen";

    const languages = {
      "de": "Tobe dich in den Einstellungen aus",
      "en": "Configure everything to your likings",
    };

    for (final language in languages.entries) {
      for (final themeMode in themeModes) {
        for (final screenSize in screenSizes) {
          await ScreenshotUtils.takeDecoratedScreenshot(
            tester: tester,
            pageName: pageName,
            screen: const RootPage(),
            screenSize: screenSize,
            appTheme: AppTheme(
              locale: language.key,
              themeMode: themeMode,
              primaryColor: appColor,
            ),
            description: language.value,
            container: container,
            interactBeforeScreenshot: (tester) async {
              await ScreenshotUtils.pumpIt(tester);
              await tester.tap(find.byKey(const ValueKey("root_settings")));
              await ScreenshotUtils.pumpIt(tester);
              {
                // scroll down a bit
                final gesture = await tester.startGesture(
                  const Offset(0, 300),
                ); //Position of the scrollview
                await gesture
                    .moveBy(const Offset(0, -50)); //How much to scroll by
                await ScreenshotUtils.pumpIt(tester);
              }
              {
                final gesture = await tester.startGesture(
                  const Offset(0, 300),
                ); //Position of the scrollview
                await gesture
                    .moveBy(const Offset(0, 50)); //How much to scroll by
                await ScreenshotUtils.pumpIt(tester);
              }
              await ScreenshotUtils.pumpIt(tester);
            },
          );
        }
      }
    }
  });
}
