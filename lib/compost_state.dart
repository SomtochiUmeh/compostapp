import 'package:flutter/material.dart';
import '../models/compost_component_model.dart';
import '../services/persistence_manager.dart';
import '../data/compost_components_data.dart';
import './models/price_model.dart';

class CompostState extends ChangeNotifier {
  final PersistenceManager persistenceManager;
  List<CompostComponent> components = [];

  CompostState(this.persistenceManager) {
    _loadSavedComponents();
  }

  void _loadSavedComponents() async {
    final savedComponents = await persistenceManager.getSavedComponents();
    if (savedComponents != null) {
      components = savedComponents;
    } else {
      components = CompostComponentsData.components;
    }
    notifyListeners();
  }

  void updateComponent(CompostComponent updatedComponent) {
    final index = components
        .indexWhere((comp) => comp.getName() == updatedComponent.getName());
    if (index != -1) {
      components[index] = updatedComponent;
      persistenceManager.updateComponentPrices(components);
      notifyListeners();
    }
  }

  List<CompostComponent> getAvailableComponents(DateTime date) {
    return components
        .where((component) => component.isAvailableOn(date))
        .toList();
  }

  // Helper method to update price
  void updateComponentPrice(String componentName, double newPrice) {
    final index =
        components.indexWhere((comp) => comp.getName() == componentName);
    if (index != -1) {
      final component = components[index];
      final currentPrice = component.price;

      final updatedPrice = currentPrice != null
          ? Price(
              priceInFCFA: (newPrice * currentPrice.unitAmount).round(),
              unit: currentPrice.unit.toString(),
              unitAmount: currentPrice.unitAmount,
              pricePerUnit: newPrice.round(),
            )
          : Price(
              priceInFCFA: (newPrice * 100).round(),
              unit: 'kgs',
              unitAmount: 100,
              pricePerUnit: newPrice.round(),
            );

      final updatedComponent = CompostComponent(
        id: component.id,
        name: component.name,
        availability: component.availability,
        nutrients: component.nutrients,
        price: updatedPrice,
        sources: component.sources,
      );

      components[index] = updatedComponent;
      persistenceManager.updateComponentPrices(components);
      notifyListeners();
    }
  }
}
