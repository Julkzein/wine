import 'package:drift/drift.dart';
import '../../../core/constants/wine_enums.dart';
import 'cellars_table.dart';

// @DataClassName ensures no conflict with our domain Wine model class.
@DataClassName('WineRow')
class Wines extends Table {
  // Identity
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get vintage => integer().nullable()();
  TextColumn get labelImagePath => text().nullable()();

  // Classification
  TextColumn get type => textEnum<WineType>()();
  TextColumn get country => text().nullable()();
  TextColumn get region => text().nullable()();
  TextColumn get subRegion => text().nullable()();
  TextColumn get appellation => text().nullable()();

  // Producer
  TextColumn get producer => text().nullable()();
  TextColumn get winemaker => text().nullable()();

  // Characteristics
  RealColumn get alcoholContent => real().nullable()();
  IntColumn get bodyScore => integer().nullable()();
  IntColumn get tanninLevel => integer().nullable()();
  IntColumn get acidityLevel => integer().nullable()();
  IntColumn get sweetnessLevel => integer().nullable()();

  // Drinking window
  IntColumn get drinkFrom => integer().nullable()();
  IntColumn get drinkUntil => integer().nullable()();
  IntColumn get peakFrom => integer().nullable()();
  IntColumn get peakUntil => integer().nullable()();
  TextColumn get agingPotential => textEnum<AgingPotential>().nullable()();

  // Collection
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  DateTimeColumn get purchaseDate => dateTime().nullable()();
  RealColumn get purchasePrice => real().nullable()();
  TextColumn get purchaseLocation => text().nullable()();

  // Storage position (links to a cellar)
  TextColumn get cellarId =>
      text().nullable().references(Cellars, #id, onDelete: KeyAction.setNull)();
  IntColumn get rackRow => integer().nullable()();
  IntColumn get rackColumn => integer().nullable()();
  IntColumn get rackDepth => integer().nullable()();

  // Personal
  RealColumn get userRating => real().nullable()();
  TextColumn get tastingNotes => text().nullable()();
  TextColumn get personalNotes => text().nullable()();
  // Stored as JSON arrays: '["gift","special occasion"]'
  TextColumn get tags => text().withDefault(const Constant('[]'))();
  TextColumn get foodPairings => text().withDefault(const Constant('[]'))();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  // Metadata
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get source => textEnum<WineSource>()();

  @override
  Set<Column> get primaryKey => {id};
}
