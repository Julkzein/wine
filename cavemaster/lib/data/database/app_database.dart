import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Enums imported directly so the generated part file (app_database.g.dart) can see them.
import '../../core/constants/wine_enums.dart';

import 'tables/wines_table.dart';
import 'tables/cellars_table.dart';
import 'tables/cellar_slots_table.dart';
import 'tables/tasting_notes_table.dart';
import 'tables/grape_compositions_table.dart';
import 'tables/wishlist_table.dart';
import 'daos/wine_dao.dart';
import 'daos/cellar_dao.dart';
import 'daos/stats_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Wines,
    Cellars,
    CellarSlots,
    TastingNotes,
    GrapeCompositions,
    WishlistEntries,
  ],
  daos: [WineDao, CellarDao, StatsDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          // Future migrations go here.
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'cavemaster.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
