import '../../core/constants/wine_enums.dart';

class Cellar {
  final String id;
  final String name;
  final CellarType type;
  final int rows;
  final int columns;
  final int depth;
  final DateTime createdAt;

  const Cellar({
    required this.id,
    required this.name,
    required this.type,
    required this.rows,
    required this.columns,
    this.depth = 1,
    required this.createdAt,
  });

  int get totalSlots => rows * columns * depth;

  Cellar copyWith({
    String? id,
    String? name,
    CellarType? type,
    int? rows,
    int? columns,
    int? depth,
    DateTime? createdAt,
  }) {
    return Cellar(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      rows: rows ?? this.rows,
      columns: columns ?? this.columns,
      depth: depth ?? this.depth,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
