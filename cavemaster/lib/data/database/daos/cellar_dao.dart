import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/cellars_table.dart';
import '../tables/cellar_slots_table.dart';

part 'cellar_dao.g.dart';

@DriftAccessor(tables: [Cellars, CellarSlots])
class CellarDao extends DatabaseAccessor<AppDatabase> with _$CellarDaoMixin {
  CellarDao(super.db);

  // ── Cellars ───────────────────────────────────────────────────────────────

  Stream<List<CellarRow>> watchAll() => select(cellars).watch();

  Future<List<CellarRow>> getAll() => select(cellars).get();

  Future<CellarRow?> getById(String id) {
    return (select(cellars)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  Future<String> insert(CellarsCompanion entry) {
    return into(cellars).insertReturning(entry).then((r) => r.id);
  }

  // Named updateCellar to avoid conflict with Drift's built-in `update(table)` method.
  Future<void> updateCellar(CellarsCompanion entry) {
    return (update(cellars)..where((c) => c.id.equals(entry.id.value)))
        .write(entry);
  }

  Future<void> deleteById(String id) {
    return (delete(cellars)..where((c) => c.id.equals(id))).go();
  }

  // ── Slots ─────────────────────────────────────────────────────────────────

  Stream<List<CellarSlotRow>> watchSlotsForCellar(String cellarId) {
    return (select(cellarSlots)
          ..where((s) => s.cellarId.equals(cellarId))
          ..orderBy([
            (s) => OrderingTerm.asc(s.row),
            (s) => OrderingTerm.asc(s.column),
            (s) => OrderingTerm.asc(s.depth),
          ]))
        .watch();
  }

  Future<List<CellarSlotRow>> getSlotsForCellar(String cellarId) {
    return (select(cellarSlots)..where((s) => s.cellarId.equals(cellarId)))
        .get();
  }

  Future<void> assignWineToSlot({
    required String cellarId,
    required int row,
    required int column,
    required int depth,
    required String? wineId,
  }) async {
    await into(cellarSlots).insertOnConflictUpdate(
      CellarSlotsCompanion.insert(
        cellarId: cellarId,
        row: row,
        column: column,
        depth: depth,
        wineId: Value(wineId),
      ),
    );
  }

  Future<void> clearSlot({
    required String cellarId,
    required int row,
    required int column,
    required int depth,
  }) {
    return assignWineToSlot(
      cellarId: cellarId,
      row: row,
      column: column,
      depth: depth,
      wineId: null,
    );
  }

  /// Initialises all slots for a newly-created cellar (all empty).
  Future<void> initSlots(String cellarId, int rows, int columns, int depth) async {
    final entries = <CellarSlotsCompanion>[];
    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < columns; c++) {
        for (var d = 0; d < depth; d++) {
          entries.add(CellarSlotsCompanion.insert(
            cellarId: cellarId,
            row: r,
            column: c,
            depth: d,
          ));
        }
      }
    }
    await batch((b) => b.insertAll(cellarSlots, entries));
  }
}
