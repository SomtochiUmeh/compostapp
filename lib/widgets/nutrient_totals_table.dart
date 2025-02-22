import 'package:flutter/material.dart';
import '../models/recipe_component_model.dart';
import '../constants/compost_quality_standards.dart';
import '../constants/nutrient_constants.dart';
import '../generated/l10n.dart';

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

    Map<String, double> totals = {
      'weight': 0,
      ...Map.fromIterable(
        NutrientConstants.trackedNutrients,
        value: (_) => 0.0,
      ),
      'cnRatio': 0,
    };

    // Calculate raw totals
    for (var component in components) {
      totals['weight'] = (totals['weight'] ?? 0) + component.amount;
      final nutrients = component.component.nutrients.toMap();

      for (var nutrient in NutrientConstants.trackedNutrients) {
        totals[nutrient] = (totals[nutrient] ?? 0) +
            (nutrients[nutrient] ?? 0) * component.amount;
      }
    }

    // Convert to percentages
    if ((totals['weight'] ?? 0) > 0) {
      for (var nutrient in NutrientConstants.trackedNutrients) {
        totals[nutrient] =
            (totals[nutrient] ?? 0) / (totals['weight'] ?? 0) * 100;
      }
    }

    // Calculate C/N ratio
    if ((totals['nitrogen'] ?? 0) > 0) {
      totals['cnRatio'] =
          (totals['organicCarbon'] ?? 0) / (totals['nitrogen'] ?? 0);
    }

    return totals;
  }

  Widget _buildComparisonIcon(
      String nutrient, double value, BuildContext context) {
    const standards = CompostQualityStandards.gftStandards;
    if (!standards.containsKey(nutrient)) return const SizedBox.shrink();

    final target = standards[nutrient]!;
    final min = target * 0.9;
    final max = target * 1.1;

    if (value < min) {
      return const Icon(Icons.arrow_upward, color: Colors.red, size: 20);
    } else if (value > max) {
      return const Icon(Icons.arrow_downward, color: Colors.orange, size: 20);
    } else {
      // pop up saying congrats, the nutrient is within the range

      WidgetsBinding.instance.addPostFrameCallback((_) {
        debugPrint('Showing snackbar for $nutrient'); // Debug print
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              S.of(context).nutrientInOptimalRange(
                    NutrientConstants.getNutrientLabel(nutrient),
                    min.toStringAsFixed(2),
                    max.toStringAsFixed(2),
                  ),
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: const Color.fromARGB(255, 47, 128, 50),
          ),
        );
      });

      return const Icon(Icons.check_circle, color: Colors.green, size: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totals = _calculateTotals();
    final nutrients = [...NutrientConstants.trackedNutrients];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        horizontalMargin: 15,
        columns: [
          DataColumn(label: Text(S.of(context).totalWeightKg)),
          ...nutrients.map(
            (nutrient) => DataColumn(
              label: Text(NutrientConstants.getNutrientLabel(nutrient)),
            ),
          ),
          const DataColumn(label: Text('C/N')),
          if (components.any((comp) => comp.component.price != null))
            DataColumn(label: Text(S.of(context).totalCostFCFA)),
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
                      _buildComparisonIcon(
                          nutrient, totals[nutrient] ?? 0, context),
                    ],
                  ),
                ),
              ),
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(totals['cnRatio']?.toStringAsFixed(2) ?? '0.00'),
                    const SizedBox(width: 4),
                    _buildComparisonIcon(
                        'cnRatio', totals['cnRatio'] ?? 0, context),
                  ],
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
