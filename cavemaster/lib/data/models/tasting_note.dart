class TastingNote {
  final String id;
  final String wineId;
  final DateTime date;
  final String? appearance;
  final String? nose;
  final String? palate;
  final String? finish;
  final String? notes;
  final double? rating;
  final String? photoPath;
  final String? occasion;
  final String? foodPaired;

  const TastingNote({
    required this.id,
    required this.wineId,
    required this.date,
    this.appearance,
    this.nose,
    this.palate,
    this.finish,
    this.notes,
    this.rating,
    this.photoPath,
    this.occasion,
    this.foodPaired,
  });

  TastingNote copyWith({
    String? id,
    String? wineId,
    DateTime? date,
    String? appearance,
    String? nose,
    String? palate,
    String? finish,
    String? notes,
    double? rating,
    String? photoPath,
    String? occasion,
    String? foodPaired,
  }) {
    return TastingNote(
      id: id ?? this.id,
      wineId: wineId ?? this.wineId,
      date: date ?? this.date,
      appearance: appearance ?? this.appearance,
      nose: nose ?? this.nose,
      palate: palate ?? this.palate,
      finish: finish ?? this.finish,
      notes: notes ?? this.notes,
      rating: rating ?? this.rating,
      photoPath: photoPath ?? this.photoPath,
      occasion: occasion ?? this.occasion,
      foodPaired: foodPaired ?? this.foodPaired,
    );
  }
}
