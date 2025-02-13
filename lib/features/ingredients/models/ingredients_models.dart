import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';

part 'ingredients_models.freezed.dart';
part 'ingredients_models.g.dart';

enum IngredientCategory {
  alcohol,
  beverage,
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
      case IngredientCategory.beverage:
        return l10n.beverage;
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
    /// Id of the ingredient
    required String id,

    /// last modified timestamp
    required DateTime lastModified,

    /// Name of the ingredient
    /// TODO: Add localizations for default ingredients
    required String name,

    /// Alternative names of the ingredient, e.g. plurals or "E420"
    @Default([]) List<String> aliases,

    /// Categories of the ingredient
    @Default([]) List<IngredientCategory> categories,

    /// Ingredients that make up this ingredient, e.g. "chocolate" is made up of "cocoa" and "sugar"
    /// Will only be set if categories is set to [IngredientCategory.compound]
    @Default([]) List<String> compoundIngredients,
  }) = _Ingredient;

  bool isCompound() {
    return compoundIngredients.isNotEmpty;
  }

  const Ingredient._();

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}
