import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/wines_table.dart';
import '../tables/grape_compositions_table.dart';
import '../../../core/constants/wine_enums.dart';

part 'wine_dao.g.dart';

@DriftAccessor(tables: [Wines, GrapeCompositions])
class WineDao extends DatabaseAccessor<AppDatabase> with _$WineDaoMixin {
  WineDao(super.db);

  // ── Wines ──────────────────────────────────────────────────────────────────

  Stream<List<WineRow>> watchAll({WineSortField sort = WineSortField.name}) {
    final query = select(wines);
    _applySort(query, sort);
    return query.watch();
  }

  Future<List<WineRow>> getAll({WineSortField sort = WineSortField.name}) {
    final query = select(wines);
    _applySort(query, sort);
    return query.get();
  }

  Stream<WineRow?> watchById(String id) {
    return (select(wines)..where((w) => w.id.equals(id)))
        .watchSingleOrNull();
  }

  Future<WineRow?> getById(String id) {
    return (select(wines)..where((w) => w.id.equals(id))).getSingleOrNull();
  }

  Future<List<WineRow>> search(String query) {
    final q = '%$query%';
    return (select(wines)
          ..where(
            (w) =>
                w.name.like(q) |
                w.producer.like(q) |
                w.region.like(q) |
                w.country.like(q) |
                w.appellation.like(q) |
                w.personalNotes.like(q),
          )
          ..orderBy([(w) => OrderingTerm.asc(w.name)]))
        .get();
  }

  Future<List<WineRow>> filterByType(WineType type) {
    return (select(wines)
          ..where((w) => w.type.equalsValue(type))
          ..orderBy([(w) => OrderingTerm.asc(w.name)]))
        .get();
  }

  Future<List<WineRow>> getByDrinkingStatus() {
    // Returns wines with a defined drinking window, for recommendation engine.
    return (select(wines)
          ..where((w) => w.drinkFrom.isNotNull() | w.drinkUntil.isNotNull())
          ..where((w) => w.quantity.isBiggerThanValue(0)))
        .get();
  }

  Future<String> insert(WinesCompanion entry) {
    return into(wines).insertReturning(entry).then((row) => row.id);
  }

  // Named updateEntry to avoid conflict with Drift's built-in `update(table)` method.
  Future<void> updateEntry(WinesCompanion entry) {
    return (update(wines)..where((w) => w.id.equals(entry.id.value)))
        .write(entry);
  }

  Future<void> deleteById(String id) {
    return (delete(wines)..where((w) => w.id.equals(id))).go();
  }

  Future<void> decrementQuantity(String id) async {
    final wine = await getById(id);
    if (wine == null || wine.quantity <= 0) return;
    await (update(wines)..where((w) => w.id.equals(id))).write(
      WinesCompanion(quantity: Value(wine.quantity - 1)),
    );
  }

  Future<void> toggleFavorite(String id) async {
    final wine = await getById(id);
    if (wine == null) return;
    await (update(wines)..where((w) => w.id.equals(id))).write(
      WinesCompanion(isFavorite: Value(!wine.isFavorite)),
    );
  }

  // ── Grape compositions ────────────────────────────────────────────────────

  Stream<List<GrapeCompositionRow>> watchGrapesForWine(String wineId) {
    return (select(grapeCompositions)
          ..where((g) => g.wineId.equals(wineId))
          ..orderBy([(g) => OrderingTerm.desc(g.percentage)]))
        .watch();
  }

  Future<List<GrapeCompositionRow>> getGrapesForWine(String wineId) {
    return (select(grapeCompositions)
          ..where((g) => g.wineId.equals(wineId))
          ..orderBy([(g) => OrderingTerm.desc(g.percentage)]))
        .get();
  }

  Future<void> replaceGrapes(
    String wineId,
    List<GrapeCompositionsCompanion> entries,
  ) async {
    await (delete(grapeCompositions)
          ..where((g) => g.wineId.equals(wineId)))
        .go();
    await batch((b) => b.insertAll(grapeCompositions, entries));
  }

  // ── Helpers ───────────────────────────────────────────────────────────────

  void _applySort(SimpleSelectStatement<$WinesTable, WineRow> query, WineSortField sort) {
    switch (sort) {
      case WineSortField.name:
        query.orderBy([(w) => OrderingTerm.asc(w.name)]);
      case WineSortField.vintage:
        query.orderBy([
          (w) => OrderingTerm.desc(w.vintage),
          (w) => OrderingTerm.asc(w.name),
        ]);
      case WineSortField.rating:
        query.orderBy([
          (w) => OrderingTerm.desc(w.userRating),
          (w) => OrderingTerm.asc(w.name),
        ]);
      case WineSortField.price:
        query.orderBy([
          (w) => OrderingTerm.desc(w.purchasePrice),
          (w) => OrderingTerm.asc(w.name),
        ]);
      case WineSortField.dateAdded:
        query.orderBy([(w) => OrderingTerm.desc(w.createdAt)]);
      case WineSortField.drinkBy:
        query.orderBy([
          (w) => OrderingTerm.asc(w.drinkUntil),
          (w) => OrderingTerm.asc(w.name),
        ]);
    }
  }
}
