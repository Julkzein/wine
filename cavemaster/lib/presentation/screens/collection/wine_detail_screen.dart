import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/constants/wine_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/wine.dart';
import '../../providers/wine_providers.dart';
import '../../providers/database_provider.dart';
import '../../widgets/wine/wine_type_badge.dart';
import '../../widgets/wine/drinking_timeline.dart';

class WineDetailScreen extends ConsumerWidget {
  final String wineId;
  const WineDetailScreen({super.key, required this.wineId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wineAsync = ref.watch(wineByIdProvider(wineId));

    return wineAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (wine) {
        if (wine == null) {
          return const Scaffold(body: Center(child: Text('Wine not found')));
        }
        return _WineDetailContent(wine: wine);
      },
    );
  }
}

class _WineDetailContent extends ConsumerWidget {
  final Wine wine;
  const _WineDetailContent({required this.wine});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _HeroAppBar(wine: wine, ref: ref),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _IdentityCard(wine: wine),
                  const SizedBox(height: 16),
                  _DrinkingWindowCard(wine: wine),
                  const SizedBox(height: 16),
                  if (wine.hasCharacteristics) ...[
                    _CharacteristicsCard(wine: wine),
                    const SizedBox(height: 16),
                  ],
                  if (wine.grapes.isNotEmpty) ...[
                    _GrapesCard(wine: wine),
                    const SizedBox(height: 16),
                  ],
                  if (wine.foodPairings.isNotEmpty) ...[
                    _PairingsCard(wine: wine),
                    const SizedBox(height: 16),
                  ],
                  _CollectionCard(wine: wine),
                  if (wine.personalNotes != null || wine.tastingNotes != null) ...[
                    const SizedBox(height: 16),
                    _NotesCard(wine: wine),
                  ],
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _ActionBar(wine: wine, ref: ref),
    );
  }
}

class _HeroAppBar extends StatelessWidget {
  final Wine wine;
  final WidgetRef ref;
  const _HeroAppBar({required this.wine, required this.ref});

  @override
  Widget build(BuildContext context) {
    final color = WineTypeColors.forType(wine.type);
    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: AppColors.background,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => context.pop(),
      ),
      actions: [
        IconButton(
          icon: Icon(
            wine.isFavorite ? Icons.favorite : Icons.favorite_border,
            color: wine.isFavorite ? AppColors.danger : null,
          ),
          onPressed: () => ref.read(wineRepositoryProvider).toggleFavorite(wine.id),
        ),
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => context.push('/collection/wine/${wine.id}/edit'),
        ),
        PopupMenuButton<String>(
          onSelected: (v) => _onMenuAction(context, ref, v),
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'delete', child: Text('Delete wine')),
          ],
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: wine.labelImagePath != null
            ? Image.file(File(wine.labelImagePath!), fit: BoxFit.cover)
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color.withOpacity(0.4), color.withOpacity(0.1)],
                  ),
                ),
                child: Center(
                  child: Icon(Icons.wine_bar, size: 80, color: color),
                ),
              ),
      ),
    );
  }

  void _onMenuAction(BuildContext context, WidgetRef ref, String action) async {
    if (action == 'delete') {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Delete wine?'),
          content: const Text('This will permanently remove it from your collection.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Delete'),
            ),
          ],
        ),
      );
      if (confirmed == true && context.mounted) {
        await ref.read(wineRepositoryProvider).delete(wine.id);
        if (context.mounted) context.pop();
      }
    }
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(title, style: AppTypography.titleMedium),
      );
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: child,
      );
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110,
              child: Text(label, style: AppTypography.bodySecondary),
            ),
            Expanded(child: Text(value, style: AppTypography.bodyMedium)),
          ],
        ),
      );
}

class _IdentityCard extends StatelessWidget {
  final Wine wine;
  const _IdentityCard({required this.wine});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(wine.name,
                    style: AppTypography.wineName, maxLines: 3),
              ),
              const SizedBox(width: 8),
              WineTypeBadge(type: wine.type),
            ],
          ),
          if (wine.producer != null) ...[
            const SizedBox(height: 4),
            Text(wine.producer!, style: AppTypography.bodySecondary),
          ],
          const Divider(height: 20),
          if (wine.vintage != null)
            _InfoRow('Vintage', wine.vintage.toString()),
          if (wine.country != null) _InfoRow('Country', wine.country!),
          if (wine.region != null) _InfoRow('Region', wine.region!),
          if (wine.subRegion != null) _InfoRow('Sub-region', wine.subRegion!),
          if (wine.appellation != null) _InfoRow('Appellation', wine.appellation!),
          if (wine.alcoholContent != null)
            _InfoRow('Alcohol', Formatters.alcohol(wine.alcoholContent)),
          if (wine.userRating != null)
            _InfoRow('My Rating', '${Formatters.rating(wine.userRating)} / 5'),
        ],
      ),
    );
  }
}

class _DrinkingWindowCard extends StatelessWidget {
  final Wine wine;
  const _DrinkingWindowCard({required this.wine});

  @override
  Widget build(BuildContext context) {
    return _Card(child: DrinkingTimeline(wine: wine));
  }
}

class _CharacteristicsCard extends StatelessWidget {
  final Wine wine;
  const _CharacteristicsCard({required this.wine});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Characteristics'),
          if (wine.bodyScore != null) _CharRow('Body', wine.bodyScore!),
          if (wine.tanninLevel != null) _CharRow('Tannins', wine.tanninLevel!),
          if (wine.acidityLevel != null) _CharRow('Acidity', wine.acidityLevel!),
          if (wine.sweetnessLevel != null) _CharRow('Sweetness', wine.sweetnessLevel!),
        ],
      ),
    );
  }
}

class _CharRow extends StatelessWidget {
  final String label;
  final int value; // 1-5
  const _CharRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: AppTypography.bodySecondary),
          ),
          Expanded(
            child: Row(
              children: List.generate(5, (i) {
                return Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Container(
                    width: 28,
                    height: 6,
                    decoration: BoxDecoration(
                      color: i < value
                          ? AppColors.accentLight
                          : AppColors.surfaceSecondary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                );
              }),
            ),
          ),
          Text('$value/5', style: AppTypography.labelSmall),
        ],
      ),
    );
  }
}

class _GrapesCard extends StatelessWidget {
  final Wine wine;
  const _GrapesCard({required this.wine});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Grape Varieties'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: wine.grapes.map((g) {
              return Chip(label: Text(g.toString()));
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _PairingsCard extends StatelessWidget {
  final Wine wine;
  const _PairingsCard({required this.wine});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Food Pairings'),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: wine.foodPairings
                .map((p) => Chip(label: Text(p)))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  final Wine wine;
  const _CollectionCard({required this.wine});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Collection'),
          _InfoRow('Bottles', Formatters.quantity(wine.quantity)),
          if (wine.purchasePrice != null)
            _InfoRow('Purchase Price', Formatters.price(wine.purchasePrice)),
          if (wine.purchaseDate != null)
            _InfoRow('Purchased', Formatters.date(wine.purchaseDate)),
          if (wine.purchaseLocation != null)
            _InfoRow('From', wine.purchaseLocation!),
          if (wine.cellarId != null)
            _InfoRow('Position',
                'Row ${(wine.rackRow ?? 0) + 1}, Col ${(wine.rackColumn ?? 0) + 1}'),
        ],
      ),
    );
  }
}

class _NotesCard extends StatelessWidget {
  final Wine wine;
  const _NotesCard({required this.wine});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle('Notes'),
          if (wine.tastingNotes != null && wine.tastingNotes!.isNotEmpty) ...[
            Text('Tasting', style: AppTypography.labelMedium),
            const SizedBox(height: 4),
            Text(wine.tastingNotes!, style: AppTypography.bodyMedium),
            if (wine.personalNotes != null) const SizedBox(height: 12),
          ],
          if (wine.personalNotes != null && wine.personalNotes!.isNotEmpty) ...[
            Text('Personal', style: AppTypography.labelMedium),
            const SizedBox(height: 4),
            Text(wine.personalNotes!, style: AppTypography.bodyMedium),
          ],
        ],
      ),
    );
  }
}

class _ActionBar extends ConsumerWidget {
  final Wine wine;
  final WidgetRef ref;
  const _ActionBar({required this.wine, required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Edit'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.divider),
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () =>
                    context.push('/collection/wine/${wine.id}/edit'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                icon: const Icon(Icons.wine_bar),
                label: Text(wine.quantity > 0
                    ? 'Drink (${wine.quantity} left)'
                    : 'No bottles left'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: wine.quantity > 0
                    ? () async {
                        HapticFeedback.mediumImpact();
                        await ref.read(wineRepositoryProvider).drink(wine.id);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Enjoyed a bottle of ${wine.name}'),
                            ),
                          );
                        }
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
