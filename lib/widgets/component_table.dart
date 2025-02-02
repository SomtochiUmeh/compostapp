import 'package:flutter/material.dart';
import '../models/recipe_component_model.dart';
import '../constants/nutrient_constants.dart';
import '../generated/l10n.dart';

class ColumnDefinition {
  final String label;
  final String key;
  final int decimalPlaces;

  const ColumnDefinition({
    required this.label,
    required this.key,
    this.decimalPlaces = 2,
  });
}

class ComponentTable extends StatelessWidget {
  final List<RecipeComponent> items;
  final Function(int) onEdit;
  final Function(int) onDelete;

  const ComponentTable({
    super.key,
    required this.items,
    required this.onEdit,
    required this.onDelete,
  });

  List<ColumnDefinition> get columns {
    return [
      ColumnDefinition(
          label: S.current.component, key: 'name', decimalPlaces: 0),
      ColumnDefinition(
          label: S.current.weight, key: 'weight', decimalPlaces: 2),
      ...NutrientConstants.trackedNutrients.map((nutrient) => ColumnDefinition(
            label: S.current
                .percentage(NutrientConstants.getNutrientLabel(nutrient)),
            key: nutrient,
            decimalPlaces: 2,
          )),
      if (items.any((item) => item.component.price != null))
        ColumnDefinition(
            label: S.current.costFCFA, key: 'cost', decimalPlaces: 2),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: columns
                  .map((col) => DataColumn(label: Text(col.label)))
                  .toList(),
              rows: List.generate(items.length, (index) {
                final item = items[index];
                return DataRow(
                  cells: columns
                      .map((col) => DataCell(Text(
                            _formatValue(item, col),
                            overflow: TextOverflow.ellipsis,
                          )))
                      .toList(),
                );
              }),
            ),
          ),
        ),
        const VerticalDivider(width: 1),
        Column(
          children: [
            Container(height: 56, alignment: Alignment.center),
            ...List.generate(items.length, (index) {
              return SizedBox(
                height: 48,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCompactIconButton(Icons.edit, () => onEdit(index)),
                    _buildCompactIconButton(
                        Icons.delete, () => onDelete(index)),
                  ],
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildCompactIconButton(IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        icon: Icon(icon, size: 16),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }

  String _formatValue(RecipeComponent item, ColumnDefinition col) {
    switch (col.key) {
      case 'name':
        return item.component.getName();
      case 'weight':
        return item.amount.toStringAsFixed(col.decimalPlaces);
      case 'cost':
        return item.component.price
                ?.calculatePrice(item.amount)
                .toStringAsFixed(col.decimalPlaces) ??
            '0.00';
      default:
        final nutrientValue = item.component.nutrients.toMap()[col.key] ?? 0.0;
        return nutrientValue.toStringAsFixed(col.decimalPlaces);
    }
  }
}
