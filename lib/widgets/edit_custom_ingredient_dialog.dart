import 'package:flutter/material.dart';
import '../models/compost_component_model.dart';
import '../models/nutrient_content_model.dart';
import '../models/price_model.dart';
import 'custom_text_field.dart';
import '../generated/l10n.dart';

class EditCustomIngredientDialog extends StatefulWidget {
  final CompostComponent ingredient;
  final Function(CompostComponent) onUpdate;

  const EditCustomIngredientDialog({
    super.key,
    required this.ingredient,
    required this.onUpdate,
  });

  @override
  State<EditCustomIngredientDialog> createState() => _EditCustomIngredientDialogState();
}

class _EditCustomIngredientDialogState extends State<EditCustomIngredientDialog> {
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
  void initState() {
    super.initState();
    _populateFields();
  }

  void _populateFields() {
    _nameController.text = widget.ingredient.name;
    _priceController.text = widget.ingredient.price?.pricePerTon.toString() ?? '';
    
    // Populate nutrient fields - convert from decimal to percentage for display
    _dryMatterController.text = (widget.ingredient.nutrients.dryMatterPercent * 100).toString();
    _organicCarbonController.text = (widget.ingredient.nutrients.organicCarbonPercent * 100).toString();
    _nitrogenController.text = (widget.ingredient.nutrients.nitrogenPercent * 100).toString();
    _phosphorusController.text = (widget.ingredient.nutrients.phosphorusPercent * 100).toString();
    _potassiumController.text = (widget.ingredient.nutrients.potassiumPercent * 100).toString();
    _calciumController.text = (widget.ingredient.nutrients.calciumPercent * 100).toString();
    _magnesiumController.text = (widget.ingredient.nutrients.magnesiumPercent * 100).toString();
    _carbonNitrogenController.text = widget.ingredient.nutrients.carbonNitrogenRatio.toString(); // C:N ratio is not a percentage
  }

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
      title: Text(S.of(context).editCustomIngredient),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              labelText: S.of(context).ingredientName,
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: S.of(context).pricePerTonCFA,
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
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
          onPressed: _validateAndUpdate,
          child: Text(S.of(context).update),
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                labelText: S.of(context).organicCarbonPercent,
                controller: _organicCarbonController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                labelText: S.of(context).phosphorusPercent,
                controller: _phosphorusController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                labelText: S.of(context).calciumPercent,
                controller: _calciumController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomTextField(
                labelText: S.of(context).carbonNitrogenRatio,
                controller: _carbonNitrogenController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _validateAndUpdate() {
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

    // Create updated ingredient with same ID
    final updatedIngredient = CompostComponent(
      id: widget.ingredient.id, // Keep the same ID
      name: _nameController.text,
      nutrients: nutrients,
      price: priceModel,
      sources: widget.ingredient.sources, // Keep existing sources
      isCustom: true,
      createdBy: widget.ingredient.createdBy,
    );

    widget.onUpdate(updatedIngredient);
    Navigator.pop(context);
  }
}