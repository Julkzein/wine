class GrapeComposition {
  final String variety;
  final double? percentage;

  const GrapeComposition({required this.variety, this.percentage});

  GrapeComposition copyWith({String? variety, double? percentage}) {
    return GrapeComposition(
      variety: variety ?? this.variety,
      percentage: percentage ?? this.percentage,
    );
  }

  Map<String, dynamic> toJson() => {
        'variety': variety,
        'percentage': percentage,
      };

  factory GrapeComposition.fromJson(Map<String, dynamic> json) {
    return GrapeComposition(
      variety: json['variety'] as String,
      percentage: (json['percentage'] as num?)?.toDouble(),
    );
  }

  @override
  String toString() {
    if (percentage != null) return '${percentage!.toStringAsFixed(0)}% $variety';
    return variety;
  }
}
