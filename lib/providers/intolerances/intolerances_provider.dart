import 'package:mealtime/features/intolerances/models/intolerance_models.dart';
import 'package:mealtime/providers/database/database_provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intolerances_provider.g.dart';

@riverpod
FutureOr<List<Intolerance>> intolerances(Ref ref) async {
  final database = await ref.watch(databaseProvider.future);
  return database.intolerances;
}

@riverpod
FutureOr<bool> hasIntolerances(Ref ref) async {
  final intolerances = await ref.watch(intolerancesProvider.future);

  return intolerances.isNotEmpty;
}

@riverpod
FutureOr<int> intoleranceCount(Ref ref) async {
  final intolerances = await ref.watch(intolerancesProvider.future);

  return intolerances.length;
}

@riverpod
FutureOr<Intolerance> intoleranceById(Ref ref, String id) async {
  final intolerances = await ref.watch(intolerancesProvider.future);

  try {
    return intolerances.singleWhere((element) => element.id == id);
  } catch (error) {
    throw Exception("No intolerance with id '$id' found");
  }
}
