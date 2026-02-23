import '../../core/constants/wine_enums.dart';
import 'grape_composition.dart';

class Wine {
  // ── Identity ───────────────────────────────────────────────────────────────
  final String id;
  final String name;
  final int? vintage;
  final String? labelImagePath;

  // ── Classification ────────────────────────────────────────────────────────
  final WineType type;
  final String? country;
  final String? region;
  final String? subRegion;
  final String? appellation;

  // ── Producer ──────────────────────────────────────────────────────────────
  final String? producer;
  final String? winemaker;

  // ── Grape composition ─────────────────────────────────────────────────────
  final List<GrapeComposition> grapes;

  // ── Characteristics (1–5 scale) ───────────────────────────────────────────
  final double? alcoholContent;
  final int? bodyScore;
  final int? tanninLevel;
  final int? acidityLevel;
  final int? sweetnessLevel;

  // ── Drinking window ───────────────────────────────────────────────────────
  final int? drinkFrom;
  final int? drinkUntil;
  final int? peakFrom;
  final int? peakUntil;
  final AgingPotential? agingPotential;

  // ── Collection ────────────────────────────────────────────────────────────
  final int quantity;
  final DateTime? purchaseDate;
  final double? purchasePrice;
  final String? purchaseLocation;

  // ── Storage position ──────────────────────────────────────────────────────
  final String? cellarId;
  final int? rackRow;
  final int? rackColumn;
  final int? rackDepth;

  // ── Personal ──────────────────────────────────────────────────────────────
  final double? userRating;
  final String? tastingNotes;
  final String? personalNotes;
  final List<String> tags;
  final List<String> foodPairings;
  final bool isFavorite;

  // ── Metadata ──────────────────────────────────────────────────────────────
  final DateTime createdAt;
  final DateTime updatedAt;
  final WineSource source;

  const Wine({
    required this.id,
    required this.name,
    this.vintage,
    this.labelImagePath,
    required this.type,
    this.country,
    this.region,
    this.subRegion,
    this.appellation,
    this.producer,
    this.winemaker,
    this.grapes = const [],
    this.alcoholContent,
    this.bodyScore,
    this.tanninLevel,
    this.acidityLevel,
    this.sweetnessLevel,
    this.drinkFrom,
    this.drinkUntil,
    this.peakFrom,
    this.peakUntil,
    this.agingPotential,
    this.quantity = 1,
    this.purchaseDate,
    this.purchasePrice,
    this.purchaseLocation,
    this.cellarId,
    this.rackRow,
    this.rackColumn,
    this.rackDepth,
    this.userRating,
    this.tastingNotes,
    this.personalNotes,
    this.tags = const [],
    this.foodPairings = const [],
    this.isFavorite = false,
    required this.createdAt,
    required this.updatedAt,
    this.source = WineSource.manual,
  });

  Wine copyWith({
    String? id,
    String? name,
    int? vintage,
    String? labelImagePath,
    WineType? type,
    String? country,
    String? region,
    String? subRegion,
    String? appellation,
    String? producer,
    String? winemaker,
    List<GrapeComposition>? grapes,
    double? alcoholContent,
    int? bodyScore,
    int? tanninLevel,
    int? acidityLevel,
    int? sweetnessLevel,
    int? drinkFrom,
    int? drinkUntil,
    int? peakFrom,
    int? peakUntil,
    AgingPotential? agingPotential,
    int? quantity,
    DateTime? purchaseDate,
    double? purchasePrice,
    String? purchaseLocation,
    String? cellarId,
    int? rackRow,
    int? rackColumn,
    int? rackDepth,
    double? userRating,
    String? tastingNotes,
    String? personalNotes,
    List<String>? tags,
    List<String>? foodPairings,
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
    WineSource? source,
  }) {
    return Wine(
      id: id ?? this.id,
      name: name ?? this.name,
      vintage: vintage ?? this.vintage,
      labelImagePath: labelImagePath ?? this.labelImagePath,
      type: type ?? this.type,
      country: country ?? this.country,
      region: region ?? this.region,
      subRegion: subRegion ?? this.subRegion,
      appellation: appellation ?? this.appellation,
      producer: producer ?? this.producer,
      winemaker: winemaker ?? this.winemaker,
      grapes: grapes ?? this.grapes,
      alcoholContent: alcoholContent ?? this.alcoholContent,
      bodyScore: bodyScore ?? this.bodyScore,
      tanninLevel: tanninLevel ?? this.tanninLevel,
      acidityLevel: acidityLevel ?? this.acidityLevel,
      sweetnessLevel: sweetnessLevel ?? this.sweetnessLevel,
      drinkFrom: drinkFrom ?? this.drinkFrom,
      drinkUntil: drinkUntil ?? this.drinkUntil,
      peakFrom: peakFrom ?? this.peakFrom,
      peakUntil: peakUntil ?? this.peakUntil,
      agingPotential: agingPotential ?? this.agingPotential,
      quantity: quantity ?? this.quantity,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      purchaseLocation: purchaseLocation ?? this.purchaseLocation,
      cellarId: cellarId ?? this.cellarId,
      rackRow: rackRow ?? this.rackRow,
      rackColumn: rackColumn ?? this.rackColumn,
      rackDepth: rackDepth ?? this.rackDepth,
      userRating: userRating ?? this.userRating,
      tastingNotes: tastingNotes ?? this.tastingNotes,
      personalNotes: personalNotes ?? this.personalNotes,
      tags: tags ?? this.tags,
      foodPairings: foodPairings ?? this.foodPairings,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      source: source ?? this.source,
    );
  }

  /// Display name: "Producer — Name" if producer exists, otherwise just name.
  String get displayName {
    if (producer != null && producer!.isNotEmpty) {
      return '$producer — $name';
    }
    return name;
  }

  /// Short label: "Name YYYY" or "Name NV".
  String get shortLabel {
    final v = vintage != null ? ' $vintage' : ' NV';
    return '$name$v';
  }

  bool get hasPosition =>
      cellarId != null && rackRow != null && rackColumn != null;

  bool get hasDrinkingWindow => drinkFrom != null || drinkUntil != null;

  bool get hasCharacteristics =>
      bodyScore != null ||
      tanninLevel != null ||
      acidityLevel != null ||
      sweetnessLevel != null;
}
