import 'package:drift/drift.dart';

@DataClassName('WishlistEntryRow')
class WishlistEntries extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get producer => text().nullable()();
  IntColumn get vintage => integer().nullable()();
  RealColumn get estimatedPrice => real().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
