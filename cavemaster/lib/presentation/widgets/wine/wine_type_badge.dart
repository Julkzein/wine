import 'package:flutter/material.dart';
import '../../../core/constants/wine_enums.dart';
import '../../../core/constants/wine_constants.dart';

class WineTypeBadge extends StatelessWidget {
  final WineType type;
  final bool compact;

  const WineTypeBadge({super.key, required this.type, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final bg = WineTypeColors.forType(type);
    final fg = WineTypeColors.textColorForType(type);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        compact ? type.emoji : '${type.emoji} ${type.label}',
        style: TextStyle(
          color: fg,
          fontSize: compact ? 11 : 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
