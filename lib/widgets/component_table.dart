import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe_component_model.dart';
import '../models/compost_component_model.dart';
import '../constants/nutrient_constants.dart';
import '../constants/currency_constants.dart';
import '../compost_state.dart';
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
          label: S.current.ingredient, key: 'name', decimalPlaces: 0),
      ColumnDefinition(
          label: S.current.weight, key: 'weight', decimalPlaces: 2),
      ...NutrientConstants.trackedNutrients.map((nutrient) => ColumnDefinition(
            label: NutrientConstants.getNutrientLabel(nutrient),
            key: nutrient,
            decimalPlaces: 2,
          )),
      ColumnDefinition(label: S.current.water, key: 'water'),
      if (items.any((item) => item.component.price != null))
        ColumnDefinition(
            label: S.current.costTotal, key: 'cost', decimalPlaces: 2),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CompostState>(
      builder: (context, compostState, child) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20,
                  horizontalMargin: 15,
                  columns: columns
                      .map((col) => DataColumn(label: Text(col.label)))
                      .toList(),
                  rows: List.generate(items.length, (index) {
                    final item = items[index];
                    return DataRow(
                      cells: columns
                          .map((col) => DataCell(
                                col.key == 'name' 
                                    ? _buildIngredientCell(item.component)
                                    : Text(
                                        _formatValue(item, col, compostState.selectedCurrency),
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
      },
    );
  }

  Widget _buildIngredientCell(CompostComponent component) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (component.isCustom) ...[
          const Icon(
            Icons.person_add,
            size: 16,
            color: Colors.blue,
          ),
          const SizedBox(width: 4),
        ],
        Expanded(
          child: Text(
            component.getName(),
            overflow: TextOverflow.ellipsis,
          ),
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

  String _formatValue(RecipeComponent item, ColumnDefinition col, String selectedCurrency) {
    switch (col.key) {
      case 'name':
        return item.component.getName();
      case 'weight':
        return item.amount.toStringAsFixed(col.decimalPlaces);
      case 'cost':
        if (item.component.price == null) {
          return CurrencyConstants.formatPrice(0, selectedCurrency);
        }
        final cost = item.component.price!.calculatePrice(item.amount, currency: selectedCurrency);
        return CurrencyConstants.formatPrice(cost, selectedCurrency);
      case 'water':
        double dryMatter = item.component.nutrients.toMap()['dryMatter'] ?? 0.0;
        dryMatter *= item.amount;
        return (item.amount - dryMatter).toStringAsFixed(col.decimalPlaces);
      default:
        double nutrientValue = item.component.nutrients.toMap()[col.key] ?? 0.0;
        nutrientValue *= item.amount;
        return nutrientValue.toStringAsFixed(col.decimalPlaces);
    }
  }
}
