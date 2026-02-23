import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/wine.dart';
import 'database_provider.dart';

// We watch all wines so recommendation providers refresh on any collection change.
final _allWinesForRecsProvider = StreamProvider<List<Wine>>((ref) {
  return ref.watch(wineRepositoryProvider).watchAll();
});

// ── Scored / Tonight's Pick ────────────────────────────────────────────────

final selectedMealTypeProvider = StateProvider<String?>((ref) => null);

final tonightsPickProvider = Provider<AsyncValue<Wine?>>((ref) {
  final wines = ref.watch(_allWinesForRecsProvider);
  final service = ref.watch(recommendationServiceProvider);
  final meal = ref.watch(selectedMealTypeProvider);

  return wines.when(
    data: (list) {
      final scored = service.score(list, mealType: meal);
      if (scored.isEmpty) return const AsyncValue.data(null);
      return AsyncValue.data(scored.first.wine);
    },
    loading: () => const AsyncValue.loading(),
    error: AsyncValue.error,
  );
});

final drinkNowProvider = Provider<AsyncValue<List<Wine>>>((ref) {
  final wines = ref.watch(_allWinesForRecsProvider);
  final service = ref.watch(recommendationServiceProvider);
  return wines.when(
    data: (list) => AsyncValue.data(service.getDrinkNow(list)),
    loading: () => const AsyncValue.loading(),
    error: AsyncValue.error,
  );
});

final drinkSoonProvider = Provider<AsyncValue<List<Wine>>>((ref) {
  final wines = ref.watch(_allWinesForRecsProvider);
  final service = ref.watch(recommendationServiceProvider);
  return wines.when(
    data: (list) => AsyncValue.data(service.getDrinkSoon(list)),
    loading: () => const AsyncValue.loading(),
    error: AsyncValue.error,
  );
});

final keepAgingProvider = Provider<AsyncValue<List<Wine>>>((ref) {
  final wines = ref.watch(_allWinesForRecsProvider);
  final service = ref.watch(recommendationServiceProvider);
  return wines.when(
    data: (list) => AsyncValue.data(service.getKeepAging(list)),
    loading: () => const AsyncValue.loading(),
    error: AsyncValue.error,
  );
});

final pastPeakProvider = Provider<AsyncValue<List<Wine>>>((ref) {
  final wines = ref.watch(_allWinesForRecsProvider);
  final service = ref.watch(recommendationServiceProvider);
  return wines.when(
    data: (list) => AsyncValue.data(service.getPastPeak(list)),
    loading: () => const AsyncValue.loading(),
    error: AsyncValue.error,
  );
});
