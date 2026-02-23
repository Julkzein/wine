class ScanResult {
  final String rawText;
  final String? producer;
  final String? wineName;
  final int? vintage;
  final double? alcoholContent;
  final String? appellation;
  final String? country;
  final String? wineType; // Raw string from API, not yet parsed to enum

  /// Overall confidence 0.0 – 1.0
  final double confidence;

  /// Per-field confidence indicators
  final Map<String, double> fieldConfidence;

  const ScanResult({
    required this.rawText,
    this.producer,
    this.wineName,
    this.vintage,
    this.alcoholContent,
    this.appellation,
    this.country,
    this.wineType,
    required this.confidence,
    this.fieldConfidence = const {},
  });

  bool get isHighConfidence => confidence >= 0.8;
  bool get isMediumConfidence => confidence >= 0.5 && confidence < 0.8;
  bool get isLowConfidence => confidence < 0.5;

  ScanResult copyWith({
    String? rawText,
    String? producer,
    String? wineName,
    int? vintage,
    double? alcoholContent,
    String? appellation,
    String? country,
    String? wineType,
    double? confidence,
    Map<String, double>? fieldConfidence,
  }) {
    return ScanResult(
      rawText: rawText ?? this.rawText,
      producer: producer ?? this.producer,
      wineName: wineName ?? this.wineName,
      vintage: vintage ?? this.vintage,
      alcoholContent: alcoholContent ?? this.alcoholContent,
      appellation: appellation ?? this.appellation,
      country: country ?? this.country,
      wineType: wineType ?? this.wineType,
      confidence: confidence ?? this.confidence,
      fieldConfidence: fieldConfidence ?? this.fieldConfidence,
    );
  }
}
