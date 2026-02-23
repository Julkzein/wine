import 'package:drift/drift.dart';
import 'cellars_table.dart';
import 'wines_table.dart';

@DataClassName('CellarSlotRow')
class CellarSlots extends Table {
  TextColumn get cellarId =>
      text().references(Cellars, #id, onDelete: KeyAction.cascade)();
  IntColumn get row => integer()();
  IntColumn get column => integer()();
  IntColumn get depth => integer()();
  TextColumn get wineId =>
      text().nullable().references(Wines, #id, onDelete: KeyAction.setNull)();
  BoolColumn get isBlocked => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {cellarId, row, column, depth};
}
