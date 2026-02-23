// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cellar_dao.dart';

// ignore_for_file: type=lint
mixin _$CellarDaoMixin on DatabaseAccessor<AppDatabase> {
  $CellarsTable get cellars => attachedDatabase.cellars;
  $WinesTable get wines => attachedDatabase.wines;
  $CellarSlotsTable get cellarSlots => attachedDatabase.cellarSlots;
  CellarDaoManager get managers => CellarDaoManager(this);
}

class CellarDaoManager {
  final _$CellarDaoMixin _db;
  CellarDaoManager(this._db);
  $$CellarsTableTableManager get cellars =>
      $$CellarsTableTableManager(_db.attachedDatabase, _db.cellars);
  $$WinesTableTableManager get wines =>
      $$WinesTableTableManager(_db.attachedDatabase, _db.wines);
  $$CellarSlotsTableTableManager get cellarSlots =>
      $$CellarSlotsTableTableManager(_db.attachedDatabase, _db.cellarSlots);
}
