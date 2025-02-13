import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mealtime/features/ingredients/models/ingredients_models.dart';
import 'package:mealtime/models/database.dart';

part 'database_migrator.freezed.dart';
part 'database_migrator.g.dart';

// ### Ingredient ################################################################# //

/// Ingredient
@freezed
class Ingredientv1 with _$Ingredientv1 {
  const factory Ingredientv1({
    required String id,
    required DateTime lastModified,
    required String name,
    required List<String> aliases,
    required List<IngredientCategory> categories,
    required List<String> compoundIngredients,
  }) = _Ingredientv1;
  const Ingredientv1._();

  factory Ingredientv1.fromJson(Map<String, dynamic> json) =>
      _$Ingredientv1FromJson(json);

  Ingredient migrate() {
    return Ingredient(
      id: id,
      lastModified: lastModified,
      name: name,
      aliases: aliases,
      categories: categories,
      compoundIngredients: compoundIngredients,
    );
  }
}

// ### Database ############################################################# //

/// Database with Gamev2 (before App-Version 1.3.0)
@freezed
class Databasev1 with _$Databasev1 {
  const factory Databasev1({
    required List<Ingredientv1> ingredients,
  }) = _Databasev1;
  const Databasev1._();

  factory Databasev1.fromJson(Map<String, dynamic> json) =>
      _$Databasev1FromJson(json);

  Database migrate() {
    final List<Ingredient> ingredients =
        this.ingredients.map((ingredient) => ingredient.migrate()).toList();

    return Database(ingredients: ingredients);
  }
}

/// Migrates the database
class DatabaseMigrator {
  const DatabaseMigrator._();

  static Database loadAndMigrateFromJson(Map<String, dynamic> jsonMap) {
    // ### Migration steps in reverse order ################################# //
    Database? result;
    Databasev1? databasev1;

    // Attempt to deserialize from newest to oldest
    try {
      databasev1 = Databasev1.fromJson(jsonMap);
    } catch (error) {
      // fall through
    }

    // Migrate from oldest to newest
    if (databasev1 != null) {
      result = databasev1.migrate();
    }

    // Throw an exception if loading failed
    if (result == null) {
      throw Exception("Failed to load database");
    }

    return result;
  }
}
