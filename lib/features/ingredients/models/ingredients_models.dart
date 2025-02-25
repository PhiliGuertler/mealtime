import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';

part 'ingredients_models.freezed.dart';
part 'ingredients_models.g.dart';

@freezed
class IngredientCategory with _$IngredientCategory {
  const factory IngredientCategory({
    required String id,
    required String name,
  }) = _IngredientCategory;

  factory IngredientCategory.fromJson(Map<String, dynamic> json) =>
      _$IngredientCategoryFromJson(json);

  // ### Predefined categories ############################################## //

  static IngredientCategory alcohol(AppLocalizations l10n) =>
      IngredientCategory(
        id: '550e8400-e29b-41d4-a716-446655440000',
        name: l10n.alcohol,
      );

  static IngredientCategory beverage(AppLocalizations l10n) =>
      IngredientCategory(
        id: '550e8400-e29b-41d4-a716-446655440001',
        name: l10n.beverage,
      );

  static IngredientCategory dairy(AppLocalizations l10n) => IngredientCategory(
        id: '550e8400-e29b-41d4-a716-446655440002',
        name: l10n.dairy,
      );

  static IngredientCategory fish(AppLocalizations l10n) => IngredientCategory(
        id: '550e8400-e29b-41d4-a716-446655440003',
        name: l10n.fish,
      );

  static IngredientCategory fruit(AppLocalizations l10n) => IngredientCategory(
        id: '550e8400-e29b-41d4-a716-446655440004',
        name: l10n.fruit,
      );

  static IngredientCategory grain(AppLocalizations l10n) => IngredientCategory(
        id: '550e8400-e29b-41d4-a716-446655440005',
        name: l10n.grain,
      );

  static IngredientCategory herb(AppLocalizations l10n) => IngredientCategory(
        id: '550e8400-e29b-41d4-a716-446655440006',
        name: l10n.herb,
      );

  static IngredientCategory meat(AppLocalizations l10n) => IngredientCategory(
        id: '550e8400-e29b-41d4-a716-446655440007',
        name: l10n.meat,
      );

  static IngredientCategory mushroom(AppLocalizations l10n) =>
      IngredientCategory(
        id: '550e8400-e29b-41d4-a716-446655440008',
        name: l10n.mushroom,
      );

  static IngredientCategory nuts(AppLocalizations l10n) => IngredientCategory(
        id: '550e8400-e29b-41d4-a716-446655440009',
        name: l10n.nuts,
      );

  static IngredientCategory oil(AppLocalizations l10n) => IngredientCategory(
        id: '550e8400-e29b-41d4-a716-446655440010',
        name: l10n.oil,
      );

  static IngredientCategory spice(AppLocalizations l10n) => IngredientCategory(
        id: '550e8400-e29b-41d4-a716-446655440011',
        name: l10n.spice,
      );

  static IngredientCategory vegetable(AppLocalizations l10n) =>
      IngredientCategory(
        id: '550e8400-e29b-41d4-a716-446655440012',
        name: l10n.vegetable,
      );
}

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    /// Id of the ingredient
    required String id,

    /// last modified timestamp
    required DateTime lastModified,

    /// Name of the ingredient
    required String name,

    /// Alternative names of the ingredient, e.g. plurals or "E420"
    @Default([]) List<String> aliases,

    /// Categories of the ingredient
    @Default([]) List<IngredientCategory> categories,

    /// Ingredients that make up this ingredient, e.g. "chocolate" is made up of "cocoa" and "sugar"
    /// Will only be set if categories contains IngredientCategory.compound
    @Default([]) List<String> compoundIngredients,
  }) = _Ingredient;

  bool isCompound() {
    return compoundIngredients.isNotEmpty;
  }

  const Ingredient._();

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}
