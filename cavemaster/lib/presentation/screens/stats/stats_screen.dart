import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/constants/wine_enums.dart';
import '../../../core/constants/wine_constants.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/database/daos/stats_dao.dart';
import '../../providers/database_provider.dart';
import '../../providers/wine_providers.dart';
import '../../widgets/common/empty_state.dart';

// ── Stats providers (defined inline for simplicity) ───────────────────────────

final _typeDistProvider = FutureProvider<List<WineTypeCount>>((ref) {
  return ref.watch(databaseProvider).statsDao.getTypeDistribution();
});

final _countryDistProvider = FutureProvider<List<CountryCount>>((ref) {
  return ref.watch(databaseProvider).statsDao.getCountryDistribution();
});

final _totalBottlesProvider = StreamProvider<int>((ref) {
  return ref.watch(databaseProvider).statsDao.watchTotalBottles();
});

final _totalValueProvider = StreamProvider<double>((ref) {
  return ref.watch(databaseProvider).statsDao.watchTotalValue();
});

final _drinkingStatusProvider = FutureProvider<Map<String, int>>((ref) {
  return ref.watch(databaseProvider).statsDao.getDrinkingStatusCounts();
});

// ─────────────────────────────────────────────────────────────────────────────

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winesAsync = ref.watch(winesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics', style: AppTypography.displayMedium),
      ),
      body: winesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (wines) {
          if (wines.isEmpty) {
            return const EmptyState(
              icon: Icons.bar_chart_outlined,
              title: 'No stats yet',
              message: 'Add wines to your collection\nto see statistics here.',
            );
          }
          return _StatsContent();
        },
      ),
    );
  }
}

class _StatsContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalBottles = ref.watch(_totalBottlesProvider);
    final totalValue = ref.watch(_totalValueProvider);
    final typesDist = ref.watch(_typeDistProvider);
    final countryDist = ref.watch(_countryDistProvider);
    final drinkingStatus = ref.watch(_drinkingStatusProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      children: [
        // ── Overview cards ─────────────────────────────────────────────────
        Row(
          children: [
            Expanded(
              child: _OverviewCard(
                label: 'Total Bottles',
                value: totalBottles.when(
                  data: (v) => v.toString(),
                  loading: () => '…',
                  error: (_, __) => '—',
                ),
                icon: Icons.wine_bar,
                color: AppColors.accentLight,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _OverviewCard(
                label: 'Est. Value',
                value: totalValue.when(
                  data: (v) => Formatters.price(v),
                  loading: () => '…',
                  error: (_, __) => '—',
                ),
                icon: Icons.euro_outlined,
                color: AppColors.success,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Type distribution donut ────────────────────────────────────────
        typesDist.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (types) => _TypeDonutCard(types: types),
        ),
        const SizedBox(height: 16),

        // ── Drinking status ────────────────────────────────────────────────
        drinkingStatus.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (counts) => _DrinkingStatusCard(counts: counts),
        ),
        const SizedBox(height: 16),

        // ── Country distribution ───────────────────────────────────────────
        countryDist.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const SizedBox.shrink(),
          data: (countries) =>
              countries.isEmpty ? const SizedBox.shrink() : _CountryBarCard(countries: countries),
        ),
      ],
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _OverviewCard(
      {required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 10),
          Text(value, style: AppTypography.displayMedium),
          Text(label, style: AppTypography.bodySecondary),
        ],
      ),
    );
  }
}

class _TypeDonutCard extends StatelessWidget {
  final List<WineTypeCount> types;
  const _TypeDonutCard({required this.types});

  @override
  Widget build(BuildContext context) {
    if (types.isEmpty) return const SizedBox.shrink();

    final total = types.fold<int>(0, (s, t) => s + t.count);

    final sections = types.map((t) {
      WineType? wineType;
      try {
        wineType = WineType.values.firstWhere((e) => e.name == t.type);
      } catch (_) {}
      final color = wineType != null
          ? WineTypeColors.forType(wineType)
          : AppColors.textDisabled;
      return PieChartSectionData(
        value: t.count.toDouble(),
        color: color,
        radius: 55,
        title: '${((t.count / total) * 100).toStringAsFixed(0)}%',
        titleStyle: const TextStyle(
          fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white,
        ),
      );
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('By Type', style: AppTypography.titleMedium),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                height: 160,
                width: 160,
                child: PieChart(PieChartData(
                  sections: sections,
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                )),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: types.map((t) {
                    WineType? wineType;
                    try {
                      wineType = WineType.values.firstWhere((e) => e.name == t.type);
                    } catch (_) {}
                    final color = wineType != null
                        ? WineTypeColors.forType(wineType)
                        : AppColors.textDisabled;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: [
                          Container(
                            width: 10, height: 10,
                            decoration: BoxDecoration(
                                color: color, shape: BoxShape.circle),
                          ),
                          const SizedBox(width: 8),
                          Text(wineType?.label ?? t.type,
                              style: AppTypography.bodySecondary),
                          const Spacer(),
                          Text('${t.count}',
                              style: AppTypography.labelMedium),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DrinkingStatusCard extends StatelessWidget {
  final Map<String, int> counts;
  const _DrinkingStatusCard({required this.counts});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Peak', counts['peak'] ?? 0, AppColors.success),
      ('Drink Now', counts['drinkNow'] ?? 0, AppColors.success),
      ('Drink Soon', counts['drinkSoon'] ?? 0, AppColors.warning),
      ('Keep Aging', counts['keepAging'] ?? 0, AppColors.info),
      ('Past Peak', counts['pastPeak'] ?? 0, AppColors.danger),
      ('Unknown', counts['unknown'] ?? 0, AppColors.textDisabled),
    ].where((e) => e.$2 > 0).toList();

    if (items.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Drinking Status', style: AppTypography.titleMedium),
          const SizedBox(height: 12),
          ...items.map((item) {
            final (label, count, color) = item;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                      width: 8, height: 8,
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle)),
                  const SizedBox(width: 10),
                  Expanded(child: Text(label, style: AppTypography.bodyMedium)),
                  Text('$count', style: AppTypography.labelMedium),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _CountryBarCard extends StatelessWidget {
  final List<CountryCount> countries;
  const _CountryBarCard({required this.countries});

  @override
  Widget build(BuildContext context) {
    final max = countries.map((c) => c.count).reduce((a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('By Country', style: AppTypography.titleMedium),
          const SizedBox(height: 12),
          ...countries.map((c) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    SizedBox(
                      width: 110,
                      child: Text(c.country,
                          style: AppTypography.bodySecondary,
                          overflow: TextOverflow.ellipsis),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: LinearProgressIndicator(
                            value: c.count / max,
                            backgroundColor: AppColors.surfaceSecondary,
                            valueColor: const AlwaysStoppedAnimation(AppColors.accent),
                            minHeight: 8,
                          ),
                        ),
                      ),
                    ),
                    Text('${c.count}', style: AppTypography.labelMedium),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
