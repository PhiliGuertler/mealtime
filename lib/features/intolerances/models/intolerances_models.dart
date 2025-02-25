import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mealtime/l10n/generated/app_localizations.dart';

part 'intolerances_models.freezed.dart';
part 'intolerances_models.g.dart';

enum IntoleranceReaction {
  none,
  fineInModeration,
  unpleasant,
  painful,
  dangerous,
  unknown;

  String toLocaleString(AppLocalizations l10n) {
    switch (this) {
      case IntoleranceReaction.none:
        return l10n.none;
      case IntoleranceReaction.fineInModeration:
        return l10n.fineInModeration;
      case IntoleranceReaction.unpleasant:
        return l10n.unpleasant;
      case IntoleranceReaction.painful:
        return l10n.painful;
      case IntoleranceReaction.dangerous:
        return l10n.dangerous;
      case IntoleranceReaction.unknown:
        return l10n.unknown;
    }
  }
}

@freezed
class Intolerance with _$Intolerance {
  const factory Intolerance({
    /// Id of the intolerance
    required String id,

    /// Last time the intolerance was modified
    required DateTime lastModified,

    /// Name of the intolerance
    required String name,

    /// Map of ingredient-IDs and their reaction to the intolerance
    required Map<String, IntoleranceReaction> ingredientsMap,

    /// Whether the intolerance is a whitelist or blacklist
    @Default(false) bool isWhitelist,
  }) = _Intolerance;
  const Intolerance._();

  factory Intolerance.fromJson(Map<String, dynamic> json) =>
      _$IntoleranceFromJson(json);
}
