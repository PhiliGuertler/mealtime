import 'dart:convert';

import 'package:mealtime/models/database_storage.dart';
import 'package:mealtime/models/database.dart';
import 'package:mealtime/providers/database/database_file_provider.dart';
import 'package:mealtime/utils/database_migrator.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

@riverpod
FutureOr<Database> database(Ref ref) async {
  final databaseFile = await ref.watch(databaseFileProvider.future);

  final content = await databaseFile.readAsString();

  if (content.isNotEmpty) {
    final Map<String, dynamic> jsonMap =
        jsonDecode(content) as Map<String, dynamic>;
    return DatabaseMigrator.loadAndMigrateFromJson(jsonMap);
  }
  return const Database(
    ingredients: [],
    recipes: [],
    intolerances: [],
    ingredientCategories: [],
  );
}

@riverpod
DatabaseStorage databaseStorage(Ref ref) => DatabaseStorage(ref: ref);
