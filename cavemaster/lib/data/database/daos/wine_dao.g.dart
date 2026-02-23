// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wine_dao.dart';

// ignore_for_file: type=lint
mixin _$WineDaoMixin on DatabaseAccessor<AppDatabase> {
  $CellarsTable get cellars => attachedDatabase.cellars;
  $WinesTable get wines => attachedDatabase.wines;
  $GrapeCompositionsTable get grapeCompositions =>
      attachedDatabase.grapeCompositions;
  WineDaoManager get managers => WineDaoManager(this);
}

class WineDaoManager {
  final _$WineDaoMixin _db;
  WineDaoManager(this._db);
  $$CellarsTableTableManager get cellars =>
      $$CellarsTableTableManager(_db.attachedDatabase, _db.cellars);
  $$WinesTableTableManager get wines =>
      $$WinesTableTableManager(_db.attachedDatabase, _db.wines);
  $$GrapeCompositionsTableTableManager get grapeCompositions =>
      $$GrapeCompositionsTableTableManager(
          _db.attachedDatabase, _db.grapeCompositions);
}
