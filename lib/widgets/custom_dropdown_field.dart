import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final List<String> options;
  final String value;
  final Function(String) onChanged;
  final String labelText;

  const CustomDropdownField({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        value: value.isEmpty ? null : value,
        items: options.map((option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
        isExpanded: true,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ));
  }
}
