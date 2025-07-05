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
      title: const Text('Add Custom Ingredient'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              labelText: 'Ingredient Name',
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Price per Ton (CFA)',
              controller: _priceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 24),
            Text(
              'Nutrient Content (%)',
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
                labelText: 'Dry Matter %',
                controller: _dryMatterController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                labelText: 'Organic Carbon %',
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
                labelText: 'Nitrogen %',
                controller: _nitrogenController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                labelText: 'Phosphorus %',
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
                labelText: 'Potassium %',
                controller: _potassiumController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                labelText: 'Calcium %',
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
                labelText: 'Magnesium %',
                controller: _magnesiumController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                labelText: 'C:N Ratio',
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
        const SnackBar(content: Text('Please enter an ingredient name')),
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
