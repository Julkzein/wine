import 'package:drift/drift.dart';
import '../../../core/constants/wine_enums.dart';

@DataClassName('CellarRow')
class Cellars extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => textEnum<CellarType>()();
  IntColumn get rows => integer()();
  IntColumn get columns => integer()();
  IntColumn get depth => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
