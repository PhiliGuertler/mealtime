import 'package:mealtime/features/ingredients/models/ingredients_models.dart';
import 'package:mealtime/providers/database/database_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ingredients_provider.g.dart';

// ### IngredientCategory ################################################### //

@riverpod
FutureOr<List<IngredientCategory>> ingredientCategories(Ref ref) async {
  final database = await ref.watch(databaseProvider.future);
  return database.ingredientCategories;
}

@riverpod
FutureOr<IngredientCategory> ingredientCategoryById(Ref ref, String id) async {
  final ingredientCategories =
      await ref.watch(ingredientCategoriesProvider.future);

  try {
    return ingredientCategories.singleWhere((element) => element.id == id);
  } catch (error) {
    throw Exception("No ingredient category with id '$id' found");
  }
}

FutureOr<int> ingredientCategoryCount(Ref ref) async {
  final ingredientCategories =
      await ref.watch(ingredientCategoriesProvider.future);

  return ingredientCategories.length;
}

FutureOr<bool> hasIngredientCategories(Ref ref) async {
  final ingredients = await ref.watch(ingredientCategoriesProvider.future);
  return ingredients.isNotEmpty;
}

// ### Ingredient ########################################################### //

@riverpod
FutureOr<List<Ingredient>> ingredients(Ref ref) async {
  final database = await ref.watch(databaseProvider.future);
  return database.ingredients;
}

@riverpod
FutureOr<bool> hasIngredients(Ref ref) async {
  final ingredients = await ref.watch(ingredientsProvider.future);

  return ingredients.isNotEmpty;
}

@riverpod
FutureOr<int> ingredientCount(Ref ref) async {
  final ingredients = await ref.watch(ingredientsProvider.future);

  return ingredients.length;
}

@riverpod
FutureOr<Ingredient> ingredientById(Ref ref, String id) async {
  final ingredients = await ref.watch(ingredientsProvider.future);

  try {
    return ingredients.singleWhere((element) => element.id == id);
  } catch (error) {
    throw Exception("No ingredient with id '$id' found");
  }
}
