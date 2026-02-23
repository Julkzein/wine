import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/colors.dart';

class AppScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: _BottomNav(navigationShell: navigationShell),
      floatingActionButton: _GlobalFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class _BottomNav extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const _BottomNav({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surfacePrimary,
        border: Border(top: BorderSide(color: AppColors.divider, width: 0.5)),
      ),
      child: NavigationBar(
        backgroundColor: AppColors.surfacePrimary,
        indicatorColor: AppColors.accent.withOpacity(0.2),
        selectedIndex: navigationShell.currentIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.wine_bar_outlined),
            selectedIcon: Icon(Icons.wine_bar, color: AppColors.accentLight),
            label: 'Collection',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view, color: AppColors.accentLight),
            label: 'Cellar',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore, color: AppColors.accentLight),
            label: 'Discover',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart, color: AppColors.accentLight),
            label: 'Stats',
          ),
        ],
      ),
    );
  }
}

class _GlobalFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddOptions(context),
      tooltip: 'Add wine',
      child: const Icon(Icons.add, size: 28),
    );
  }

  void _showAddOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textDisabled,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.camera_alt_outlined, color: AppColors.accentLight),
              ),
              title: const Text('Scan Label',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Take a photo of the wine label'),
              onTap: () {
                Navigator.pop(ctx);
                // TODO Phase 2: context.push('/scan');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Label scanning coming in Phase 2')),
                );
              },
            ),
            ListTile(
              leading: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.edit_outlined, color: AppColors.accentLight),
              ),
              title: const Text('Add Manually',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: const Text('Fill in the wine details yourself'),
              onTap: () {
                Navigator.pop(ctx);
                context.push('/wine/add');
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
