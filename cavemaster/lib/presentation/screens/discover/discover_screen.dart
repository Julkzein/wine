import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/constants/wine_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/wine.dart';
import '../../../data/services/recommendation_service.dart';
import '../../providers/recommendation_providers.dart';
import '../../widgets/wine/wine_type_badge.dart';

class DiscoverScreen extends ConsumerWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pick = ref.watch(tonightsPickProvider);
    final drinkNow = ref.watch(drinkNowProvider);
    final drinkSoon = ref.watch(drinkSoonProvider);
    final keepAging = ref.watch(keepAgingProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Discover', style: AppTypography.displayMedium),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.format_list_bulleted, size: 18),
            label: const Text('Wishlist'),
            onPressed: () => context.push('/discover/wishlist'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        children: [
          // Tonight's Pick
          _SectionHeader(
            title: "Tonight's Pick",
            emoji: '🍾',
          ),
          const SizedBox(height: 8),
          pick.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => const SizedBox.shrink(),
            data: (wine) => wine == null
                ? _EmptySection(
                    message: 'Add wines with drinking window data\nto get personalised picks',
                  )
                : _TonightsPickCard(wine: wine),
          ),
          const SizedBox(height: 28),

          // Drink Now
          _SectionHeader(
            title: 'Drink Now',
            emoji: '🟢',
            color: AppColors.success,
          ),
          const SizedBox(height: 8),
          drinkNow.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => const SizedBox.shrink(),
            data: (wines) => wines.isEmpty
                ? _EmptySection(message: 'No wines currently in their window')
                : _HorizontalWineList(wines: wines),
          ),
          const SizedBox(height: 28),

          // Drink Soon
          _SectionHeader(
            title: 'Drink Soon',
            emoji: '🟡',
            color: AppColors.warning,
          ),
          const SizedBox(height: 8),
          drinkSoon.when(
            loading: () => const SizedBox.shrink(),
            error: (e, _) => const SizedBox.shrink(),
            data: (wines) => wines.isEmpty
                ? _EmptySection(message: 'No wines approaching their window')
                : _VerticalWineList(wines: wines, statusColor: AppColors.warning),
          ),
          const SizedBox(height: 28),

          // Keep Aging
          _SectionHeader(
            title: 'Keep Aging',
            emoji: '🔵',
            color: AppColors.info,
          ),
          const SizedBox(height: 8),
          keepAging.when(
            loading: () => const SizedBox.shrink(),
            error: (e, _) => const SizedBox.shrink(),
            data: (wines) => wines.isEmpty
                ? _EmptySection(message: 'No wines currently aging')
                : _VerticalWineList(wines: wines, statusColor: AppColors.info),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String emoji;
  final Color? color;
  const _SectionHeader({required this.title, required this.emoji, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 8),
        Text(title,
            style: AppTypography.titleLarge
                .copyWith(color: color ?? AppColors.textPrimary)),
      ],
    );
  }
}

class _EmptySection extends StatelessWidget {
  final String message;
  const _EmptySection({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(message,
          style: AppTypography.bodySecondary, textAlign: TextAlign.center),
    );
  }
}

class _TonightsPickCard extends StatelessWidget {
  final Wine wine;
  const _TonightsPickCard({required this.wine});

  @override
  Widget build(BuildContext context) {
    final service = RecommendationService();
    final status = service.getDrinkingStatus(wine);
    final statusColor = DrinkingStatusColors.forStatus(status);
    final typeColor = WineTypeColors.forType(wine.type);

    return GestureDetector(
      onTap: () => context.push('/collection/wine/${wine.id}'),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              typeColor.withOpacity(0.35),
              typeColor.withOpacity(0.1),
            ],
          ),
        ),
        child: Row(
          children: [
            // Label image or placeholder
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              child: SizedBox(
                width: 110,
                child: wine.labelImagePath != null
                    ? Image.file(File(wine.labelImagePath!), fit: BoxFit.cover)
                    : Container(
                        color: typeColor.withOpacity(0.2),
                        child: Center(
                            child: Icon(Icons.wine_bar,
                                size: 48, color: typeColor)),
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WineTypeBadge(type: wine.type),
                    const SizedBox(height: 8),
                    Text(wine.name,
                        style: AppTypography.wineName, maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                    if (wine.producer != null) ...[
                      const SizedBox(height: 2),
                      Text(wine.producer!, style: AppTypography.bodySecondary,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          width: 8, height: 8,
                          decoration: BoxDecoration(
                            color: statusColor, shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(status.label,
                            style: AppTypography.labelSmall
                                .copyWith(color: statusColor)),
                        const Spacer(),
                        Text(Formatters.vintage(wine.vintage),
                            style: AppTypography.labelSmall),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HorizontalWineList extends StatelessWidget {
  final List<Wine> wines;
  const _HorizontalWineList({required this.wines});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: wines.length,
        itemBuilder: (ctx, i) {
          final wine = wines[i];
          final typeColor = WineTypeColors.forType(wine.type);
          return GestureDetector(
            onTap: () => context.push('/collection/wine/${wine.id}'),
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: AppColors.surfacePrimary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: wine.labelImagePath != null
                          ? Image.file(File(wine.labelImagePath!),
                              fit: BoxFit.cover, width: double.infinity)
                          : Container(
                              color: typeColor.withOpacity(0.2),
                              child: Icon(Icons.wine_bar, color: typeColor),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(wine.name,
                            style: AppTypography.labelMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        Text(Formatters.vintage(wine.vintage),
                            style: AppTypography.caption),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _VerticalWineList extends StatelessWidget {
  final List<Wine> wines;
  final Color statusColor;
  const _VerticalWineList({required this.wines, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: wines.take(5).map((wine) {
        return GestureDetector(
          onTap: () => context.push('/collection/wine/${wine.id}'),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surfacePrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(wine.name,
                          style: AppTypography.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      Text(
                        [wine.producer, Formatters.vintage(wine.vintage)]
                            .where((s) => s != null && s.isNotEmpty)
                            .join(' · '),
                        style: AppTypography.bodySecondary,
                      ),
                    ],
                  ),
                ),
                if (wine.drinkUntil != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Until', style: AppTypography.caption),
                      Text(wine.drinkUntil.toString(),
                          style: AppTypography.labelMedium
                              .copyWith(color: statusColor)),
                    ],
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
