import 'package:flutter/material.dart';
import '../models/compost_component_model.dart';
import '../services/persistence_manager.dart';
import '../data/compost_components_data.dart';
import './models/price_model.dart';
import '../constants/currency_constants.dart';

class CompostState extends ChangeNotifier {
  final PersistenceManager persistenceManager;
  List<CompostComponent> components = [];
  List<CompostComponent> customIngredients = [];
  String _selectedCurrency = CurrencyConstants.defaultCurrency;

  CompostState(this.persistenceManager) {
    _loadSavedComponents();
    _loadCustomIngredients();
    _loadSelectedCurrency();
  }

  String get selectedCurrency => _selectedCurrency;

  void _loadSavedComponents() async {
    final savedComponents = await persistenceManager.getSavedComponents();
    if (savedComponents != null) {
      components = savedComponents;
    } else {
      components = CompostComponentsData.components;
    }
    notifyListeners();
  }

  void _loadCustomIngredients() async {
    final savedCustomIngredients =
        await persistenceManager.getCustomIngredients();
    if (savedCustomIngredients != null) {
      customIngredients = savedCustomIngredients;
      notifyListeners();
    }
  }

  void _loadSelectedCurrency() async {
    final savedCurrency = await persistenceManager.getSelectedCurrency();
    if (savedCurrency != null &&
        CurrencyConstants.isCurrencySupported(savedCurrency)) {
      _selectedCurrency = savedCurrency;
      notifyListeners();
    }
  }

  Future<void> setSelectedCurrency(String currency) async {
    if (CurrencyConstants.isCurrencySupported(currency)) {
      _selectedCurrency = currency;
      await persistenceManager.setSelectedCurrency(currency);
      notifyListeners();
    }
  }

  void updateComponent(CompostComponent updatedComponent) {
    final index = components
        .indexWhere((comp) => comp.getName() == updatedComponent.getName());
    if (index != -1) {
      components[index] = updatedComponent;
      persistenceManager.updateComponentInfo(components);
      notifyListeners();
    }
  }

  List<CompostComponent> get allComponents {
    return [...components, ...customIngredients];
  }

  // Custom ingredient management methods
  Future<void> addCustomIngredient(CompostComponent ingredient) async {
    customIngredients.add(ingredient);
    await persistenceManager.saveCustomIngredients(customIngredients);
    notifyListeners();
  }

  Future<void> updateCustomIngredient(
      CompostComponent updatedIngredient) async {
    final index =
        customIngredients.indexWhere((comp) => comp.id == updatedIngredient.id);
    if (index != -1) {
      customIngredients[index] = updatedIngredient;
      await persistenceManager.saveCustomIngredients(customIngredients);
      notifyListeners();
    }
  }

  Future<void> deleteCustomIngredient(String ingredientId) async {
    customIngredients.removeWhere((comp) => comp.id == ingredientId);
    await persistenceManager.saveCustomIngredients(customIngredients);
    notifyListeners();
  }

  // Helper method to check if a component still exists (for recipe validation)
  bool componentExists(CompostComponent component) {
    if (component.isCustom) {
      return customIngredients.any((c) => c.id == component.id);
    } else {
      return components.any((c) => c.id == component.id);
    }
  }

  // Helper method to update price
  void updateComponentPrice(String componentName, double newPrice,
      {String currency = 'CFA'}) {
    // Check predefined components first
    final predefinedIndex =
        components.indexWhere((comp) => comp.getName() == componentName);
    if (predefinedIndex != -1) {
      final component = components[predefinedIndex];
      final currentPrice = component.price ?? Price(pricePerTon: 0);
      final updatedPrice = currency == 'CFA'
          ? currentPrice.updateCFAPrice(newPrice)
          : currentPrice.withRegionalPrice(currency, newPrice);

      final updatedComponent = CompostComponent(
        id: component.id,
        name: component.name,
        nutrients: component.nutrients,
        price: updatedPrice,
        sources: component.sources,
        isCustom: component.isCustom,
        createdBy: component.createdBy,
      );

      components[predefinedIndex] = updatedComponent;
      persistenceManager.updateComponentInfo(components);
      notifyListeners();
      return;
    }

    // Check custom ingredients
    final customIndex =
        customIngredients.indexWhere((comp) => comp.getName() == componentName);
    if (customIndex != -1) {
      final component = customIngredients[customIndex];
      final currentPrice = component.price ?? Price(pricePerTon: 0);
      final updatedPrice = currency == 'CFA'
          ? currentPrice.updateCFAPrice(newPrice)
          : currentPrice.withRegionalPrice(currency, newPrice);

      final updatedComponent = CompostComponent(
        id: component.id,
        name: component.name,
        nutrients: component.nutrients,
        price: updatedPrice,
        sources: component.sources,
        isCustom: component.isCustom,
        createdBy: component.createdBy,
      );

      customIngredients[customIndex] = updatedComponent;
      persistenceManager.saveCustomIngredients(customIngredients);
      notifyListeners();
    }
  }
}
