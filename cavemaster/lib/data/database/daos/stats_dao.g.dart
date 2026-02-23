// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_dao.dart';

// ignore_for_file: type=lint
mixin _$StatsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CellarsTable get cellars => attachedDatabase.cellars;
  $WinesTable get wines => attachedDatabase.wines;
  $TastingNotesTable get tastingNotes => attachedDatabase.tastingNotes;
  StatsDaoManager get managers => StatsDaoManager(this);
}

class StatsDaoManager {
  final _$StatsDaoMixin _db;
  StatsDaoManager(this._db);
  $$CellarsTableTableManager get cellars =>
      $$CellarsTableTableManager(_db.attachedDatabase, _db.cellars);
  $$WinesTableTableManager get wines =>
      $$WinesTableTableManager(_db.attachedDatabase, _db.wines);
  $$TastingNotesTableTableManager get tastingNotes =>
      $$TastingNotesTableTableManager(_db.attachedDatabase, _db.tastingNotes);
}
