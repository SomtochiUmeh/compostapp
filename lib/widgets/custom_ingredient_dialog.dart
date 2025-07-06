import 'package:flutter/material.dart';
import '../models/compost_component_model.dart';
import '../models/nutrient_content_model.dart';
import '../models/price_model.dart';
import 'custom_text_field.dart';
import '../generated/l10n.dart';

class CustomIngredientDialog extends StatefulWidget {
  final Function(CompostComponent) onAdd;

  const CustomIngredientDialog({
    super.key,
    required this.onAdd,
  });

  @override
  State<CustomIngredientDialog> createState() => _CustomIngredientDialogState();
}

class _CustomIngredientDialogState extends State<CustomIngredientDialog> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  // Nutrient controllers
  final _dryMatterController = TextEditingController();
  final _organicCarbonController = TextEditingController();
  final _nitrogenController = TextEditingController();
  final _phosphorusController = TextEditingController();
  final _potassiumController = TextEditingController();
  final _calciumController = TextEditingController();
  final _magnesiumController = TextEditingController();
  final _carbonNitrogenController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _dryMatterController.dispose();
    _organicCarbonController.dispose();
    _nitrogenController.dispose();
    _phosphorusController.dispose();
    _potassiumController.dispose();
    _calciumController.dispose();
    _magnesiumController.dispose();
    _carbonNitrogenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).addCustomIngredient),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              labelText: S.of(context).ingredientName,
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: S.of(context).pricePerTonCFA,
              controller: _priceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 24),
            Text(
              S.of(context).nutrientContentPercent,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _buildNutrientSection(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: _validateAndSave,
          child: Text(S.of(context).add),
        ),
      ],
    );
  }

  Widget _buildNutrientSection() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                labelText: S.of(context).dryMatterPercent,
                controller: _dryMatterController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                labelText: S.of(context).organicCarbonPercent,
                controller: _organicCarbonController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                labelText: S.of(context).nitrogenPercent,
                controller: _nitrogenController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                labelText: S.of(context).phosphorusPercent,
                controller: _phosphorusController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                labelText: S.of(context).potassiumPercent,
                controller: _potassiumController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                labelText: S.of(context).calciumPercent,
                controller: _calciumController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                labelText: S.of(context).magnesiumPercent,
                controller: _magnesiumController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                labelText: S.of(context).carbonNitrogenRatio,
                controller: _carbonNitrogenController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _validateAndSave() {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).pleaseEnterIngredientName)),
      );
      return;
    }

    final price = double.tryParse(_priceController.text) ?? 0.0;

    // Parse nutrient values and convert from percentage to decimal
    final dryMatter = (double.tryParse(_dryMatterController.text) ?? 0.0) / 100.0;
    final organicCarbon = (double.tryParse(_organicCarbonController.text) ?? 0.0) / 100.0;
    final nitrogen = (double.tryParse(_nitrogenController.text) ?? 0.0) / 100.0;
    final phosphorus = (double.tryParse(_phosphorusController.text) ?? 0.0) / 100.0;
    final potassium = (double.tryParse(_potassiumController.text) ?? 0.0) / 100.0;
    final calcium = (double.tryParse(_calciumController.text) ?? 0.0) / 100.0;
    final magnesium = (double.tryParse(_magnesiumController.text) ?? 0.0) / 100.0;
    final carbonNitrogen = double.tryParse(_carbonNitrogenController.text) ?? 0.0; // C:N ratio is not a percentage

    // Create nutrient content
    final nutrients = NutrientContent(
      dryMatterPercent: dryMatter,
      organicCarbonPercent: organicCarbon,
      nitrogenPercent: nitrogen,
      phosphorusPercent: phosphorus,
      potassiumPercent: potassium,
      calciumPercent: calcium,
      magnesiumPercent: magnesium,
      carbonNitrogenRatio: carbonNitrogen,
    );

    // Create price if provided
    final priceModel = price > 0 ? Price(pricePerTon: price) : null;

    // Generate unique ID
    final id = 'custom_${DateTime.now().millisecondsSinceEpoch}';

    // Create custom ingredient
    final ingredient = CompostComponent(
      id: id,
      name: _nameController.text,
      nutrients: nutrients,
      price: priceModel,
      isCustom: true,
      createdBy: 'user',
    );

    widget.onAdd(ingredient);
    Navigator.pop(context);
  }
}
