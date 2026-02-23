import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/constants/wine_enums.dart';
import '../../../core/constants/wine_constants.dart';
import '../../../data/models/wine.dart';
import '../../providers/wine_providers.dart';
import '../../providers/database_provider.dart';
import '../../widgets/wine/wine_card.dart';
import '../../widgets/common/empty_state.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredAsync = ref.watch(filteredWinesProvider);
    final viewMode = ref.watch(collectionViewModeProvider);
    final filter = ref.watch(collectionFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Collection', style: AppTypography.displayMedium),
        actions: [
          // View mode toggle
          IconButton(
            icon: Icon(viewMode == CollectionViewMode.grid
                ? Icons.view_list_outlined
                : Icons.grid_view_outlined),
            onPressed: () => ref
                .read(collectionViewModeProvider.notifier)
                .state = viewMode == CollectionViewMode.grid
                ? CollectionViewMode.list
                : CollectionViewMode.grid,
          ),
          // Filter
          IconButton(
            icon: Badge(
              isLabelVisible: filter.isActive,
              backgroundColor: AppColors.accent,
              child: const Icon(Icons.tune_outlined),
            ),
            onPressed: () => _showFilterSheet(context, ref),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: _SearchBar(ref: ref),
        ),
      ),
      body: filteredAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (wines) {
          if (wines.isEmpty) {
            final query = ref.watch(searchQueryProvider);
            return EmptyState(
              icon: Icons.wine_bar_outlined,
              title: query.isNotEmpty ? 'No results' : 'Your cellar is empty',
              message: query.isNotEmpty
                  ? 'No wines match "$query"'
                  : 'Start by adding your first wine using the + button.',
            );
          }
          return _WineList(wines: wines, viewMode: viewMode, ref: ref);
        },
      ),
    );
  }

  void _showFilterSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _FilterSheet(ref: ref),
    );
  }
}

class _SearchBar extends StatefulWidget {
  final WidgetRef ref;
  const _SearchBar({required this.ref});

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search wines, producers, regions…',
          prefixIcon: const Icon(Icons.search, size: 20),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () {
                    _controller.clear();
                    widget.ref.read(searchQueryProvider.notifier).state = '';
                  },
                )
              : null,
        ),
        onChanged: (value) {
          widget.ref.read(searchQueryProvider.notifier).state = value;
        },
      ),
    );
  }
}

class _WineList extends StatelessWidget {
  final List<Wine> wines;
  final CollectionViewMode viewMode;
  final WidgetRef ref;

  const _WineList({
    required this.wines,
    required this.viewMode,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    // Sort picker at top
    return Column(
      children: [
        _SortChips(ref: ref),
        Expanded(
          child: viewMode == CollectionViewMode.grid
              ? _GridView(wines: wines, ref: ref)
              : _ListView(wines: wines, ref: ref),
        ),
      ],
    );
  }
}

class _GridView extends StatelessWidget {
  final List<Wine> wines;
  final WidgetRef ref;

  const _GridView({required this.wines, required this.ref});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 100),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemCount: wines.length,
      itemBuilder: (context, i) => WineCard(
        wine: wines[i],
        onDrink: () => _drinkWine(context, ref, wines[i]),
        onDelete: () => _deleteWine(ref, wines[i].id),
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  final List<Wine> wines;
  final WidgetRef ref;

  const _ListView({required this.wines, required this.ref});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 100),
      itemCount: wines.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, i) => WineListTile(
        wine: wines[i],
        onDrink: () => _drinkWine(context, ref, wines[i]),
        onDelete: () => _deleteWine(ref, wines[i].id),
      ),
    );
  }
}

class _SortChips extends ConsumerWidget {
  final WidgetRef ref;
  const _SortChips({required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSort = ref.watch(collectionSortProvider);
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: WineSortField.values.map((field) {
          final selected = currentSort == field;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(field.label),
              selected: selected,
              selectedColor: AppColors.accent.withOpacity(0.3),
              checkmarkColor: AppColors.accentLight,
              onSelected: (_) =>
                  ref.read(collectionSortProvider.notifier).state = field,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _FilterSheet extends ConsumerWidget {
  final WidgetRef ref;
  const _FilterSheet({required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(collectionFilterProvider);

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (ctx, sc) => Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          controller: sc,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Filter', style: AppTypography.titleLarge),
                if (filter.isActive)
                  TextButton(
                    onPressed: () => ref
                        .read(collectionFilterProvider.notifier)
                        .state = const CollectionFilter(),
                    child: const Text('Clear all'),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Wine Type', style: AppTypography.labelMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: WineType.values.map((type) {
                final selected = filter.type == type;
                return FilterChip(
                  label: Text('${type.emoji} ${type.label}'),
                  selected: selected,
                  selectedColor: AppColors.accent.withOpacity(0.3),
                  onSelected: (_) {
                    ref.read(collectionFilterProvider.notifier).state =
                        filter.copyWith(type: selected ? null : type);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            Text('Country', style: AppTypography.labelMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: WineConstants.countries.take(10).map((country) {
                final selected = filter.country == country;
                return FilterChip(
                  label: Text(country),
                  selected: selected,
                  selectedColor: AppColors.accent.withOpacity(0.3),
                  onSelected: (_) {
                    ref.read(collectionFilterProvider.notifier).state =
                        filter.copyWith(country: selected ? null : country);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Favourites only'),
              value: filter.favoritesOnly,
              activeColor: AppColors.accentLight,
              contentPadding: EdgeInsets.zero,
              onChanged: (v) {
                ref.read(collectionFilterProvider.notifier).state =
                    filter.copyWith(favoritesOnly: v);
              },
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Apply'),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

void _drinkWine(BuildContext context, WidgetRef ref, Wine wine) async {
  if (wine.quantity <= 0) return;
  await ref.read(wineRepositoryProvider).drink(wine.id);
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Enjoyed a bottle of ${wine.name}'),
        action: SnackBarAction(label: 'Log note', onPressed: () {}),
      ),
    );
  }
}

void _deleteWine(WidgetRef ref, String id) {
  ref.read(wineRepositoryProvider).delete(id);
}
