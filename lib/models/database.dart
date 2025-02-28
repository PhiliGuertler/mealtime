import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mealtime/features/ingredients/models/ingredients_models.dart';
import 'package:mealtime/features/intolerances/models/intolerance_models.dart';
import 'package:mealtime/features/recipes/models/recipe_models.dart';
import 'package:mealtime/models/identifiable.dart';

part 'database.freezed.dart';
part 'database.g.dart';

List<T> removeItem<T extends Identifiable>(String id, List<T> original) {
  assert(
    original.indexWhere((element) => element.getId() == id) != -1,
    "No item with id '$id' found",
  );

  final List<T> updated = List.from(original);
  updated.removeWhere((element) => element.getId() == id);
  return updated;
}

List<T> updateItem<T extends Identifiable>(
    String id, T update, List<T> original) {
  final itemIndex = original.indexWhere((element) => element.getId() == id);
  assert(itemIndex != -1, "No item with id '$id' found");

  final List<T> updated = List.from(original);

  updated[itemIndex] = update;
  return updated;
}

List<T> addItem<T extends Identifiable>(T item, List<T> original) {
  assert(
    original.every((element) => element.getId() != item.getId()),
    "Item with id '${item.getId()}' already exists. Did you mean to update an existing item?",
  );

  final List<T> updated = List.from(original);
  updated.add(item);
  return updated;
}

List<T> updateByLastModified<T extends Identifiable>(
    List<T> toBeUpdated, List<T> input) {
  final List<T> updated = List.from(toBeUpdated);

  for (int i = 0; i < updated.length; ++i) {
    final T item = updated[i];
    final int possibleUpdateIndex =
        input.indexWhere((update) => update.getId() == item.getId());
    if (possibleUpdateIndex == -1) continue;
    final T update = input[possibleUpdateIndex];
    if (update.getLastModified().compareTo(item.getLastModified()) > 0) {
      updated[i] = update;
    }
  }

  return updated;
}

void addMissingItems<T extends Identifiable>(
    List<T> toBeUpdated, List<T> input, void Function(T) addItem) {
  for (int i = 0; i < input.length; ++i) {
    final T possibleNewItem = input[i];
    final int index = toBeUpdated
        .indexWhere((element) => element.getId() == possibleNewItem.getId());
    if (index == -1) {
      addItem(possibleNewItem);
    }
  }
}

@freezed
class Database with _$Database {
  const factory Database({
    required List<Ingredient> ingredients,
    required List<Intolerance> intolerances,
    required List<Recipe> recipes,
  }) = _Database;
  const Database._();

  factory Database.fromJson(Map<String, dynamic> json) =>
      _$DatabaseFromJson(json);

  // ######################################################################## //
  // ### Ingredients ######################################################## //

  /// Updates an ingredient by overwriting it.
  /// If no ingredient with the given id exists, an Exception is thrown.
  Database updateIngredients(String id, Ingredient update) {
    return copyWith(ingredients: updateItem(id, update, ingredients));
  }

  /// Removes an ingredient from the list by its id
  /// If no ingredient with the same id exists, an Exception is thrown.
  Database removeIngredient(String id) {
    return copyWith(ingredients: removeItem(id, ingredients));
  }

  /// Adds an ingredient to the list
  /// If an ingredient with the same id already exists, an Exception is thrown.
  Database addIngredient(Ingredient ingredient) {
    return copyWith(ingredients: addItem(ingredient, ingredients));
  }

  // ######################################################################## //
  // ### Intolerances ####################################################### //

  /// Updates an intolerance by overwriting it.
  /// If no intolerance with the given id exists, an Exception is thrown.
  Database updateIntolerance(String id, Intolerance update) {
    return copyWith(intolerances: updateItem(id, update, intolerances));
  }

  /// Removes an intolerance from the list by its id
  /// If no intolerance with the same id exists, an Exception is thrown.
  Database removeIntolerance(String id) {
    return copyWith(intolerances: removeItem(id, intolerances));
  }

  /// Adds an intolerance to the list
  /// If an intolerance with the same id already exists, an Exception is thrown.
  Database addIntolerance(Intolerance intolerance) {
    return copyWith(intolerances: addItem(intolerance, intolerances));
  }

  // ######################################################################## //
  // ### Recipes ############################################################ //

  /// Updates a recipe by overwriting it.
  /// If no recipe with the given id exists, an Exception is thrown.
  Database updateRecipe(String id, Recipe update) {
    return copyWith(recipes: updateItem(id, update, recipes));
  }

  /// Removes a recipe from the list by its id
  /// If no recipe with the same id exists, an Exception is thrown.
  Database removeRecipe(String id) {
    return copyWith(recipes: removeItem(id, recipes));
  }

  /// Adds a recipe to the list
  /// If a recipe with the same id already exists, an Exception is thrown.
  Database addRecipe(Recipe recipe) {
    return copyWith(recipes: addItem(recipe, recipes));
  }

  // ######################################################################## //
  // ### Update Database #################################################### //

  /// Updates ingredients, intolerances and recipes that are marked as more recent by their lastModified member.
  /// Items with the same id but with the same lastModified or more recent will not be altered.
  /// If no item matches the id of an input item it won't be added, instead nothing happens.
  Database updateDatabaseByLastModified(Database database) {
    return copyWith(
      ingredients: updateByLastModified(ingredients, database.ingredients),
      intolerances: updateByLastModified(intolerances, database.intolerances),
      recipes: updateByLastModified(recipes, database.recipes),
    );
  }

  /// Adds missing ingredients to the list.
  /// An ingredient is considered missing if there is no ingredient with the same id yet.
  Database addMissingDatabaseEntries(Database database) {
    Database updatedDatabase = this;

    addMissingItems(ingredients, database.ingredients,
        (item) => updatedDatabase.addIngredient(item));
    addMissingItems(intolerances, database.intolerances,
        (item) => updatedDatabase.addIntolerance(item));
    addMissingItems(
        recipes, database.recipes, (item) => updatedDatabase.addRecipe(item));

    return updatedDatabase;
  }
}
