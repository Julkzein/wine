import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../database/app_database.dart';
import '../models/wine.dart';
import '../models/grape_composition.dart';
import '../../core/constants/wine_enums.dart';

class WineRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  WineRepository(this._db);

  // ── Streams ────────────────────────────────────────────────────────────────

  Stream<List<Wine>> watchAll({WineSortField sort = WineSortField.name}) {
    return _db.wineDao.watchAll(sort: sort).asyncMap(_rowsToWines);
  }

  Stream<Wine?> watchById(String id) {
    return _db.wineDao.watchById(id).asyncMap((row) async {
      if (row == null) return null;
      final grapes = await _db.wineDao.getGrapesForWine(id);
      return _rowToWine(row, grapes);
    });
  }

  // ── Queries ────────────────────────────────────────────────────────────────

  Future<List<Wine>> search(String query) async {
    final rows = await _db.wineDao.search(query);
    return _rowsToWines(rows);
  }

  Future<List<Wine>> getAll({WineSortField sort = WineSortField.name}) async {
    final rows = await _db.wineDao.getAll(sort: sort);
    return _rowsToWines(rows);
  }

  Future<Wine?> getById(String id) async {
    final row = await _db.wineDao.getById(id);
    if (row == null) return null;
    final grapes = await _db.wineDao.getGrapesForWine(id);
    return _rowToWine(row, grapes);
  }

  Future<List<Wine>> getWinesForRecommendations() async {
    final rows = await _db.wineDao.getByDrinkingStatus();
    return _rowsToWines(rows);
  }

  // ── Mutations ──────────────────────────────────────────────────────────────

  Future<String> add(Wine wine) async {
    final id = wine.id.isEmpty ? _uuid.v4() : wine.id;
    final now = DateTime.now();

    await _db.transaction(() async {
      await _db.wineDao.insert(_wineToCompanion(wine, id: id, now: now));
      if (wine.grapes.isNotEmpty) {
        await _db.wineDao.replaceGrapes(id, _grapesToCompanions(id, wine.grapes));
      }
    });
    return id;
  }

  Future<void> update(Wine wine) async {
    final now = DateTime.now();
    await _db.transaction(() async {
      await _db.wineDao.updateEntry(_wineToCompanion(wine, id: wine.id, now: now));
      await _db.wineDao.replaceGrapes(
        wine.id,
        _grapesToCompanions(wine.id, wine.grapes),
      );
    });
  }

  Future<void> delete(String id) => _db.wineDao.deleteById(id);

  Future<void> drink(String id) => _db.wineDao.decrementQuantity(id);

  Future<void> toggleFavorite(String id) => _db.wineDao.toggleFavorite(id);

  // ── Mapping helpers ────────────────────────────────────────────────────────

  Future<List<Wine>> _rowsToWines(List<WineRow> rows) async {
    // Fetch all grape compositions in one pass to avoid N+1
    final wineIds = rows.map((r) => r.id).toList();
    if (wineIds.isEmpty) return [];

    final allGrapes = <String, List<GrapeCompositionRow>>{};
    for (final id in wineIds) {
      allGrapes[id] = await _db.wineDao.getGrapesForWine(id);
    }

    return rows.map((row) => _rowToWine(row, allGrapes[row.id] ?? [])).toList();
  }

  Wine _rowToWine(WineRow row, List<GrapeCompositionRow> grapeRows) {
    return Wine(
      id: row.id,
      name: row.name,
      vintage: row.vintage,
      labelImagePath: row.labelImagePath,
      type: row.type,
      country: row.country,
      region: row.region,
      subRegion: row.subRegion,
      appellation: row.appellation,
      producer: row.producer,
      winemaker: row.winemaker,
      grapes: grapeRows
          .map((g) => GrapeComposition(variety: g.variety, percentage: g.percentage))
          .toList(),
      alcoholContent: row.alcoholContent,
      bodyScore: row.bodyScore,
      tanninLevel: row.tanninLevel,
      acidityLevel: row.acidityLevel,
      sweetnessLevel: row.sweetnessLevel,
      drinkFrom: row.drinkFrom,
      drinkUntil: row.drinkUntil,
      peakFrom: row.peakFrom,
      peakUntil: row.peakUntil,
      agingPotential: row.agingPotential,
      quantity: row.quantity,
      purchaseDate: row.purchaseDate,
      purchasePrice: row.purchasePrice,
      purchaseLocation: row.purchaseLocation,
      cellarId: row.cellarId,
      rackRow: row.rackRow,
      rackColumn: row.rackColumn,
      rackDepth: row.rackDepth,
      userRating: row.userRating,
      tastingNotes: row.tastingNotes,
      personalNotes: row.personalNotes,
      tags: _parseJsonList(row.tags),
      foodPairings: _parseJsonList(row.foodPairings),
      isFavorite: row.isFavorite,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      source: row.source,
    );
  }

  WinesCompanion _wineToCompanion(Wine wine, {required String id, required DateTime now}) {
    return WinesCompanion(
      id: Value(id),
      name: Value(wine.name),
      vintage: Value(wine.vintage),
      labelImagePath: Value(wine.labelImagePath),
      type: Value(wine.type),
      country: Value(wine.country),
      region: Value(wine.region),
      subRegion: Value(wine.subRegion),
      appellation: Value(wine.appellation),
      producer: Value(wine.producer),
      winemaker: Value(wine.winemaker),
      alcoholContent: Value(wine.alcoholContent),
      bodyScore: Value(wine.bodyScore),
      tanninLevel: Value(wine.tanninLevel),
      acidityLevel: Value(wine.acidityLevel),
      sweetnessLevel: Value(wine.sweetnessLevel),
      drinkFrom: Value(wine.drinkFrom),
      drinkUntil: Value(wine.drinkUntil),
      peakFrom: Value(wine.peakFrom),
      peakUntil: Value(wine.peakUntil),
      agingPotential: Value(wine.agingPotential),
      quantity: Value(wine.quantity),
      purchaseDate: Value(wine.purchaseDate),
      purchasePrice: Value(wine.purchasePrice),
      purchaseLocation: Value(wine.purchaseLocation),
      cellarId: Value(wine.cellarId),
      rackRow: Value(wine.rackRow),
      rackColumn: Value(wine.rackColumn),
      rackDepth: Value(wine.rackDepth),
      userRating: Value(wine.userRating),
      tastingNotes: Value(wine.tastingNotes),
      personalNotes: Value(wine.personalNotes),
      tags: Value(jsonEncode(wine.tags)),
      foodPairings: Value(jsonEncode(wine.foodPairings)),
      isFavorite: Value(wine.isFavorite),
      createdAt: Value(wine.createdAt),
      updatedAt: Value(now),
      source: Value(wine.source),
    );
  }

  List<GrapeCompositionsCompanion> _grapesToCompanions(
    String wineId,
    List<GrapeComposition> grapes,
  ) {
    return grapes
        .map(
          (g) => GrapeCompositionsCompanion(
            wineId: Value(wineId),
            variety: Value(g.variety),
            percentage: Value(g.percentage),
          ),
        )
        .toList();
  }

  List<String> _parseJsonList(String? json) {
    if (json == null || json.isEmpty) return [];
    try {
      return List<String>.from(jsonDecode(json) as List);
    } catch (_) {
      return [];
    }
  }
}
