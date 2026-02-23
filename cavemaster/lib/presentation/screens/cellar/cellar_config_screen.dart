import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/constants/wine_enums.dart';
import '../../../data/models/cellar.dart';
import '../../providers/cellar_providers.dart';
import '../../providers/database_provider.dart';

class CellarConfigScreen extends ConsumerStatefulWidget {
  const CellarConfigScreen({super.key});

  @override
  ConsumerState<CellarConfigScreen> createState() => _CellarConfigScreenState();
}

class _CellarConfigScreenState extends ConsumerState<CellarConfigScreen> {
  final _nameCtrl = TextEditingController(text: 'My Cellar');
  CellarType _type = CellarType.wineRack;
  int _rows = 8;
  int _columns = 10;
  bool _saving = false;

  // Preset templates
  static const _presets = [
    (name: '5×10', rows: 5, cols: 10),
    (name: '8×10', rows: 8, cols: 10),
    (name: '8×12', rows: 8, cols: 12),
    (name: '4×6', rows: 4, cols: 6),
    (name: '6×6', rows: 6, cols: 6),
    (name: '12×12', rows: 12, cols: 12),
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cellarsAsync = ref.watch(cellarsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Set Up Cellar', style: AppTypography.displayMedium),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Section(
            title: 'Cellar Name',
            child: TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                hintText: 'e.g. Main Cellar, Kitchen Rack…',
              ),
            ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: 'Storage Type',
            child: Column(
              children: CellarType.values.map((t) {
                return RadioListTile<CellarType>(
                  value: t,
                  groupValue: _type,
                  title: Text(t.label),
                  activeColor: AppColors.accentLight,
                  contentPadding: EdgeInsets.zero,
                  onChanged: (v) => setState(() => _type = v!),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: 'Quick Templates',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _presets.map((p) {
                return ActionChip(
                  label: Text(p.name),
                  onPressed: () => setState(() {
                    _rows = p.rows;
                    _columns = p.cols;
                  }),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: 'Dimensions',
            child: Column(
              children: [
                _Stepper(
                  label: 'Rows',
                  value: _rows,
                  min: 1,
                  max: 30,
                  onChanged: (v) => setState(() => _rows = v),
                ),
                const SizedBox(height: 12),
                _Stepper(
                  label: 'Columns',
                  value: _columns,
                  min: 1,
                  max: 30,
                  onChanged: (v) => setState(() => _columns = v),
                ),
                const SizedBox(height: 8),
                Text(
                  'Total: ${_rows * _columns} slots',
                  style: AppTypography.bodySecondary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Existing cellars
          cellarsAsync.when(
            data: (cellars) {
              if (cellars.isEmpty) return const SizedBox.shrink();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Cellars', style: AppTypography.titleMedium),
                  const SizedBox(height: 8),
                  ...cellars.map(
                    (c) => ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(c.name),
                      subtitle: Text('${c.rows}×${c.columns} · ${c.type.label}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline, color: AppColors.danger),
                        onPressed: () => _deleteCellar(context, c.id),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Create Cellar'),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    if (_nameCtrl.text.trim().isEmpty) return;
    setState(() => _saving = true);

    final cellar = Cellar(
      id: '',
      name: _nameCtrl.text.trim(),
      type: _type,
      rows: _rows,
      columns: _columns,
      createdAt: DateTime.now(),
    );

    await ref.read(cellarRepositoryProvider).add(cellar);
    if (mounted) context.pop();
  }

  Future<void> _deleteCellar(BuildContext context, String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete cellar?'),
        content: const Text('All slot assignments will be lost.'),
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
    if (confirmed == true) {
      await ref.read(cellarRepositoryProvider).delete(id);
    }
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

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
          Text(title, style: AppTypography.titleMedium),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  final String label;
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;

  const _Stepper({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text(label, style: AppTypography.bodyMedium)),
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: value > min ? () => onChanged(value - 1) : null,
        ),
        SizedBox(
          width: 40,
          child: Text(value.toString(),
              style: AppTypography.titleMedium, textAlign: TextAlign.center),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: value < max ? () => onChanged(value + 1) : null,
        ),
      ],
    );
  }
}
