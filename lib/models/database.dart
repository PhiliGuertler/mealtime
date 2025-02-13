import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mealtime/features/ingredients/models/ingredients_models.dart';

part 'database.freezed.dart';
part 'database.g.dart';

@freezed
class Database with _$Database {
  const factory Database({
    required List<Ingredient> ingredients,
  }) = _Database;
  const Database._();

  factory Database.fromJson(Map<String, dynamic> json) =>
      _$DatabaseFromJson(json);

  // ######################################################################## //
  // ### Ingredients ######################################################## //

  /// Updates an ingredient by overwriting it.
  /// If no ingredient with the given id exists, an Exception is thrown.
  Database updateIngredients(String id, Ingredient update) {
    final ingredientIndex =
        ingredients.indexWhere((element) => element.id == id);
    assert(ingredientIndex != -1, "No Game with id '$id' found");

    final List<Ingredient> updatedIngredients = List.from(ingredients);

    updatedIngredients[ingredientIndex] = update;
    return copyWith(ingredients: updatedIngredients);
  }

  /// Removes an ingredient from the list by its id
  /// If no ingredient with the same id exists, an Exception is thrown.
  Database removeIngredient(String id) {
    assert(
      ingredients.indexWhere((element) => element.id == id) != -1,
      "No Ingredient with id '$id' found",
    );

    final List<Ingredient> updatedIngredients = List.from(ingredients);
    updatedIngredients.removeWhere((element) => element.id == id);
    return copyWith(ingredients: updatedIngredients);
  }

  /// Adds an ingredient to the list
  /// If an ingredient with the same id already exists, an Exception is thrown.
  Database addIngredient(Ingredient ingredient) {
    assert(
      ingredients.every((element) => element.id != ingredient.id),
      "Ingredient with id '${ingredient.id}' already exists. Did you mean to update an existing Ingredient?",
    );

    final List<Ingredient> updatedIngredients = List.from(ingredients);
    updatedIngredients.add(ingredient);
    return copyWith(ingredients: updatedIngredients);
  }

  // ######################################################################## //
  // ### Update Database #################################################### //

  /// Updates ingredients that are marked as more recent by their lastModified member.
  /// Games with the same id but with the same lastModified or more recent will not be altered.
  /// If no game matches the id of an input game it won't be added, instead nothing happens.
  Database updateDatabaseByLastModified(Database database) {
    final List<Ingredient> updatedIngredients = List.from(ingredients);

    // update ingredients
    for (int i = 0; i < updatedIngredients.length; ++i) {
      final Ingredient game = updatedIngredients[i];
      final int possibleUpdateIndex =
          database.ingredients.indexWhere((update) => update.id == game.id);
      if (possibleUpdateIndex == -1) continue;
      final Ingredient update = database.ingredients[possibleUpdateIndex];
      if (update.lastModified.compareTo(game.lastModified) > 0) {
        updatedIngredients[i] = update;
      }
    }

    return copyWith(ingredients: updatedIngredients);
  }

  /// Adds missing ingredients to the list.
  /// An ingredient is considered missing if there is no ingredient with the same id yet.
  Database addMissingDatabaseEntries(Database database) {
    Database updatedDatabase = this;

    // update ingredients
    for (int i = 0; i < database.ingredients.length; ++i) {
      final Ingredient possibleNewGame = database.ingredients[i];
      final int index =
          ingredients.indexWhere((element) => element.id == possibleNewGame.id);
      if (index == -1) {
        updatedDatabase = updatedDatabase.addIngredient(possibleNewGame);
      }
    }

    return updatedDatabase;
  }
}
