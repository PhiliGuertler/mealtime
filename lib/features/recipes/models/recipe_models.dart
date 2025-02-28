import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';
import 'package:mealtime/models/identifiable.dart';

part "recipe_models.freezed.dart";
part "recipe_models.g.dart";

@freezed
class RecipeIngredientQuantityModifier with _$RecipeIngredientQuantityModifier {
  const factory RecipeIngredientQuantityModifier({
    /// The unique identifier of the recipe ingredient quantity.
    required String id,

    /// The localized name of the quantity
    required String name,

    /// The localized abbreviation of the quantity
    required String abbreviation,
  }) = _RecipeIngredientQuantity;
  const RecipeIngredientQuantityModifier._();

  factory RecipeIngredientQuantityModifier.fromJson(
          Map<String, dynamic> json) =>
      _$RecipeIngredientQuantityModifierFromJson(json);

  static RecipeIngredientQuantityModifier milliliters(AppLocalizations l10n) =>
      RecipeIngredientQuantityModifier(
        id: '123e4567-e89b-12d3-a456-426614174000',
        name: l10n.milliliters,
        abbreviation: l10n.millilitersAbbreviation,
      );

  static RecipeIngredientQuantityModifier liters(AppLocalizations l10n) =>
      RecipeIngredientQuantityModifier(
        id: '123e4567-e89b-12d3-a456-426614174001',
        name: l10n.liters,
        abbreviation: l10n.litersAbbreviation,
      );

  static RecipeIngredientQuantityModifier grams(AppLocalizations l10n) =>
      RecipeIngredientQuantityModifier(
        id: '123e4567-e89b-12d3-a456-426614174002',
        name: l10n.grams,
        abbreviation: l10n.gramsAbbreviation,
      );

  static RecipeIngredientQuantityModifier kilograms(AppLocalizations l10n) =>
      RecipeIngredientQuantityModifier(
        id: '123e4567-e89b-12d3-a456-426614174003',
        name: l10n.kilograms,
        abbreviation: l10n.kilogramsAbbreviation,
      );

  static RecipeIngredientQuantityModifier teaspoons(AppLocalizations l10n) =>
      RecipeIngredientQuantityModifier(
        id: '123e4567-e89b-12d3-a456-426614174004',
        name: l10n.teaspoons,
        abbreviation: l10n.teaspoonsAbbreviation,
      );

  static RecipeIngredientQuantityModifier tablespoons(AppLocalizations l10n) =>
      RecipeIngredientQuantityModifier(
        id: '123e4567-e89b-12d3-a456-426614174005',
        name: l10n.tablespoons,
        abbreviation: l10n.tablespoonsAbbreviation,
      );

  static RecipeIngredientQuantityModifier cups(AppLocalizations l10n) =>
      RecipeIngredientQuantityModifier(
        id: '123e4567-e89b-12d3-a456-426614174006',
        name: l10n.cups,
        abbreviation: l10n.cupsAbbreviation,
      );

  static RecipeIngredientQuantityModifier ounces(AppLocalizations l10n) =>
      RecipeIngredientQuantityModifier(
        id: '123e4567-e89b-12d3-a456-426614174007',
        name: l10n.ounces,
        abbreviation: l10n.ouncesAbbreviation,
      );

  static RecipeIngredientQuantityModifier pounds(AppLocalizations l10n) =>
      RecipeIngredientQuantityModifier(
        id: '123e4567-e89b-12d3-a456-426614174008',
        name: l10n.pounds,
        abbreviation: l10n.poundsAbbreviation,
      );

  static RecipeIngredientQuantityModifier pieces(AppLocalizations l10n) =>
      RecipeIngredientQuantityModifier(
        id: '123e4567-e89b-12d3-a456-426614174009',
        name: l10n.pieces,
        abbreviation: l10n.piecesAbbreviation,
      );

  static RecipeIngredientQuantityModifier slices(AppLocalizations l10n) =>
      RecipeIngredientQuantityModifier(
        id: '123e4567-e89b-12d3-a456-426614174010',
        name: l10n.slices,
        abbreviation: l10n.slicesAbbreviation,
      );

  static RecipeIngredientQuantityModifier pinches(AppLocalizations l10n) =>
      RecipeIngredientQuantityModifier(
        id: '123e4567-e89b-12d3-a456-426614174011',
        name: l10n.pinches,
        abbreviation: l10n.pinchesAbbreviation,
      );
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

    /// The name of the recipe.
    required String name,

    /// The description of the recipe.
    @Default("") String description,

    /// The list of ingredients in the recipe.
    required List<RecipeIngredient> ingredients,
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
}
