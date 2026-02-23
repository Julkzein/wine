class WishlistEntry {
  final String id;
  final String name;
  final String? producer;
  final int? vintage;
  final double? estimatedPrice;
  final int priority; // 0 = low, 1 = medium, 2 = high
  final String? notes;
  final DateTime createdAt;

  const WishlistEntry({
    required this.id,
    required this.name,
    this.producer,
    this.vintage,
    this.estimatedPrice,
    this.priority = 0,
    this.notes,
    required this.createdAt,
  });

  String get priorityLabel => switch (priority) {
        2 => 'High',
        1 => 'Medium',
        _ => 'Low',
      };

  WishlistEntry copyWith({
    String? id,
    String? name,
    String? producer,
    int? vintage,
    double? estimatedPrice,
    int? priority,
    String? notes,
    DateTime? createdAt,
  }) {
    return WishlistEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      producer: producer ?? this.producer,
      vintage: vintage ?? this.vintage,
      estimatedPrice: estimatedPrice ?? this.estimatedPrice,
      priority: priority ?? this.priority,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
