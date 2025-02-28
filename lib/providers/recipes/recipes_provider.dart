import 'package:mealtime/features/recipes/models/recipe_models.dart';
import 'package:mealtime/providers/database/database_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipes_provider.g.dart';

@riverpod
FutureOr<List<Recipe>> recipes(Ref ref) async {
  final database = await ref.watch(databaseProvider.future);
  return database.recipes;
}

@riverpod
FutureOr<bool> hasRecipes(Ref ref) async {
  final recipes = await ref.watch(recipesProvider.future);

  return recipes.isNotEmpty;
}

@riverpod
FutureOr<int> recipeCount(Ref ref) async {
  final recipes = await ref.watch(recipesProvider.future);

  return recipes.length;
}

@riverpod
FutureOr<Recipe> recipeById(Ref ref, String id) async {
  final recipes = await ref.watch(recipesProvider.future);

  try {
    return recipes.singleWhere((element) => element.id == id);
  } catch (error) {
    throw Exception("No recipe with id '$id' found");
  }
}
