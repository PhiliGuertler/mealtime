import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:intl/intl.dart';
import 'package:mealtime/app.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';
import 'package:mealtime/utils/constants.dart';
import 'package:theming/theming.dart';

enum ScreenSizes {
  android(size: Size(1107, 1968), density: 3),
  android7Inch(size: Size(1206, 2144), density: 2),
  android10Inch(size: Size(1449, 2576), density: 2),
  ipadPro(size: Size(2048, 2732), density: 2),
  iphone8(size: Size(1242, 2208), density: 3),
  iphoneXsMax(size: Size(1242, 2688), density: 3),
  ;

  final Size size;
  final double density;

  const ScreenSizes({required this.size, required this.density});
}

class ScreenshotUtils {
  ScreenshotUtils._();

  static Future<void> pumpIt(WidgetTester tester) async {
    // HACK: Seems like a riverpod issue prevents us from running pumpAndSettle without timeouts
    // await tester.pumpAndSettle();
    for (int i = 0; i < 50; ++i) {
      await tester.pump(const Duration(seconds: 1));
    }
  }

  static ThemeData _createThemeData(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        listTileTheme: const ListTileThemeData(
          contentPadding: EdgeInsets.symmetric(horizontal: defaultPaddingX),
        ),
      );

  static Widget _getScreenWrapper({
    required Widget child,
    required AppTheme appTheme,
    required ProviderContainer container,
  }) {
    return UncontrolledProviderScope(
      container: container,
      child: DynamicColorBuilder(
        builder: (_, __) {
          final ColorScheme lightColorScheme =
              appTheme.computeColorScheme(true);
          final ColorScheme darkColorScheme =
              appTheme.computeColorScheme(false);

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: scaffoldMessengerKey,
            theme: _createThemeData(
              lightColorScheme,
            ),
            darkTheme: _createThemeData(
              darkColorScheme,
            ),
            themeMode: appTheme.themeMode,
            localeResolutionCallback:
                (Locale? locale, Iterable<Locale> supportedLocales) {
              if (supportedLocales.any(
                (element) => element.languageCode == locale?.languageCode,
              )) {
                Intl.defaultLocale = locale?.toLanguageTag();
              } else {
                Intl.defaultLocale = "en";
                return const Locale("en");
              }
              return locale;
            },
            localizationsDelegates: const [
              ...AppLocalizations.localizationsDelegates,
            ],
            locale: appTheme.locale != null ? Locale(appTheme.locale!) : null,
            supportedLocales: AppLocalizations.supportedLocales,
            home: child,
          );
        },
      ),
    );
  }

  static Future<void> _takeScreenshot({
    required WidgetTester tester,
    required Widget widget,
    required String pageName,
    required bool isFinal,
    required ScreenSizes size,
    Future<void> Function(WidgetTester tester)? interactBeforeScreenshot,
  }) async {
    await tester.pumpWidgetBuilder(widget);

    await tester.runAsync(() async {
      for (final element in find.byType(Image).evaluate()) {
        final Image widget = element.widget as Image;
        final ImageProvider image = widget.image;
        await precacheImage(image, element);
        await tester.pumpAndSettle();
      }
    });

    await multiScreenGolden(
      tester,
      pageName,
      customPump: (tester) async {
        await interactBeforeScreenshot?.call(tester);
        for (int i = 0; i < 20; ++i) {
          await tester.pump(const Duration(milliseconds: 300));
        }

        await tester.runAsync(() async {
          for (final element in find.byType(Image).evaluate()) {
            final Image widget = element.widget as Image;
            final ImageProvider image = widget.image;
            await precacheImage(image, element);
            await tester.pump(const Duration(milliseconds: 300));
          }
        });
      },
      devices: [
        Device(
          name: isFinal ? "final" : "screen",
          size: size.size / size.density,
          devicePixelRatio: size.density,
        ),
      ],
    );
  }

  static Widget _decorateScreen(
    Widget image,
    String descriptionText,
    AppTheme appTheme,
  ) {
    final ColorScheme colorScheme = appTheme.computeColorScheme(false);

    return Builder(
      builder: (context) {
        final textTheme = Theme.of(context).textTheme;
        return ColoredBox(
          color: colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Text(
                    descriptionText,
                    style: textTheme.headlineMedium
                        ?.copyWith(color: colorScheme.onPrimaryContainer),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: appTheme.themeMode == ThemeMode.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Column(
                        children: [
                          Container(
                            height: 24.0,
                          ),
                          image,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> takeDecoratedScreenshot({
    required WidgetTester tester,
    required Widget screen,
    required String pageName,
    required String description,
    required ScreenSizes screenSize,
    required AppTheme appTheme,
    required ProviderContainer container,
    Future<void> Function(WidgetTester tester)? interactBeforeScreenshot,
  }) async {
    // Enable shadows
    debugDisableShadows = false;
    final concatenatedName =
        "${screenSize.name}-${appTheme.themeMode.name}-${appTheme.locale}-$pageName";

    await _takeScreenshot(
      tester: tester,
      isFinal: false,
      interactBeforeScreenshot: interactBeforeScreenshot,
      widget: _getScreenWrapper(
        child: screen,
        appTheme: appTheme,
        container: container,
      ),
      pageName: concatenatedName,
      size: screenSize,
    );
    final screenFile = File(
      "./test/generate_screenshots/goldens/$concatenatedName.screen.png",
    );
    final memoryImage = MemoryImage(screenFile.readAsBytesSync());
    final image = Image(image: memoryImage);

    await _takeScreenshot(
      tester: tester,
      widget: _decorateScreen(image, description, appTheme),
      pageName: concatenatedName,
      isFinal: true,
      size: screenSize,
    );

    screenFile.deleteSync();
  }
}
