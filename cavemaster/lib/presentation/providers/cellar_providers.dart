import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/cellar.dart';
import '../../data/repositories/cellar_repository.dart';
import 'database_provider.dart';

final cellarsProvider = StreamProvider<List<Cellar>>((ref) {
  return ref.watch(cellarRepositoryProvider).watchAll();
});

final selectedCellarIdProvider = StateProvider<String?>((ref) => null);

final cellarWithSlotsProvider =
    StreamProvider.family<CellarWithSlots?, String>((ref, cellarId) {
  return ref.watch(cellarRepositoryProvider).watchCellarWithSlots(cellarId);
});
