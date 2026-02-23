import 'package:drift/drift.dart';
import 'wines_table.dart';

@DataClassName('GrapeCompositionRow')
class GrapeCompositions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get wineId =>
      text().references(Wines, #id, onDelete: KeyAction.cascade)();
  TextColumn get variety => text()();
  RealColumn get percentage => real().nullable()();
}
