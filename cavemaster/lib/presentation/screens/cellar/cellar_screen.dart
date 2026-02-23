import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/constants/wine_constants.dart';
import '../../../data/models/cellar.dart';
import '../../../data/repositories/cellar_repository.dart';
import '../../providers/cellar_providers.dart';
import '../../providers/wine_providers.dart';
import '../../widgets/common/empty_state.dart';

class CellarScreen extends ConsumerWidget {
  const CellarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cellarsAsync = ref.watch(cellarsProvider);

    return cellarsAsync.when(
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (cellars) {
        if (cellars.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Cellar', style: AppTypography.displayMedium),
              actions: [_ConfigButton()],
            ),
            body: EmptyState(
              icon: Icons.grid_view_outlined,
              title: 'No cellar set up yet',
              message: 'Create your first cellar to start\nassigning bottles to slots.',
              actionLabel: 'Set Up Cellar',
              onAction: () => context.push('/cellar/config'),
            ),
          );
        }

        return _CellarContent(cellars: cellars);
      },
    );
  }
}

class _ConfigButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
        icon: const Icon(Icons.settings_outlined),
        onPressed: () => context.push('/cellar/config'),
      );
}

class _CellarContent extends ConsumerStatefulWidget {
  final List<Cellar> cellars;
  const _CellarContent({required this.cellars});

  @override
  ConsumerState<_CellarContent> createState() => _CellarContentState();
}

class _CellarContentState extends ConsumerState<_CellarContent> {
  late String _selectedCellarId;

  @override
  void initState() {
    super.initState();
    _selectedCellarId = widget.cellars.first.id;
  }

  @override
  Widget build(BuildContext context) {
    final cellarAsync = ref.watch(cellarWithSlotsProvider(_selectedCellarId));
    final winesAsync = ref.watch(winesProvider);

    return Scaffold(
      appBar: AppBar(
        title: widget.cellars.length == 1
            ? Text(widget.cellars.first.name, style: AppTypography.displayMedium)
            : DropdownButton<String>(
                value: _selectedCellarId,
                style: AppTypography.displayMedium,
                underline: const SizedBox.shrink(),
                dropdownColor: AppColors.surfaceSecondary,
                items: widget.cellars
                    .map((c) => DropdownMenuItem(value: c.id, child: Text(c.name)))
                    .toList(),
                onChanged: (id) {
                  if (id != null) setState(() => _selectedCellarId = id);
                },
              ),
        actions: [_ConfigButton()],
      ),
      body: cellarAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (cellarWithSlots) {
          if (cellarWithSlots == null) {
            return const Center(child: Text('Cellar not found'));
          }

          final wineMap = winesAsync.when(
            data: (wines) => {for (final w in wines) w.id: w},
            loading: () => <String, dynamic>{},
            error: (_, __) => <String, dynamic>{},
          );

          return _CellarGrid(
            cellarWithSlots: cellarWithSlots,
            wineMap: wineMap,
          );
        },
      ),
    );
  }
}

class _CellarGrid extends StatelessWidget {
  final CellarWithSlots cellarWithSlots;
  final Map<String, dynamic> wineMap;

  const _CellarGrid({required this.cellarWithSlots, required this.wineMap});

  @override
  Widget build(BuildContext context) {
    final cellar = cellarWithSlots.cellar;

    return Column(
      children: [
        // Stats bar
        Container(
          color: AppColors.surfacePrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              _StatChip(
                  label: 'Occupied',
                  value: '${cellarWithSlots.occupiedSlots}',
                  color: AppColors.accentLight),
              const SizedBox(width: 12),
              _StatChip(
                  label: 'Empty',
                  value: '${cellarWithSlots.emptySlots}',
                  color: AppColors.textSecondary),
              const SizedBox(width: 12),
              _StatChip(
                  label: 'Total',
                  value: '${cellar.totalSlots}',
                  color: AppColors.textSecondary),
            ],
          ),
        ),
        // Grid
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: List.generate(cellar.rows, (row) {
                return Row(
                  children: List.generate(cellar.columns, (col) {
                    final slot = cellarWithSlots.slotAt(row, col);
                    final wine = slot?.wineId != null
                        ? wineMap[slot!.wineId]
                        : null;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: _SlotCell(
                          row: row,
                          col: col,
                          wine: wine,
                          isBlocked: slot?.isBlocked ?? false,
                          onTap: () => _onSlotTap(context, row, col, slot?.wineId),
                        ),
                      ),
                    );
                  }),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  void _onSlotTap(
      BuildContext context, int row, int col, String? currentWineId) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text('Row ${row + 1}, Column ${col + 1}',
                style: AppTypography.titleMedium),
            const SizedBox(height: 8),
            if (currentWineId != null) ...[
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('View wine'),
                onTap: () {
                  Navigator.pop(ctx);
                  // Navigate to wine detail
                },
              ),
              ListTile(
                leading: const Icon(Icons.remove_circle_outline),
                title: const Text('Remove from slot'),
                onTap: () => Navigator.pop(ctx),
              ),
            ] else
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Assign a wine'),
                onTap: () => Navigator.pop(ctx),
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _SlotCell extends StatelessWidget {
  final int row;
  final int col;
  final dynamic wine;
  final bool isBlocked;
  final VoidCallback? onTap;

  const _SlotCell({
    required this.row,
    required this.col,
    this.wine,
    this.isBlocked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isBlocked) {
      return Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surfaceSecondary.withOpacity(0.3),
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }

    Color color;
    if (wine == null) {
      color = AppColors.surfaceSecondary;
    } else {
      color = WineTypeColors.forType(wine.type);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(wine == null ? 0.3 : 0.7),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 0.5,
          ),
        ),
        child: wine == null
            ? null
            : Center(
                child: Icon(Icons.wine_bar,
                    size: 14,
                    color: WineTypeColors.textColorForType(wine.type)),
              ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: AppTypography.titleMedium.copyWith(color: color)),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}
