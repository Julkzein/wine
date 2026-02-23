import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: AppTypography.displayMedium),
      ),
      body: ListView(
        children: [
          _SectionHeader('Collection'),
          _Tile(
            icon: Icons.import_export_outlined,
            title: 'Import / Export',
            subtitle: 'CSV import and export — coming soon',
            onTap: () {},
          ),
          _SectionHeader('Appearance'),
          _Tile(
            icon: Icons.dark_mode_outlined,
            title: 'Theme',
            subtitle: 'Dark mode (default)',
            onTap: () {},
          ),
          _SectionHeader('Notifications'),
          _Tile(
            icon: Icons.notifications_outlined,
            title: 'Drinking window alerts',
            subtitle: 'Get notified when wines are ready — coming soon',
            onTap: () {},
          ),
          _SectionHeader('Cloud Backup'),
          _Tile(
            icon: Icons.cloud_upload_outlined,
            title: 'Sync to cloud',
            subtitle: 'Supabase backup — coming in Phase 5',
            onTap: () {},
          ),
          _SectionHeader('About'),
          _Tile(
            icon: Icons.info_outline,
            title: 'CaveMaster',
            subtitle: 'Version 1.0.0',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
      child: Text(title.toUpperCase(), style: AppTypography.caption),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _Tile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.surfaceSecondary,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(icon, size: 20),
      ),
      title: Text(title, style: AppTypography.bodyMedium),
      subtitle: Text(subtitle, style: AppTypography.caption),
      trailing: const Icon(Icons.chevron_right, size: 18),
      onTap: onTap,
    );
  }
}
