import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';
import 'package:mealtime/models/identifiable.dart';

part 'ingredients_models.freezed.dart';
part 'ingredients_models.g.dart';

@freezed
class IngredientCategory with _$IngredientCategory implements Identifiable {
  const factory IngredientCategory({
    /// Id of the category
    required String id,

    /// last modified date
    required DateTime lastModified,

    /// created at date
    required DateTime createdAt,

    /// Name of the category
    required String name,
  }) = _IngredientCategory;
  const IngredientCategory._();

  factory IngredientCategory.fromJson(Map<String, dynamic> json) =>
      _$IngredientCategoryFromJson(json);

  @override
  DateTime getCreatedAt() {
    return createdAt;
  }

  @override
  String getId() {
    return id;
  }

  @override
  DateTime getLastModified() {
    return lastModified;
  }

  // ### Predefined categories ############################################## //

  static IngredientCategory alcohol(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440000',
      name: l10n.alcohol,
      lastModified: now,
      createdAt: now,
    );
  }

  static IngredientCategory beverage(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440001',
      name: l10n.beverage,
      lastModified: now,
      createdAt: now,
    );
  }

  static IngredientCategory dairy(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440002',
      name: l10n.dairy,
      lastModified: now,
      createdAt: now,
    );
  }

  static IngredientCategory cheese(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440042',
      name: l10n.cheese,
      lastModified: now,
      createdAt: now,
    );
  }

  static IngredientCategory fish(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440003',
      name: l10n.fish,
      lastModified: now,
      createdAt: now,
    );
  }

  static IngredientCategory fruit(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440004',
      name: l10n.fruit,
      lastModified: now,
      createdAt: now,
    );
  }

  static IngredientCategory grain(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440005',
      name: l10n.grain,
      lastModified: now,
      createdAt: now,
    );
  }

  static IngredientCategory herb(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440006',
      name: l10n.herb,
      lastModified: now,
      createdAt: now,
    );
  }

  static IngredientCategory meat(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440007',
      name: l10n.meat,
      lastModified: now,
      createdAt: now,
    );
  }

  static IngredientCategory mushroom(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440008',
      name: l10n.mushroom,
      lastModified: now,
      createdAt: now,
    );
  }

  static IngredientCategory nuts(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440009',
      name: l10n.nuts,
      lastModified: now,
      createdAt: now,
    );
  }

  static IngredientCategory oil(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440010',
      name: l10n.oil,
      lastModified: now,
      createdAt: now,
    );
  }

  static IngredientCategory spice(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440011',
      name: l10n.spice,
      lastModified: now,
      createdAt: now,
    );
  }

  static IngredientCategory vegetable(AppLocalizations l10n) {
    final now = DateTime.now();
    return IngredientCategory(
      id: '550e8400-e29b-41d4-a716-446655440012',
      name: l10n.vegetable,
      lastModified: now,
      createdAt: now,
    );
  }
}

@freezed
class Ingredient with _$Ingredient implements Identifiable {
  const factory Ingredient({
    /// Id of the ingredient
    required String id,

    /// last modified timestamp
    required DateTime lastModified,

    /// created at timestamp
    required DateTime createdAt,

    /// Name of the ingredient
    required String name,

    /// Alternative names of the ingredient, e.g. plurals or "E420"
    @Default([]) List<String> aliases,

    /// Categories of the ingredient
    @Default([]) List<String> categoryIds,

    /// Ingredients that make up this ingredient, e.g. "chocolate" is made up of "cocoa" and "sugar"
    /// Will only be set if categories contains IngredientCategory.compound
    @Default([]) List<String> compoundIngredientIds,

    /// Path to an image of the ingredient that can be uploaded if the user wants to
    String? imagePath,

    /// Notes on this ingredient
    String? notes,
  }) = _Ingredient;

  bool isCompound() {
    return compoundIngredientIds.isNotEmpty;
  }

  const Ingredient._();

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

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
