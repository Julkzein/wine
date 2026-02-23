import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/wines_table.dart';
import '../tables/tasting_notes_table.dart';

part 'stats_dao.g.dart';

class WineTypeCount {
  final String type;
  final int count;
  final int bottles;
  WineTypeCount({required this.type, required this.count, required this.bottles});
}

class CountryCount {
  final String country;
  final int count;
  CountryCount({required this.country, required this.count});
}

class VintageCount {
  final int vintage;
  final int count;
  VintageCount({required this.vintage, required this.count});
}

@DriftAccessor(tables: [Wines, TastingNotes])
class StatsDao extends DatabaseAccessor<AppDatabase> with _$StatsDaoMixin {
  StatsDao(super.db);

  // ── Totals ────────────────────────────────────────────────────────────────

  Stream<int> watchTotalWines() {
    final count = wines.id.count();
    return (selectOnly(wines)..addColumns([count]))
        .map((row) => row.read(count) ?? 0)
        .watchSingle();
  }

  Stream<int> watchTotalBottles() {
    final sum = wines.quantity.sum();
    return (selectOnly(wines)..addColumns([sum]))
        .map((row) => row.read(sum) ?? 0)
        .watchSingle();
  }

  Future<double> getTotalValue() async {
    final rows = await select(wines).get();
    return rows.fold<double>(
      0,
      (sum, w) => sum + (w.purchasePrice ?? 0) * w.quantity,
    );
  }

  Stream<double> watchTotalValue() {
    return select(wines).watch().map(
          (rows) => rows.fold<double>(
            0,
            (sum, w) => sum + (w.purchasePrice ?? 0) * w.quantity,
          ),
        );
  }

  // ── Distribution ──────────────────────────────────────────────────────────

  Future<List<WineTypeCount>> getTypeDistribution() async {
    final typeCol = wines.type;
    final countCol = wines.id.count();
    final bottlesCol = wines.quantity.sum();

    final rows = await (selectOnly(wines)
          ..addColumns([typeCol, countCol, bottlesCol])
          ..groupBy([typeCol])
          ..orderBy([OrderingTerm.desc(countCol)]))
        .get();

    return rows
        .map(
          (r) => WineTypeCount(
            type: r.read(typeCol) ?? '',
            count: r.read(countCol) ?? 0,
            bottles: r.read(bottlesCol) ?? 0,
          ),
        )
        .toList();
  }

  Future<List<CountryCount>> getCountryDistribution() async {
    final countryCol = wines.country;
    final countCol = wines.id.count();

    final rows = await (selectOnly(wines)
          ..addColumns([countryCol, countCol])
          ..groupBy([countryCol])
          ..orderBy([OrderingTerm.desc(countCol)])
          ..limit(10))
        .get();

    return rows
        .where((r) => r.read(countryCol) != null)
        .map(
          (r) => CountryCount(
            country: r.read(countryCol)!,
            count: r.read(countCol) ?? 0,
          ),
        )
        .toList();
  }

  Future<List<VintageCount>> getVintageDistribution() async {
    final vintageCol = wines.vintage;
    final countCol = wines.id.count();

    final rows = await (selectOnly(wines)
          ..addColumns([vintageCol, countCol])
          ..groupBy([vintageCol])
          ..orderBy([OrderingTerm.asc(vintageCol)]))
        .get();

    return rows
        .where((r) => r.read(vintageCol) != null)
        .map(
          (r) => VintageCount(
            vintage: r.read(vintageCol)!,
            count: r.read(countCol) ?? 0,
          ),
        )
        .toList();
  }

  // ── Drinking status counts ────────────────────────────────────────────────

  Future<Map<String, int>> getDrinkingStatusCounts() async {
    final now = DateTime.now().year;
    final allWines = await select(wines).get();

    final counts = <String, int>{
      'peak': 0,
      'drinkNow': 0,
      'drinkSoon': 0,
      'keepAging': 0,
      'pastPeak': 0,
      'unknown': 0,
    };

    for (final w in allWines) {
      if (w.drinkFrom == null && w.drinkUntil == null) {
        counts['unknown'] = (counts['unknown'] ?? 0) + 1;
      } else if (w.drinkUntil != null && now > w.drinkUntil!) {
        counts['pastPeak'] = (counts['pastPeak'] ?? 0) + 1;
      } else if (w.peakFrom != null &&
          w.peakUntil != null &&
          now >= w.peakFrom! &&
          now <= w.peakUntil!) {
        counts['peak'] = (counts['peak'] ?? 0) + 1;
      } else if (w.drinkFrom != null && now >= w.drinkFrom!) {
        final yearsLeft = w.drinkUntil != null ? w.drinkUntil! - now : 999;
        if (yearsLeft <= 2) {
          counts['drinkSoon'] = (counts['drinkSoon'] ?? 0) + 1;
        } else {
          counts['drinkNow'] = (counts['drinkNow'] ?? 0) + 1;
        }
      } else {
        counts['keepAging'] = (counts['keepAging'] ?? 0) + 1;
      }
    }

    return counts;
  }
}
