import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';
import 'package:mealtime/models/identifiable.dart';

part "intolerance_models.freezed.dart";
part "intolerance_models.g.dart";

enum IntoleranceReactionSeverity {
  none,
  fineInModeration,
  unpleasant,
  painful,
  dangerous,
  unknown;

  String toLocaleString(AppLocalizations l10n) {
    switch (this) {
      case IntoleranceReactionSeverity.none:
        return l10n.none;
      case IntoleranceReactionSeverity.fineInModeration:
        return l10n.fineInModeration;
      case IntoleranceReactionSeverity.unpleasant:
        return l10n.unpleasant;
      case IntoleranceReactionSeverity.painful:
        return l10n.painful;
      case IntoleranceReactionSeverity.dangerous:
        return l10n.dangerous;
      case IntoleranceReactionSeverity.unknown:
        return l10n.unknown;
    }
  }
}

@freezed
class IngredientReaction with _$IngredientReaction {
  const factory IngredientReaction({
    /// A list of ingredients that cause the intolerance when combined.
    required List<String> ingredientIds,
    required IntoleranceReactionSeverity severity,
  }) = _IngredientReaction;
  const IngredientReaction._();

  factory IngredientReaction.fromJson(Map<String, dynamic> json) =>
      _$IngredientReactionFromJson(json);
}

@freezed
class Intolerance with _$Intolerance implements Identifiable {
  const factory Intolerance({
    /// The unique identifier of the intolerance.
    required String id,

    /// Last time the intolerance was modified
    required DateTime lastModified,

    /// The name of the intolerance.
    required String name,

    /// A list of ingredient reactions that cause the intolerance (or don't).
    required List<IngredientReaction> reactions,

    /// Whether the intolerance is a whitelist or blacklist
    @Default(false) bool isWhitelist,
  }) = _Intolerance;
  const Intolerance._();

  factory Intolerance.fromJson(Map<String, dynamic> json) =>
      _$IntoleranceFromJson(json);

  @override
  String getId() {
    return id;
  }

  @override
  DateTime getLastModified() {
    return lastModified;
  }
}
