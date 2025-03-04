import 'dart:io';

import 'package:flutter/services.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'database_file_provider.g.dart';

const String databaseFileName = "mealtime-store.json";

@riverpod
FutureOr<File> databaseFile(Ref ref) async {
  // final fileUtils = ref.watch(fileUtilsProvider);
  // final file = await fileUtils.openFile(databaseFileName);
  // return file;

  final fakeDatabaseFile = await ref.watch(fakeDatabaseFileProvider.future);
  return fakeDatabaseFile;
}

@riverpod
FutureOr<File> fakeDatabaseFile(Ref ref) async {
  final byteData = await rootBundle.load("test_resources/mealtime-store.json");
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/mealtime-store.json');
  await file.writeAsBytes(byteData.buffer.asUint8List());
  return file;
}
