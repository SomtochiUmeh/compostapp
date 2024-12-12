import 'package:flutter/material.dart';
import '../models/recipe_component_model.dart';
import '../constants/compost_quality_standards.dart';
import '../constants/nutrient_constants.dart';

class NutrientTotalsTable extends StatelessWidget {
  final List<RecipeComponent> components;

  const NutrientTotalsTable({
    super.key,
    required this.components,
  });

  Map<String, double> _calculateTotals() {
    if (components.isEmpty) {
      return {};
    }

    double totalWeight = 0;
    Map<String, double> totals = {
      'weight': 0,
      ...Map.fromIterable(
        NutrientConstants.trackedNutrients,
        value: (_) => 0.0,
      ),
    };

    // Calculate raw totals
    for (var component in components) {
      totalWeight += component.amount;
      final nutrients = component.component.nutrients.toMap();

      for (var nutrient in NutrientConstants.trackedNutrients) {
        totals[nutrient] = (totals[nutrient] ?? 0) +
            (nutrients[nutrient] ?? 0) * component.amount;
      }
    }

    // Convert to percentages
    if (totalWeight > 0) {
      for (var nutrient in NutrientConstants.trackedNutrients) {
        totals[nutrient] = (totals[nutrient] ?? 0) / totalWeight;
      }
    }

    totals['weight'] = totalWeight;
    return totals;
  }

  Widget _buildComparisonIcon(String nutrient, double value) {
    const standards = CompostQualityStandards.municipalStandards;
    if (!standards.containsKey(nutrient)) return const SizedBox.shrink();

    final target = standards[nutrient]!;
    final min = target * 0.9;
    final max = target * 1.1;

    if (value < min) {
      return const Icon(Icons.arrow_upward, color: Colors.red);
    } else if (value > max) {
      return const Icon(Icons.arrow_downward, color: Colors.orange);
    } else {
      return const Icon(Icons.check_circle, color: Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totals = _calculateTotals();
    final nutrients = [...NutrientConstants.trackedNutrients];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          const DataColumn(label: Text('Total Weight (kg)')),
          ...nutrients.map(
            (nutrient) => DataColumn(
              label: Text('${nutrient.toUpperCase()} (%)'),
            ),
          ),
          if (components.any((comp) => comp.component.price != null))
            const DataColumn(label: Text('Total Cost (FCFA)')),
        ],
        rows: [
          DataRow(
            cells: [
              DataCell(Text(totals['weight']?.toStringAsFixed(2) ?? '0.00')),
              ...nutrients.map(
                (nutrient) => DataCell(
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(totals[nutrient]?.toStringAsFixed(2) ?? '0.00'),
                      const SizedBox(width: 4),
                      _buildComparisonIcon(nutrient, totals[nutrient] ?? 0),
                    ],
                  ),
                ),
              ),
              if (components.any((comp) => comp.component.price != null))
                DataCell(Text(
                  _calculateTotalCost().toStringAsFixed(2),
                )),
            ],
          ),
        ],
      ),
    );
  }

  double _calculateTotalCost() {
    return components.fold<double>(
      0,
      (total, comp) =>
          total + (comp.component.price?.calculatePrice(comp.amount) ?? 0),
    );
  }
}
