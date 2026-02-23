import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/wine_repository.dart';
import '../../data/repositories/cellar_repository.dart';
import '../../data/services/recommendation_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final wineRepositoryProvider = Provider<WineRepository>((ref) {
  return WineRepository(ref.watch(databaseProvider));
});

final cellarRepositoryProvider = Provider<CellarRepository>((ref) {
  return CellarRepository(ref.watch(databaseProvider));
});

final recommendationServiceProvider = Provider<RecommendationService>((ref) {
  return RecommendationService();
});
