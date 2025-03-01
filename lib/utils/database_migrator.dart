import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mealtime/features/ingredients/models/ingredients_models.dart';
import 'package:mealtime/features/intolerances/models/intolerance_models.dart';
import 'package:mealtime/features/recipes/models/recipe_models.dart';
import 'package:mealtime/models/database.dart';

part 'database_migrator.freezed.dart';
part 'database_migrator.g.dart';

// ### Ingredient ################################################################# //

@freezed
class IngredientCategoryv1 with _$IngredientCategoryv1 {
  const factory IngredientCategoryv1({
    required String id,
    required String name,
    required DateTime lastModified,
    required DateTime createdAt,
  }) = _IngredientCategoryv1;

  factory IngredientCategoryv1.fromJson(Map<String, dynamic> json) =>
      _$IngredientCategoryv1FromJson(json);

  IngredientCategory migrate() {
    return IngredientCategory(
      id: id,
      name: name,
      lastModified: lastModified,
      createdAt: createdAt,
    );
  }
}

/// Ingredient
@freezed
class Ingredientv1 with _$Ingredientv1 {
  const factory Ingredientv1({
    required String id,
    required DateTime lastModified,
    required DateTime createdAt,
    required String name,
    required List<String> aliases,
    required List<String> categoryIds,
    required List<String> compoundIngredientIds,
    required String? imagePath,
    required String? notes,
  }) = _Ingredientv1;
  const Ingredientv1._();

  factory Ingredientv1.fromJson(Map<String, dynamic> json) =>
      _$Ingredientv1FromJson(json);

  Ingredient migrate() {
    return Ingredient(
      id: id,
      lastModified: lastModified,
      createdAt: createdAt,
      name: name,
      aliases: aliases,
      categoryIds: categoryIds,
      compoundIngredientIds: compoundIngredientIds,
      imagePath: imagePath,
      notes: notes,
    );
  }
}

// ### Intolerance ########################################################## //

@freezed
class IngredientReactionv1 with _$IngredientReactionv1 {
  const factory IngredientReactionv1({
    required List<String> ingredientIds,
    required IntoleranceReactionSeverity severity,
  }) = _IngredientReactionv1;
  const IngredientReactionv1._();

  factory IngredientReactionv1.fromJson(Map<String, dynamic> json) =>
      _$IngredientReactionv1FromJson(json);

  IngredientReaction migrate() {
    return IngredientReaction(
      ingredientIds: ingredientIds,
      severity: severity,
    );
  }
}

@freezed
class Intolerancev1 with _$Intolerancev1 {
  const factory Intolerancev1({
    required String id,
    required DateTime lastModified,
    required DateTime createdAt,
    required String name,
    required List<IngredientReactionv1> reactions,
    required bool isWhitelist,
    required String? notes,
  }) = _Intolerancev1;
  const Intolerancev1._();

  factory Intolerancev1.fromJson(Map<String, dynamic> json) =>
      _$Intolerancev1FromJson(json);

  Intolerance migrate() {
    return Intolerance(
      id: id,
      lastModified: lastModified,
      createdAt: createdAt,
      name: name,
      reactions: reactions.map((reaction) => reaction.migrate()).toList(),
      isWhitelist: isWhitelist,
      notes: notes,
    );
  }
}

// ### Recipe ############################################################### //

@freezed
class RecipeIngredientv1 with _$RecipeIngredientv1 {
  const factory RecipeIngredientv1({
    required String ingredientId,
    required double quantity,
    required RecipeIngredientQuantityModifier quantityModifier,
  }) = _RecipeIngredientv1;
  const RecipeIngredientv1._();

  factory RecipeIngredientv1.fromJson(Map<String, dynamic> json) =>
      _$RecipeIngredientv1FromJson(json);

  RecipeIngredient migrate() {
    return RecipeIngredient(
        ingredientId: ingredientId,
        quantity: quantity,
        quantityModifier: quantityModifier);
  }
}

@freezed
class Recipev1 with _$Recipev1 {
  const factory Recipev1({
    required String id,
    required DateTime lastModified,
    required DateTime createdAt,
    required String name,
    required String description,
    required List<RecipeIngredientv1> ingredients,
    required List<String> stepDescriptions,
    required String? imagePath,
    required String? notes,
  }) = _Recipev1;
  const Recipev1._();

  factory Recipev1.fromJson(Map<String, dynamic> json) =>
      _$Recipev1FromJson(json);

  Recipe migrate() {
    return Recipe(
      id: id,
      lastModified: lastModified,
      createdAt: createdAt,
      name: name,
      description: description,
      ingredients:
          ingredients.map((ingredient) => ingredient.migrate()).toList(),
      stepDescriptions: stepDescriptions,
      imagePath: imagePath,
      notes: notes,
    );
  }
}

// ### Database ############################################################# //

/// Database with Gamev2 (before App-Version 1.3.0)
@freezed
class Databasev1 with _$Databasev1 {
  const factory Databasev1({
    required List<IngredientCategoryv1> ingredientCategories,
    required List<Ingredientv1> ingredients,
    required List<Intolerancev1> intolerances,
    required List<Recipev1> recipes,
  }) = _Databasev1;
  const Databasev1._();

  factory Databasev1.fromJson(Map<String, dynamic> json) =>
      _$Databasev1FromJson(json);

  Database migrate() {
    final List<IngredientCategory> ingredientCategories = this
        .ingredientCategories
        .map((category) => category.migrate())
        .toList();

    final List<Ingredient> ingredients =
        this.ingredients.map((ingredient) => ingredient.migrate()).toList();

    final List<Intolerance> intolerances =
        this.intolerances.map((intolerance) => intolerance.migrate()).toList();

    final List<Recipe> recipes =
        this.recipes.map((recipe) => recipe.migrate()).toList();

    return Database(
      ingredientCategories: ingredientCategories,
      ingredients: ingredients,
      intolerances: intolerances,
      recipes: recipes,
    );
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
