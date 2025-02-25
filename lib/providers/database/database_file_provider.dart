import 'dart:io';

import 'package:mealtime/providers/file_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_file_provider.g.dart';

const String databaseFileName = "mealtime-store.json";

@riverpod
FutureOr<File> databaseFile(Ref ref) async {
  final fileUtils = ref.watch(fileUtilsProvider);
  final file = await fileUtils.openFile(databaseFileName);
  return file;
}
