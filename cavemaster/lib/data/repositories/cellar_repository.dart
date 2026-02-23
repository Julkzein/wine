import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/cellar.dart';

class CellarSlot {
  final String cellarId;
  final int row;
  final int column;
  final int depth;
  final String? wineId;
  final bool isBlocked;

  const CellarSlot({
    required this.cellarId,
    required this.row,
    required this.column,
    required this.depth,
    this.wineId,
    this.isBlocked = false,
  });

  bool get isEmpty => wineId == null && !isBlocked;
}

class CellarWithSlots {
  final Cellar cellar;
  final List<CellarSlot> slots;

  const CellarWithSlots({required this.cellar, required this.slots});

  CellarSlot? slotAt(int row, int col, {int depth = 0}) {
    try {
      return slots.firstWhere(
        (s) => s.row == row && s.column == col && s.depth == depth,
      );
    } catch (_) {
      return null;
    }
  }

  int get occupiedSlots => slots.where((s) => s.wineId != null).length;
  int get emptySlots => slots.where((s) => s.isEmpty).length;
}

class CellarRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  CellarRepository(this._db);

  Stream<List<Cellar>> watchAll() {
    return _db.cellarDao.watchAll().map(
          (rows) => rows.map(_rowToCellar).toList(),
        );
  }

  Stream<CellarWithSlots?> watchCellarWithSlots(String cellarId) {
    // We combine two streams: the cellar itself + its slots.
    return _db.cellarDao
        .watchSlotsForCellar(cellarId)
        .asyncMap((slotRows) async {
      final cellarRow = await _db.cellarDao.getById(cellarId);
      if (cellarRow == null) return null;
      return CellarWithSlots(
        cellar: _rowToCellar(cellarRow),
        slots: slotRows.map(_rowToSlot).toList(),
      );
    });
  }

  Future<List<Cellar>> getAll() async {
    final rows = await _db.cellarDao.getAll();
    return rows.map(_rowToCellar).toList();
  }

  Future<String> add(Cellar cellar) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    await _db.transaction(() async {
      await _db.cellarDao.insert(
        CellarsCompanion.insert(
          id: id,
          name: cellar.name,
          type: cellar.type,
          rows: cellar.rows,
          columns: cellar.columns,
          depth: Value(cellar.depth),
          createdAt: now,
        ),
      );
      // Auto-create all slots as empty.
      await _db.cellarDao.initSlots(id, cellar.rows, cellar.columns, cellar.depth);
    });
    return id;
  }

  Future<void> update(Cellar cellar) async {
    await _db.cellarDao.updateCellar(
      CellarsCompanion(
        id: Value(cellar.id),
        name: Value(cellar.name),
        type: Value(cellar.type),
        rows: Value(cellar.rows),
        columns: Value(cellar.columns),
        depth: Value(cellar.depth),
      ),
    );
  }

  Future<void> delete(String id) => _db.cellarDao.deleteById(id);

  Future<void> assignWine({
    required String cellarId,
    required int row,
    required int column,
    required int depth,
    required String? wineId,
  }) {
    return _db.cellarDao.assignWineToSlot(
      cellarId: cellarId,
      row: row,
      column: column,
      depth: depth,
      wineId: wineId,
    );
  }

  // ── Mapping ────────────────────────────────────────────────────────────────

  Cellar _rowToCellar(CellarRow row) => Cellar(
        id: row.id,
        name: row.name,
        type: row.type,
        rows: row.rows,
        columns: row.columns,
        depth: row.depth,
        createdAt: row.createdAt,
      );

  CellarSlot _rowToSlot(CellarSlotRow row) => CellarSlot(
        cellarId: row.cellarId,
        row: row.row,
        column: row.column,
        depth: row.depth,
        wineId: row.wineId,
        isBlocked: row.isBlocked,
      );
}
