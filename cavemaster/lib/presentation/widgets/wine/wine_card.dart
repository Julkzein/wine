import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/constants/wine_enums.dart';
import '../../../core/constants/wine_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/wine.dart';
import '../../../data/services/recommendation_service.dart';
import 'wine_type_badge.dart';

class WineCard extends StatelessWidget {
  final Wine wine;
  final VoidCallback? onDrink;
  final VoidCallback? onDelete;

  const WineCard({
    super.key,
    required this.wine,
    this.onDrink,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(wine.id),
      background: _SwipeBackground(
        color: AppColors.success,
        icon: Icons.wine_bar,
        label: 'Drink',
        alignment: Alignment.centerLeft,
      ),
      secondaryBackground: _SwipeBackground(
        color: AppColors.danger,
        icon: Icons.delete_outline,
        label: 'Delete',
        alignment: Alignment.centerRight,
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          HapticFeedback.mediumImpact();
          onDrink?.call();
          return false; // Don't actually dismiss — just log the drink
        } else {
          return await _confirmDelete(context);
        }
      },
      onDismissed: (_) => onDelete?.call(),
      child: GestureDetector(
        onTap: () => context.push('/collection/wine/${wine.id}'),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfacePrimary,
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label image / placeholder
              Expanded(child: _LabelImage(wine: wine)),
              // Info section
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WineTypeBadge(type: wine.type, compact: true),
                    const SizedBox(height: 6),
                    Text(
                      wine.name,
                      style: AppTypography.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (wine.producer != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        wine.producer!,
                        style: AppTypography.bodySecondary,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Formatters.vintage(wine.vintage),
                          style: AppTypography.labelSmall,
                        ),
                        if (wine.quantity > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceSecondary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '×${wine.quantity}',
                              style: AppTypography.labelSmall.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (wine.hasDrinkingWindow) ...[
                      const SizedBox(height: 4),
                      _DrinkingStatusDot(wine: wine),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete wine?'),
        content: Text('Remove "${wine.name}" from your collection?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

class _LabelImage extends StatelessWidget {
  final Wine wine;
  const _LabelImage({required this.wine});

  @override
  Widget build(BuildContext context) {
    if (wine.labelImagePath != null) {
      return Image.file(
        File(wine.labelImagePath!),
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (_, __, ___) => _Placeholder(type: wine.type),
      );
    }
    return _Placeholder(type: wine.type);
  }
}

class _Placeholder extends StatelessWidget {
  final WineType type;
  const _Placeholder({required this.type});

  @override
  Widget build(BuildContext context) {
    final color = WineTypeColors.forType(type);
    return Container(
      width: double.infinity,
      color: color.withOpacity(0.2),
      child: Center(
        child: Icon(
          Icons.wine_bar,
          size: 36,
          color: color,
        ),
      ),
    );
  }
}

class _DrinkingStatusDot extends StatelessWidget {
  final Wine wine;
  const _DrinkingStatusDot({required this.wine});

  @override
  Widget build(BuildContext context) {
    final service = RecommendationService();
    final status = service.getDrinkingStatus(wine);
    final color = DrinkingStatusColors.forStatus(status);

    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(status.label,
            style: AppTypography.caption.copyWith(color: color)),
      ],
    );
  }
}

class _SwipeBackground extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final Alignment alignment;

  const _SwipeBackground({
    required this.color,
    required this.icon,
    required this.label,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          Text(label,
              style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// ── List variant ─────────────────────────────────────────────────────────────

class WineListTile extends StatelessWidget {
  final Wine wine;
  final VoidCallback? onDrink;
  final VoidCallback? onDelete;

  const WineListTile({
    super.key,
    required this.wine,
    this.onDrink,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey('list_${wine.id}'),
      background: _SwipeBackground(
        color: AppColors.success,
        icon: Icons.wine_bar,
        label: 'Drink',
        alignment: Alignment.centerLeft,
      ),
      secondaryBackground: _SwipeBackground(
        color: AppColors.danger,
        icon: Icons.delete_outline,
        label: 'Delete',
        alignment: Alignment.centerRight,
      ),
      confirmDismiss: (dir) async {
        if (dir == DismissDirection.startToEnd) {
          HapticFeedback.mediumImpact();
          onDrink?.call();
          return false;
        }
        return true;
      },
      onDismissed: (_) => onDelete?.call(),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: _SmallLabel(wine: wine),
        title: Text(wine.name,
            style: AppTypography.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          [wine.producer, Formatters.vintage(wine.vintage)]
              .where((s) => s != null && s.isNotEmpty)
              .join(' · '),
          style: AppTypography.bodySecondary,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            WineTypeBadge(type: wine.type, compact: true),
            const SizedBox(width: 8),
            Text('×${wine.quantity}', style: AppTypography.labelSmall),
          ],
        ),
        onTap: () => context.push('/collection/wine/${wine.id}'),
      ),
    );
  }
}

class _SmallLabel extends StatelessWidget {
  final Wine wine;
  const _SmallLabel({required this.wine});

  @override
  Widget build(BuildContext context) {
    if (wine.labelImagePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(wine.labelImagePath!),
          width: 44,
          height: 60,
          fit: BoxFit.cover,
        ),
      );
    }
    final color = WineTypeColors.forType(wine.type);
    return Container(
      width: 44,
      height: 60,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(Icons.wine_bar, color: color, size: 20),
    );
  }
}
