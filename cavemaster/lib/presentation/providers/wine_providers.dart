import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/wine.dart';
import '../../core/constants/wine_enums.dart';
import 'database_provider.dart';

// ── Collection stream ──────────────────────────────────────────────────────

final winesProvider = StreamProvider<List<Wine>>((ref) {
  final sort = ref.watch(collectionSortProvider);
  return ref.watch(wineRepositoryProvider).watchAll(sort: sort);
});

// ── Single wine ────────────────────────────────────────────────────────────

final wineByIdProvider = StreamProvider.family<Wine?, String>((ref, id) {
  return ref.watch(wineRepositoryProvider).watchById(id);
});

// ── Sort & filter state ────────────────────────────────────────────────────

final collectionSortProvider =
    StateProvider<WineSortField>((ref) => WineSortField.name);

class CollectionFilter {
  final WineType? type;
  final String? country;
  final double? minRating;
  final bool favoritesOnly;

  const CollectionFilter({
    this.type,
    this.country,
    this.minRating,
    this.favoritesOnly = false,
  });

  bool get isActive =>
      type != null || country != null || minRating != null || favoritesOnly;

  bool matches(Wine wine) {
    if (type != null && wine.type != type) return false;
    if (country != null && wine.country != country) return false;
    if (minRating != null &&
        (wine.userRating == null || wine.userRating! < minRating!)) return false;
    if (favoritesOnly && !wine.isFavorite) return false;
    return true;
  }

  CollectionFilter copyWith({
    Object? type = _sentinel,
    Object? country = _sentinel,
    Object? minRating = _sentinel,
    bool? favoritesOnly,
  }) {
    return CollectionFilter(
      type: type == _sentinel ? this.type : type as WineType?,
      country: country == _sentinel ? this.country : country as String?,
      minRating: minRating == _sentinel ? this.minRating : minRating as double?,
      favoritesOnly: favoritesOnly ?? this.favoritesOnly,
    );
  }

  static const _sentinel = Object();
}

final collectionFilterProvider =
    StateProvider<CollectionFilter>((ref) => const CollectionFilter());

// ── Search ─────────────────────────────────────────────────────────────────

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = FutureProvider<List<Wine>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.trim().isEmpty) return [];
  return ref.watch(wineRepositoryProvider).search(query.trim());
});

// ── Filtered collection (applies filter on top of stream) ─────────────────

final filteredWinesProvider = Provider<AsyncValue<List<Wine>>>((ref) {
  final wines = ref.watch(winesProvider);
  final filter = ref.watch(collectionFilterProvider);
  final searchQuery = ref.watch(searchQueryProvider);

  if (searchQuery.trim().isNotEmpty) {
    return ref.watch(searchResultsProvider).when(
          data: (results) => AsyncValue.data(
            filter.isActive ? results.where(filter.matches).toList() : results,
          ),
          loading: () => const AsyncValue.loading(),
          error: AsyncValue.error,
        );
  }

  return wines.when(
    data: (list) => AsyncValue.data(
      filter.isActive ? list.where(filter.matches).toList() : list,
    ),
    loading: () => const AsyncValue.loading(),
    error: AsyncValue.error,
  );
});

// ── View mode (grid vs list) ───────────────────────────────────────────────

enum CollectionViewMode { grid, list }

final collectionViewModeProvider =
    StateProvider<CollectionViewMode>((ref) => CollectionViewMode.grid);
