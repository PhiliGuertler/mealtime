import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealtime/features/ingredients/models/ingredients_models.dart';
import 'package:mealtime/providers/ingredients/ingredients_provider.dart';
import 'package:misc_utils/misc_utils.dart';

class IngredientDisplay extends ConsumerWidget {
  final Ingredient ingredient;

  const IngredientDisplay({super.key, required this.ingredient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ingredientCategories =
        ref.watch(ingredientCategoriesOfIngredientProvider(ingredient.id));

    return ListTile(
      title: Text(ingredient.name),
      subtitle: ingredientCategories.when(data: (categories) {
        return Wrap(
          spacing: 4.0,
          direction: Axis.horizontal,
          children: categories
              .map((category) => Chip(
                    label: Text(category.name),
                  ))
              .toList(),
        );
      }, error: (error, stackTrace) {
        return Text(error.toString());
      }, loading: () {
        return Skeleton(
          widthFactor: 0.3,
        );
      }),
    );
  }
}
