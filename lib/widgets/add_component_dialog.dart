import 'package:flutter/material.dart';
import '../models/compost_component_model.dart';
import 'custom_dropdown_field.dart';
import 'custom_text_field.dart';
import '../generated/l10n.dart';

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
      title: Text(widget.initialWeight != null
          ? S.of(context).editComponent
          : S.of(context).addComponent),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomDropdownField(
              options:
                  widget.availableComponents.map((c) => c.getName()).toList(),
              value: selectedComponent?.getName() ?? '',
              onChanged: (value) {
                setState(() {
                  selectedComponent = widget.availableComponents
                      .firstWhere((c) => c.getName() == value);
                });
              },
              labelText: S.of(context).chooseComponent,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              labelText: S.of(context).weight,
              controller: weightController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            if (selectedComponent?.price != null) ...[
              const SizedBox(height: 16),
              Text(
                S.of(context).price(
                    selectedComponent!.price!.priceInFCFA,
                    selectedComponent!.price!.unitAmount,
                    selectedComponent!.price!.getLocalizedUnit()),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
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
                  SnackBar(content: Text(S.of(context).pleaseEnterValidWeight)),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(S.of(context).pleaseFillAllFields)),
              );
            }
          },
          child: Text(widget.initialWeight != null
              ? S.of(context).update
              : S.of(context).add),
        ),
      ],
    );
  }
}
