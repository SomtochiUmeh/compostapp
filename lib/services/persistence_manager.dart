import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/recipe_model.dart';
import '../models/recipe_component_model.dart';
import '../models/compost_component_model.dart';
import '../models/price_model.dart';
import '../models/nutrient_content_model.dart';
import '../models/availability_model.dart';

class PersistenceManager {
  static SharedPreferences? _prefs;
  static const String _recipeKey = 'current_recipe';
  static const String _recipesHistoryKey = 'recipes_history';
  static const String _componentsKey = 'components_data';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Recipe Management
  Future<bool> saveRecipe(Recipe recipe) async {
    // Save current recipe
    final String recipeJson = json.encode(_recipeToJson(recipe));
    final bool savedCurrent =
        await _prefs?.setString(_recipeKey, recipeJson) ?? false;

    // Update recipe history
    List<Recipe> history = await getRecipeHistory();
    history.insert(0, recipe);
    if (history.length > 10) {
      history = history.take(10).toList();
    } // Keep last 10 recipes

    final List<Map<String, dynamic>> historyJson =
        history.map((r) => _recipeToJson(r)).toList();
    final bool savedHistory =
        await _prefs?.setString(_recipesHistoryKey, json.encode(historyJson)) ??
            false;

    return savedCurrent && savedHistory;
  }

  Future<Recipe?> getLatestRecipe() async {
    final String? recipeJson = _prefs?.getString(_recipeKey);
    if (recipeJson != null) {
      final Map<String, dynamic> recipeMap = json.decode(recipeJson);
      return _recipeFromJson(recipeMap);
    }
    return null;
  }

  Future<List<Recipe>> getRecipeHistory() async {
    final String? historyJson = _prefs?.getString(_recipesHistoryKey);
    if (historyJson != null) {
      final List<dynamic> historyList = json.decode(historyJson);
      return historyList.map((json) => _recipeFromJson(json)).toList();
    }
    return [];
  }

  // Component Price & Availability Management
  Future<bool> updateComponentPrices(List<CompostComponent> components) async {
    final List<Map<String, dynamic>> componentsJson =
        components.map((component) => _componentToJson(component)).toList();
    final String json = jsonEncode(componentsJson);
    return await _prefs?.setString(_componentsKey, json) ?? false;
  }

  Future<List<CompostComponent>?> getSavedComponents() async {
    final String? componentsJson = _prefs?.getString(_componentsKey);
    if (componentsJson != null) {
      final List<dynamic> decodedList = json.decode(componentsJson);
      return decodedList.map((json) => _componentFromJson(json)).toList();
    }
    return null;
  }

  // Clearing Data
  Future<bool> clearCurrentRecipe() async {
    return await _prefs?.remove(_recipeKey) ?? false;
  }

  Future<bool> clearRecipeHistory() async {
    return await _prefs?.remove(_recipesHistoryKey) ?? false;
  }

  Future<bool> clearComponentData() async {
    return await _prefs?.remove(_componentsKey) ?? false;
  }

  Future<bool> clearAll() async {
    return await _prefs?.clear() ?? false;
  }

  // JSON Conversion Helpers
  Map<String, dynamic> _recipeToJson(Recipe recipe) {
    return {
      'components': recipe.components
          .map((comp) => {
                'component': _componentToJson(comp.component),
                'amount': comp.amount,
              })
          .toList(),
      'createdAt': recipe.createdAt.toIso8601String(),
    };
  }

  Recipe _recipeFromJson(Map<String, dynamic> json) {
    return Recipe(
      components: (json['components'] as List)
          .map((comp) => RecipeComponent(
                component: _componentFromJson(comp['component']),
                amount: comp['amount'],
              ))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> _componentToJson(CompostComponent component) {
    return {
      'id': component.id,
      'name': component.name,
      'availability': component.availability.toString(),
      'nutrients': {
        'dryMatterPercent': component.nutrients.dryMatterPercent,
        'organicCarbonPercent': component.nutrients.organicCarbonPercent,
        'nitrogenPercent': component.nutrients.nitrogenPercent,
        'phosphorusPercent': component.nutrients.phosphorusPercent,
        'potassiumPercent': component.nutrients.potassiumPercent,
        'calciumPercent': component.nutrients.calciumPercent,
        'magnesiumPercent': component.nutrients.magnesiumPercent,
        'carbonNitrogenRatio': component.nutrients.carbonNitrogenRatio,
      },
      'price': component.price != null
          ? {
              'priceInFCFA': component.price!.priceInFCFA,
              'unit': component.price!.unit.toString(),
              'unitAmount': component.price!.unitAmount,
              'pricePerUnit': component.price!.pricePerUnit,
            }
          : null,
      'sources': component.sources,
    };
  }

  CompostComponent _componentFromJson(Map<String, dynamic> json) {
    return CompostComponent(
      id: json['id'],
      name: json['name'],
      availability: AvailabilityPeriod.values.firstWhere(
        (e) => e.toString() == json['availability'],
      ),
      nutrients: NutrientContent(
        dryMatterPercent: json['nutrients']['dryMatterPercent'],
        organicCarbonPercent: json['nutrients']['organicCarbonPercent'],
        nitrogenPercent: json['nutrients']['nitrogenPercent'],
        phosphorusPercent: json['nutrients']['phosphorusPercent'],
        potassiumPercent: json['nutrients']['potassiumPercent'],
        calciumPercent: json['nutrients']['calciumPercent'],
        magnesiumPercent: json['nutrients']['magnesiumPercent'],
        carbonNitrogenRatio: json['nutrients']['carbonNitrogenRatio'],
      ),
      price: json['price'] != null
          ? Price(
              priceInFCFA: json['price']['priceInFCFA'],
              unit: json['price']['unit'],
              unitAmount: json['price']['unitAmount'],
              pricePerUnit: json['price']['pricePerUnit'],
            )
          : null,
      sources: List<String>.from(json['sources']),
    );
  }
}
