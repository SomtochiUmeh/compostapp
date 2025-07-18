import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe_component_model.dart';
import '../constants/compost_quality_standards.dart';
import '../constants/nutrient_constants.dart';
import '../constants/currency_constants.dart';
import '../compost_state.dart';
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

  // track which notifications have been shown
  static final Set<String> shownNotifications = {};

  Widget _buildComparisonIcon(
      String nutrient, double value, BuildContext context) {
    const standards = CompostQualityStandards.gftStandards;
    if (!standards.containsKey(nutrient)) return const SizedBox.shrink();

    final target = standards[nutrient]!;
    final min = target - 2.5; // 5 percentage points leeway for C/N ratio
    final max = target + 2.5;

    if (value < min) {
      shownNotifications.remove(nutrient);
      return const Icon(Icons.arrow_upward, color: Colors.red, size: 20);
    } else if (value > max) {
      shownNotifications.remove(nutrient);
      return const Icon(Icons.arrow_downward, color: Colors.orange, size: 20);
    } else {
      // pop up saying congrats, the nutrient is within the range
      // Only show notification if we haven't shown it before
      if (!shownNotifications.contains(nutrient)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          shownNotifications.add(nutrient);
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
      }
      return const Icon(Icons.check_circle, color: Colors.green, size: 20);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totals = _calculateTotals();
    final nutrients = [...NutrientConstants.trackedNutrients];

    return Consumer<CompostState>(
      builder: (context, compostState, child) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 20,
            horizontalMargin: 15,
            columns: [
              DataColumn(label: Text(S.of(context).totalWeightKg)),
              DataColumn(label: Text(S.of(context).cn)),
              ...nutrients.map(
                (nutrient) => DataColumn(
                  label: Text(NutrientConstants.getNutrientLabel(nutrient)),
                ),
              ),
              if (components.any((comp) => comp.component.price != null))
                DataColumn(label: Text(S.of(context).costTotal)),
            ],
            rows: [
              DataRow(
                cells: [
                  DataCell(Text(totals['weight']?.toStringAsFixed(2) ?? '0.00')),
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
                  ...nutrients.map(
                    (nutrient) => DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(totals[nutrient]?.toStringAsFixed(2) ?? '0.00'),
                          const SizedBox(width: 4),
                          // _buildComparisonIcon(
                          //     nutrient, totals[nutrient] ?? 0, context),
                        ],
                      ),
                    ),
                  ),
                  if (components.any((comp) => comp.component.price != null))
                    DataCell(Text(
                      _calculateTotalCostInCurrency(compostState.selectedCurrency),
                    )),
                ],
              ),
            ],
          ),
        );
      },
    );
  }


  String _calculateTotalCostInCurrency(String currency) {
    final totalCost = components.fold<double>(
      0,
      (total, comp) => total + (comp.component.price?.calculatePrice(comp.amount, currency: currency) ?? 0),
    );
    return CurrencyConstants.formatPrice(totalCost, currency);
  }
}
