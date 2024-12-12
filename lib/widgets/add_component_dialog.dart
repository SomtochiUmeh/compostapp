import 'package:flutter/material.dart';
import '../models/compost_component_model.dart';
import 'custom_dropdown_field.dart';
import 'custom_text_field.dart';

class AddComponentDialog extends StatefulWidget {
  final List<CompostComponent> availableComponents;
  final Function(CompostComponent, double) onAdd;
  final double? initialWeight;

  const AddComponentDialog({
    super.key,
    required this.availableComponents,
    required this.onAdd,
    this.initialWeight,
  });

  @override
  State<AddComponentDialog> createState() => _AddComponentDialogState();
}

class _AddComponentDialogState extends State<AddComponentDialog> {
  CompostComponent? selectedComponent;
  late TextEditingController weightController;

  @override
  void initState() {
    super.initState();
    selectedComponent =
        widget.initialWeight != null ? widget.availableComponents.first : null;
    weightController = TextEditingController(
      text: widget.initialWeight?.toString() ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          widget.initialWeight != null ? 'Edit Component' : 'Add Component'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDropdownField(
              options: widget.availableComponents.map((c) => c.name).toList(),
              value: selectedComponent?.name ?? '',
              onChanged: (value) {
                setState(() {
                  selectedComponent = widget.availableComponents
                      .firstWhere((c) => c.name == value);
                });
              },
              labelText: 'Choose Component',
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: 'Weight (kg)',
              controller: weightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            if (selectedComponent?.price != null) ...[
              const SizedBox(height: 16),
              Text(
                'Price: ${selectedComponent!.price!.priceInFCFA} FCFA per ${selectedComponent!.price!.unitAmount} ${selectedComponent!.price!.unit}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (selectedComponent != null && weightController.text.isNotEmpty) {
              final weight = double.tryParse(weightController.text) ?? 0;
              if (weight > 0) {
                widget.onAdd(selectedComponent!, weight);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a valid weight')),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please fill all fields')),
              );
            }
          },
          child: Text(widget.initialWeight != null ? 'Update' : 'Add'),
        ),
      ],
    );
  }
}
