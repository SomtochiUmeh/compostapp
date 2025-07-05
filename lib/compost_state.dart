import 'package:flutter/material.dart';
import '../models/compost_component_model.dart';
import '../services/persistence_manager.dart';
import '../data/compost_components_data.dart';
import './models/price_model.dart';
import '../constants/currency_constants.dart';

class CompostState extends ChangeNotifier {
  final PersistenceManager persistenceManager;
  List<CompostComponent> components = [];
  String _selectedCurrency = CurrencyConstants.defaultCurrency;

  CompostState(this.persistenceManager) {
    _loadSavedComponents();
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

  void _loadSelectedCurrency() async {
    final savedCurrency = await persistenceManager.getSelectedCurrency();
    if (savedCurrency != null && CurrencyConstants.isCurrencySupported(savedCurrency)) {
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

  List<CompostComponent> getAvailableComponents(DateTime date) {
    return components
        .where((component) => component.isAvailableOn(date))
        .toList();
  }

  // Helper method to update price
  void updateComponentPrice(String componentName, double newPrice, {String currency = 'CFA'}) {
    final index =
        components.indexWhere((comp) => comp.getName() == componentName);
    if (index != -1) {
      final component = components[index];

      // Use existing price or create new one, then set regional price
      final currentPrice = component.price ?? Price(pricePerTon: 0);
      final updatedPrice = currency == 'CFA' 
          ? currentPrice.updateCFAPrice(newPrice)  // Preserve regional prices when updating CFA
          : currentPrice.withRegionalPrice(currency, newPrice);  // Set regional price

      final updatedComponent = CompostComponent(
        id: component.id,
        name: component.name,
        availability: component.availability,
        nutrients: component.nutrients,
        price: updatedPrice,
        sources: component.sources,
      );

      components[index] = updatedComponent;
      persistenceManager.updateComponentInfo(components);
      notifyListeners();
    }
  }

}
