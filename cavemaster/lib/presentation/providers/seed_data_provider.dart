import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Loads the grape varieties list from the bundled JSON asset.
final grapeVarietiesProvider = FutureProvider<List<String>>((ref) async {
  final raw = await rootBundle.loadString('assets/data/grape_varieties.json');
  final list = jsonDecode(raw) as List;
  return list.cast<String>()..sort();
});

/// Loads the regions map from the bundled JSON asset.
/// Returns Map<country, Map<region, List<subRegion>>>
final regionsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final raw = await rootBundle.loadString('assets/data/regions.json');
  return jsonDecode(raw) as Map<String, dynamic>;
});

/// Returns a flat list of all region names for autocomplete.
final allRegionNamesProvider = Provider<AsyncValue<List<String>>>((ref) {
  final regionsAsync = ref.watch(regionsProvider);
  return regionsAsync.when(
    data: (map) {
      final names = <String>[];
      for (final country in map.values) {
        if (country is Map) {
          for (final region in country.keys) {
            names.add(region as String);
            final subRegions = country[region];
            if (subRegions is List) {
              names.addAll(subRegions.cast<String>());
            }
          }
        }
      }
      return AsyncValue.data(names..sort());
    },
    loading: () => const AsyncValue.loading(),
    error: AsyncValue.error,
  );
});

/// Loads the appellations list from the bundled JSON asset.
final appellationsProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final raw = await rootBundle.loadString('assets/data/appellations.json');
  final list = jsonDecode(raw) as List;
  return list.cast<Map<String, dynamic>>();
});
