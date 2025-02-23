import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealtime/initializer.dart';
import 'package:mealtime/receive_share_app.dart';
import 'package:theming/theming.dart';

void main() async {
  final providerContainer = ProviderContainer(
    overrides: [
      defaultAppColorProvider
          .overrideWithValue(const Color.fromRGBO(83, 147, 255, 1)),
    ],
  );

  final Initializer initializer = Initializer();
  initializer.setupInitialization();

  await initializer.initializeApp(providerContainer);

  runApp(
    UncontrolledProviderScope(
      container: providerContainer,
      child: const ReceiveShareApp(),
    ),
  );
}
