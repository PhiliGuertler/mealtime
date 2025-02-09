import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';

part 'ingredients_models.freezed.dart';

enum IngredientCategory {
  alcohol,
  dairy,
  fish,
  fruit,
  grain,
  herb,
  meat,
  mushroom,
  nuts,
  oil,
  other,
  spice,
  vegetable;

  String toLocaleString(AppLocalizations l10n) {
    switch (this) {
      case IngredientCategory.alcohol:
        return l10n.alcohol;
      case IngredientCategory.dairy:
        return l10n.dairy;
      case IngredientCategory.fish:
        return l10n.fish;
      case IngredientCategory.fruit:
        return l10n.fruit;
      case IngredientCategory.grain:
        return l10n.grain;
      case IngredientCategory.herb:
        return l10n.herb;
      case IngredientCategory.meat:
        return l10n.meat;
      case IngredientCategory.mushroom:
        return l10n.mushroom;
      case IngredientCategory.nuts:
        return l10n.nuts;
      case IngredientCategory.oil:
        return l10n.oil;
      case IngredientCategory.other:
        return l10n.other;
      case IngredientCategory.spice:
        return l10n.spice;
      case IngredientCategory.vegetable:
        return l10n.vegetable;
    }
  }
}

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    required String name,
    @Default([]) List<String> aliases,
    @Default([]) List<IngredientCategory> categories,
  }) = _Ingredient;
  const Ingredient._();
}
