import 'package:drift/drift.dart';
import 'wines_table.dart';

@DataClassName('TastingNoteRow')
class TastingNotes extends Table {
  TextColumn get id => text()();
  TextColumn get wineId =>
      text().references(Wines, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  TextColumn get appearance => text().nullable()();
  TextColumn get nose => text().nullable()();
  TextColumn get palate => text().nullable()();
  TextColumn get finish => text().nullable()();
  TextColumn get notes => text().nullable()();
  RealColumn get rating => real().nullable()();
  TextColumn get photoPath => text().nullable()();
  TextColumn get occasion => text().nullable()();
  TextColumn get foodPaired => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
