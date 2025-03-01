import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';
import 'package:mealtime/models/identifiable.dart';
import 'package:json_annotation/json_annotation.dart';

part "recipe_models.freezed.dart";
part "recipe_models.g.dart";

@JsonEnum(valueField: 'name')
enum RecipeIngredientQuantityModifier {
  milliliters(name: "ml"),
  liters(name: "l"),
  grams(name: "g"),
  kilograms(name: "kg"),
  teaspoons(name: "tsp"),
  tablespoons(name: "tbsp"),
  cups(name: "cup"),
  ounces(name: "oz"),
  pounds(name: "lb"),
  pieces(name: "pcs"),
  slices(name: "slices"),
  pinches(name: "pinches");

  final String name;

  const RecipeIngredientQuantityModifier({required this.name});

  String toLocalizedAbbreviation(AppLocalizations l10n) {
    switch (this) {
      case RecipeIngredientQuantityModifier.milliliters:
        return l10n.millilitersAbbreviation;
      case RecipeIngredientQuantityModifier.liters:
        return l10n.litersAbbreviation;
      case RecipeIngredientQuantityModifier.grams:
        return l10n.gramsAbbreviation;
      case RecipeIngredientQuantityModifier.kilograms:
        return l10n.kilogramsAbbreviation;
      case RecipeIngredientQuantityModifier.teaspoons:
        return l10n.teaspoonsAbbreviation;
      case RecipeIngredientQuantityModifier.tablespoons:
        return l10n.tablespoonsAbbreviation;
      case RecipeIngredientQuantityModifier.cups:
        return l10n.cupsAbbreviation;
      case RecipeIngredientQuantityModifier.ounces:
        return l10n.ouncesAbbreviation;
      case RecipeIngredientQuantityModifier.pounds:
        return l10n.poundsAbbreviation;
      case RecipeIngredientQuantityModifier.pieces:
        return l10n.piecesAbbreviation;
      case RecipeIngredientQuantityModifier.slices:
        return l10n.slicesAbbreviation;
      case RecipeIngredientQuantityModifier.pinches:
        return l10n.pinchesAbbreviation;
    }
  }

  String toLocalizedName(AppLocalizations l10n) {
    switch (this) {
      case RecipeIngredientQuantityModifier.milliliters:
        return l10n.milliliters;
      case RecipeIngredientQuantityModifier.liters:
        return l10n.liters;
      case RecipeIngredientQuantityModifier.grams:
        return l10n.grams;
      case RecipeIngredientQuantityModifier.kilograms:
        return l10n.kilograms;
      case RecipeIngredientQuantityModifier.teaspoons:
        return l10n.teaspoons;
      case RecipeIngredientQuantityModifier.tablespoons:
        return l10n.tablespoons;
      case RecipeIngredientQuantityModifier.cups:
        return l10n.cups;
      case RecipeIngredientQuantityModifier.ounces:
        return l10n.ounces;
      case RecipeIngredientQuantityModifier.pounds:
        return l10n.pounds;
      case RecipeIngredientQuantityModifier.pieces:
        return l10n.pieces;
      case RecipeIngredientQuantityModifier.slices:
        return l10n.slices;
      case RecipeIngredientQuantityModifier.pinches:
        return l10n.pinches;
    }
  }
}

@freezed
class RecipeIngredient with _$RecipeIngredient {
  const factory RecipeIngredient({
    /// The unique identifier of the recipe ingredient.
    required String ingredientId,

    /// The quantity of the ingredient required.
    required double quantity,

    /// The modifier for the quantity of the ingredient.
    required RecipeIngredientQuantityModifier quantityModifier,

    /// Notes on this ingredient in this recipe
    String? notes,
  }) = _RecipeIngredient;
  const RecipeIngredient._();

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      _$RecipeIngredientFromJson(json);
}

@freezed
class Recipe with _$Recipe implements Identifiable {
  const factory Recipe({
    /// The unique identifier of the recipe.
    required String id,

    /// Last time the recipe was modified
    required DateTime lastModified,

    /// Last time the recipe was modified
    required DateTime createdAt,

    /// The name of the recipe.
    required String name,

    /// The description of the recipe.
    @Default("") String description,

    /// The list of ingredients in the recipe.
    required List<RecipeIngredient> ingredients,

    /// A list of strings, where each entry is a step of the recipe.
    required List<String> stepDescriptions,

    /// The path to an image of the meal that is created by this recipe
    String? imagePath,

    /// Notes on this recipe
    String? notes,
  }) = _Recipe;
  const Recipe._();

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  @override
  String getId() {
    return id;
  }

  @override
  DateTime getLastModified() {
    return lastModified;
  }

  @override
  DateTime getCreatedAt() {
    return createdAt;
  }
}
