import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/typography.dart';
import '../../../core/constants/wine_enums.dart';
import '../../../core/constants/wine_constants.dart';
import '../../../data/models/wine.dart';
import '../../../data/models/grape_composition.dart';
import '../../providers/wine_providers.dart';
import '../../providers/database_provider.dart';

class WineFormScreen extends ConsumerStatefulWidget {
  final String? editWineId;

  const WineFormScreen({super.key, this.editWineId});

  bool get isEditing => editWineId != null;

  @override
  ConsumerState<WineFormScreen> createState() => _WineFormScreenState();
}

class _WineFormScreenState extends ConsumerState<WineFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  bool _initialised = false;

  // Form state
  final _nameCtrl = TextEditingController();
  final _producerCtrl = TextEditingController();
  final _vintageCtrl = TextEditingController();
  final _countryCtrl = TextEditingController();
  final _regionCtrl = TextEditingController();
  final _appellationCtrl = TextEditingController();
  final _alcoholCtrl = TextEditingController();
  final _drinkFromCtrl = TextEditingController();
  final _drinkUntilCtrl = TextEditingController();
  final _peakFromCtrl = TextEditingController();
  final _peakUntilCtrl = TextEditingController();
  final _quantityCtrl = TextEditingController(text: '1');
  final _priceCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _tastingNotesCtrl = TextEditingController();
  final _personalNotesCtrl = TextEditingController();

  WineType _type = WineType.red;
  int? _bodyScore;
  int? _tanninLevel;
  int? _acidityLevel;
  int? _sweetnessLevel;
  double? _userRating;
  List<GrapeComposition> _grapes = [];
  List<String> _foodPairings = [];
  List<String> _tags = [];
  bool _isFavorite = false;
  String? _labelImagePath;
  DateTime? _purchaseDate;

  @override
  void dispose() {
    for (final c in [
      _nameCtrl, _producerCtrl, _vintageCtrl, _countryCtrl, _regionCtrl,
      _appellationCtrl, _alcoholCtrl, _drinkFromCtrl, _drinkUntilCtrl,
      _peakFromCtrl, _peakUntilCtrl, _quantityCtrl, _priceCtrl,
      _locationCtrl, _tastingNotesCtrl, _personalNotesCtrl,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (!widget.isEditing) _initialised = true;
  }

  void _populate(Wine wine) {
    if (_initialised) return;
    _nameCtrl.text = wine.name;
    _producerCtrl.text = wine.producer ?? '';
    _vintageCtrl.text = wine.vintage?.toString() ?? '';
    _countryCtrl.text = wine.country ?? '';
    _regionCtrl.text = wine.region ?? '';
    _appellationCtrl.text = wine.appellation ?? '';
    _alcoholCtrl.text = wine.alcoholContent?.toString() ?? '';
    _drinkFromCtrl.text = wine.drinkFrom?.toString() ?? '';
    _drinkUntilCtrl.text = wine.drinkUntil?.toString() ?? '';
    _peakFromCtrl.text = wine.peakFrom?.toString() ?? '';
    _peakUntilCtrl.text = wine.peakUntil?.toString() ?? '';
    _quantityCtrl.text = wine.quantity.toString();
    _priceCtrl.text = wine.purchasePrice?.toString() ?? '';
    _locationCtrl.text = wine.purchaseLocation ?? '';
    _tastingNotesCtrl.text = wine.tastingNotes ?? '';
    _personalNotesCtrl.text = wine.personalNotes ?? '';
    _type = wine.type;
    _bodyScore = wine.bodyScore;
    _tanninLevel = wine.tanninLevel;
    _acidityLevel = wine.acidityLevel;
    _sweetnessLevel = wine.sweetnessLevel;
    _userRating = wine.userRating;
    _grapes = List.from(wine.grapes);
    _foodPairings = List.from(wine.foodPairings);
    _tags = List.from(wine.tags);
    _isFavorite = wine.isFavorite;
    _labelImagePath = wine.labelImagePath;
    _purchaseDate = wine.purchaseDate;
    _initialised = true;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEditing) {
      final wineAsync = ref.watch(wineByIdProvider(widget.editWineId!));
      return wineAsync.when(
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
        error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
        data: (wine) {
          if (wine != null) _populate(wine);
          return _buildForm(context);
        },
      );
    }
    return _buildForm(context);
  }

  Widget _buildForm(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit Wine' : 'Add Wine'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: _loading ? null : _save,
            child: _loading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _LabelPhotoSection(
              imagePath: _labelImagePath,
              onPick: _pickImage,
            ),
            const SizedBox(height: 20),
            _FormSection(
              title: 'Basic Info',
              children: [
                _field(_nameCtrl, 'Wine Name *',
                    validator: (v) => v!.trim().isEmpty ? 'Required' : null),
                _field(_producerCtrl, 'Producer / Winery'),
                Row(
                  children: [
                    Expanded(
                      child: _field(_vintageCtrl, 'Vintage (year)',
                          keyboardType: TextInputType.number),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: _typeDropdown()),
                  ],
                ),
                _field(_quantityCtrl, 'Bottles in cellar',
                    keyboardType: TextInputType.number),
              ],
            ),
            const SizedBox(height: 16),
            _FormSection(
              title: 'Origin',
              children: [
                _autocompleteField(
                  controller: _countryCtrl,
                  label: 'Country',
                  options: WineConstants.countries,
                ),
                _field(_regionCtrl, 'Region'),
                _field(_appellationCtrl, 'Appellation'),
              ],
            ),
            const SizedBox(height: 16),
            _GrapeSection(
              grapes: _grapes,
              onChanged: (g) => setState(() => _grapes = g),
            ),
            const SizedBox(height: 16),
            _FormSection(
              title: 'Drinking Window',
              children: [
                Row(
                  children: [
                    Expanded(child: _field(_drinkFromCtrl, 'Drink from',
                        keyboardType: TextInputType.number)),
                    const SizedBox(width: 12),
                    Expanded(child: _field(_drinkUntilCtrl, 'Drink until',
                        keyboardType: TextInputType.number)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _field(_peakFromCtrl, 'Peak from',
                        keyboardType: TextInputType.number)),
                    const SizedBox(width: 12),
                    Expanded(child: _field(_peakUntilCtrl, 'Peak until',
                        keyboardType: TextInputType.number)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _CharacteristicsSection(
              body: _bodyScore,
              tannin: _tanninLevel,
              acidity: _acidityLevel,
              sweetness: _sweetnessLevel,
              alcohol: _alcoholCtrl,
              onChanged: ({body, tannin, acidity, sweetness}) => setState(() {
                if (body != null) _bodyScore = body;
                if (tannin != null) _tanninLevel = tannin;
                if (acidity != null) _acidityLevel = acidity;
                if (sweetness != null) _sweetnessLevel = sweetness;
              }),
            ),
            const SizedBox(height: 16),
            _FormSection(
              title: 'Purchase',
              children: [
                Row(
                  children: [
                    Expanded(child: _field(_priceCtrl, 'Price (€)',
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: true))),
                    const SizedBox(width: 12),
                    Expanded(child: _field(_locationCtrl, 'Purchased at')),
                  ],
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    _purchaseDate == null
                        ? 'Purchase date'
                        : 'Purchased: ${_purchaseDate!.day}/${_purchaseDate!.month}/${_purchaseDate!.year}',
                    style: _purchaseDate == null
                        ? AppTypography.bodySecondary
                        : AppTypography.bodyMedium,
                  ),
                  trailing: const Icon(Icons.calendar_today_outlined, size: 18),
                  onTap: _pickDate,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _FoodPairingsSection(
              selected: _foodPairings,
              onChanged: (p) => setState(() => _foodPairings = p),
            ),
            const SizedBox(height: 16),
            _FormSection(
              title: 'Notes & Rating',
              children: [
                _RatingRow(
                  value: _userRating,
                  onChanged: (v) => setState(() => _userRating = v),
                ),
                const SizedBox(height: 12),
                _field(_tastingNotesCtrl, 'Tasting notes',
                    maxLines: 3),
                _field(_personalNotesCtrl, 'Personal notes',
                    maxLines: 3),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String label,
      {TextInputType? keyboardType,
      int maxLines = 1,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: ctrl,
        decoration: InputDecoration(labelText: label),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: validator,
      ),
    );
  }

  Widget _typeDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<WineType>(
        value: _type,
        decoration: const InputDecoration(labelText: 'Type'),
        dropdownColor: AppColors.surfaceSecondary,
        items: WineType.values
            .map((t) => DropdownMenuItem(
                  value: t,
                  child: Text('${t.emoji} ${t.label}'),
                ))
            .toList(),
        onChanged: (v) => setState(() => _type = v ?? WineType.red),
      ),
    );
  }

  Widget _autocompleteField({
    required TextEditingController controller,
    required String label,
    required List<String> options,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Autocomplete<String>(
        optionsBuilder: (tv) {
          if (tv.text.isEmpty) return const [];
          return options.where(
            (o) => o.toLowerCase().contains(tv.text.toLowerCase()),
          );
        },
        onSelected: (s) => controller.text = s,
        fieldViewBuilder: (ctx, ctrl, fn, onSubmit) {
          // Sync external controller with autocomplete's internal one
          ctrl.text = controller.text;
          ctrl.addListener(() => controller.text = ctrl.text);
          return TextFormField(
            controller: ctrl,
            focusNode: fn,
            decoration: InputDecoration(labelText: label),
          );
        },
        optionsViewBuilder: (ctx, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: AppColors.surfaceSecondary,
            borderRadius: BorderRadius.circular(10),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: options.length.clamp(0, 5),
              itemBuilder: (ctx, i) {
                final opt = options.elementAt(i);
                return ListTile(
                  title: Text(opt, style: AppTypography.bodyMedium),
                  onTap: () => onSelected(opt),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (file != null) setState(() => _labelImagePath = file.path);
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _purchaseDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _purchaseDate = picked);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final now = DateTime.now();
    final wine = Wine(
      id: widget.isEditing ? widget.editWineId! : '',
      name: _nameCtrl.text.trim(),
      producer: _producerCtrl.text.trim().nullIfEmpty,
      vintage: int.tryParse(_vintageCtrl.text),
      type: _type,
      country: _countryCtrl.text.trim().nullIfEmpty,
      region: _regionCtrl.text.trim().nullIfEmpty,
      appellation: _appellationCtrl.text.trim().nullIfEmpty,
      alcoholContent: double.tryParse(_alcoholCtrl.text),
      drinkFrom: int.tryParse(_drinkFromCtrl.text),
      drinkUntil: int.tryParse(_drinkUntilCtrl.text),
      peakFrom: int.tryParse(_peakFromCtrl.text),
      peakUntil: int.tryParse(_peakUntilCtrl.text),
      bodyScore: _bodyScore,
      tanninLevel: _tanninLevel,
      acidityLevel: _acidityLevel,
      sweetnessLevel: _sweetnessLevel,
      quantity: int.tryParse(_quantityCtrl.text) ?? 1,
      purchasePrice: double.tryParse(_priceCtrl.text),
      purchaseLocation: _locationCtrl.text.trim().nullIfEmpty,
      purchaseDate: _purchaseDate,
      tastingNotes: _tastingNotesCtrl.text.trim().nullIfEmpty,
      personalNotes: _personalNotesCtrl.text.trim().nullIfEmpty,
      grapes: _grapes,
      foodPairings: _foodPairings,
      tags: _tags,
      isFavorite: _isFavorite,
      userRating: _userRating,
      labelImagePath: _labelImagePath,
      createdAt: now,
      updatedAt: now,
      source: WineSource.manual,
    );

    try {
      final repo = ref.read(wineRepositoryProvider);
      if (widget.isEditing) {
        await repo.update(wine);
      } else {
        await repo.add(wine);
      }
      if (mounted) context.pop();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _FormSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _FormSection({required this.title, required this.children});

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
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

class _LabelPhotoSection extends StatelessWidget {
  final String? imagePath;
  final VoidCallback onPick;
  const _LabelPhotoSection({this.imagePath, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPick,
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: AppColors.surfacePrimary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: imagePath != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(imagePath!, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholder()),
              )
            : _placeholder(),
      ),
    );
  }

  Widget _placeholder() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_a_photo_outlined,
              color: AppColors.textDisabled, size: 32),
          const SizedBox(height: 8),
          Text('Add label photo',
              style: AppTypography.bodySecondary),
        ],
      );
}

class _GrapeSection extends StatelessWidget {
  final List<GrapeComposition> grapes;
  final ValueChanged<List<GrapeComposition>> onChanged;
  const _GrapeSection({required this.grapes, required this.onChanged});

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Grape Varieties', style: AppTypography.titleMedium),
              IconButton(
                icon: const Icon(Icons.add, size: 20),
                onPressed: () => _addGrape(context),
              ),
            ],
          ),
          if (grapes.isEmpty)
            Text('No grapes added', style: AppTypography.bodySecondary)
          else
            ...grapes.asMap().entries.map((e) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(e.value.variety),
                  subtitle: e.value.percentage != null
                      ? Text('${e.value.percentage!.toStringAsFixed(0)}%')
                      : null,
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline, size: 18),
                    onPressed: () {
                      final updated = List<GrapeComposition>.from(grapes)
                        ..removeAt(e.key);
                      onChanged(updated);
                    },
                  ),
                )),
        ],
      ),
    );
  }

  void _addGrape(BuildContext context) {
    String variety = '';
    String percentage = '';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Grape'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Variety'),
              onChanged: (v) => variety = v,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Percentage (optional)'),
              keyboardType: TextInputType.number,
              onChanged: (v) => percentage = v,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (variety.trim().isEmpty) return;
              onChanged([
                ...grapes,
                GrapeComposition(
                  variety: variety.trim(),
                  percentage: double.tryParse(percentage),
                ),
              ]);
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class _CharacteristicsSection extends StatelessWidget {
  final int? body, tannin, acidity, sweetness;
  final TextEditingController alcohol;
  final void Function({int? body, int? tannin, int? acidity, int? sweetness}) onChanged;

  const _CharacteristicsSection({
    this.body, this.tannin, this.acidity, this.sweetness,
    required this.alcohol, required this.onChanged,
  });

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
          Text('Characteristics', style: AppTypography.titleMedium),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: TextFormField(
              controller: alcohol,
              decoration: const InputDecoration(labelText: 'Alcohol % vol'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
          ),
          _ScoreRow('Body', body, (v) => onChanged(body: v)),
          _ScoreRow('Tannins', tannin, (v) => onChanged(tannin: v)),
          _ScoreRow('Acidity', acidity, (v) => onChanged(acidity: v)),
          _ScoreRow('Sweetness', sweetness, (v) => onChanged(sweetness: v)),
        ],
      ),
    );
  }
}

class _ScoreRow extends StatelessWidget {
  final String label;
  final int? value;
  final ValueChanged<int> onChanged;
  const _ScoreRow(this.label, this.value, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: AppTypography.bodyMedium),
          ),
          ...List.generate(5, (i) {
            final selected = value != null && i < value!;
            return GestureDetector(
              onTap: () => onChanged(i + 1),
              child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Container(
                  width: 30,
                  height: 8,
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.accentLight
                        : AppColors.surfaceSecondary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _FoodPairingsSection extends StatelessWidget {
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;
  const _FoodPairingsSection({required this.selected, required this.onChanged});

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
          Text('Food Pairings', style: AppTypography.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: WineConstants.foodPairingOptions.map((p) {
              final sel = selected.contains(p);
              return FilterChip(
                label: Text(p),
                selected: sel,
                selectedColor: AppColors.accent.withOpacity(0.25),
                onSelected: (_) {
                  final updated = List<String>.from(selected);
                  sel ? updated.remove(p) : updated.add(p);
                  onChanged(updated);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _RatingRow extends StatelessWidget {
  final double? value;
  final ValueChanged<double?> onChanged;
  const _RatingRow({this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Rating ', style: AppTypography.bodyMedium),
        ...List.generate(5, (i) {
          return GestureDetector(
            onTap: () => onChanged(i + 1.0 == value ? null : i + 1.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                value != null && i < value! ? Icons.star : Icons.star_border,
                color: AppColors.wineDessert,
                size: 28,
              ),
            ),
          );
        }),
        if (value != null)
          Text(' $value', style: AppTypography.labelSmall),
      ],
    );
  }
}

extension on String {
  String? get nullIfEmpty => trim().isEmpty ? null : trim();
}
