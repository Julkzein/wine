import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/typography.dart';
import '../../widgets/common/empty_state.dart';

// Wishlist is Phase MVP — basic stub with provider wired up.
// Full implementation follows the same pattern as wines.

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Wishlist', style: AppTypography.displayMedium)),
      body: const EmptyState(
        icon: Icons.bookmark_border_outlined,
        title: 'Your wishlist is empty',
        message: 'Save wines you want to buy.\nThey\'ll appear here.',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    // Wishlist add dialog — minimal for now
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add to Wishlist'),
        content: const Text('Wishlist entries will be added in the next update.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
