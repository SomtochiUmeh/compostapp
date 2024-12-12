import 'recipe_component_model.dart';

class Recipe {
  final List<RecipeComponent> components;
  final DateTime createdAt;

  Recipe({
    required this.components,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  double get totalWeight =>
      components.fold(0.0, (sum, component) => sum + component.amount);

  Map<String, double> calculateNutrients() {
    if (components.isEmpty) return {};

    final Map<String, double> totalNutrients = {
      'dryMatter': 0,
      'organicCarbon': 0,
      'nitrogen': 0,
      'phosphorus': 0,
      'potassium': 0,
      'calcium': 0,
      'magnesium': 0,
    };

    for (final component in components) {
      final weight = component.amount;
      final nutrients = component.component.nutrients;

      totalNutrients['dryMatter'] = (totalNutrients['dryMatter'] ?? 0) +
          (nutrients.dryMatterPercent * weight);
      totalNutrients['organicCarbon'] = (totalNutrients['organicCarbon'] ?? 0) +
          (nutrients.organicCarbonPercent * weight);
      totalNutrients['nitrogen'] = (totalNutrients['nitrogen'] ?? 0) +
          (nutrients.nitrogenPercent * weight);
      totalNutrients['phosphorus'] = (totalNutrients['phosphorus'] ?? 0) +
          (nutrients.phosphorusPercent * weight);
      totalNutrients['potassium'] = (totalNutrients['potassium'] ?? 0) +
          (nutrients.potassiumPercent * weight);
      totalNutrients['calcium'] = (totalNutrients['calcium'] ?? 0) +
          (nutrients.calciumPercent * weight);
      totalNutrients['magnesium'] = (totalNutrients['magnesium'] ?? 0) +
          (nutrients.magnesiumPercent * weight);
    }

    // Convert to percentages
    final total = totalWeight;
    if (total > 0) {
      totalNutrients.forEach((key, value) {
        totalNutrients[key] = value / total;
      });
    }

    return totalNutrients;
  }
}
