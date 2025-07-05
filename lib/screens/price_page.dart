import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../compost_state.dart';
import '../models/compost_component_model.dart';
import '../generated/l10n.dart';
import '../widgets/edit_availability_dialog.dart';
import '../widgets/currency_selector.dart';
import '../constants/currency_constants.dart';

class PricesPage extends StatefulWidget {
  const PricesPage({super.key});

  @override
  State<PricesPage> createState() => _PricesPageState();
}

class _PricesPageState extends State<PricesPage> {
  final Map<String, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Update controller text if it differs from expected value
  void _updateControllerIfNeeded(String key, double newPrice, int decimalPlaces) {
    if (_controllers.containsKey(key)) {
      final expectedText = newPrice.toStringAsFixed(decimalPlaces);
      if (_controllers[key]!.text != expectedText) {
        _controllers[key]!.text = expectedText;
      }
    }
  }

  /// Update all controllers for untouched currencies when CFA base price changes
  void _updateUntouchedControllers(List<CompostComponent> components, String currentCurrency) {
    for (var component in components) {
      for (var currency in CurrencyConstants.getSupportedCurrencies()) {
        if (currency != currentCurrency && component.price?.isUntouchedCurrency(currency) == true) {
          final key = '${component.getName()}_$currency';
          final price = component.price!.getPriceForCurrency(currency);
          final decimalPlaces = CurrencyConstants.currencies[currency]!['decimalPlaces'];
          _updateControllerIfNeeded(key, price, decimalPlaces);
        }
      }
    }
  }

  TextEditingController _getController(String componentName, CompostComponent component, String currency) {
    final key = '${componentName}_$currency';
    final price = component.price?.getPriceForCurrency(currency) ?? 0.0;
    final decimalPlaces = CurrencyConstants.currencies[currency]!['decimalPlaces'];
    
    // Always ensure controller has current value
    if (!_controllers.containsKey(key)) {
      _controllers[key] = TextEditingController(
        text: price.toStringAsFixed(decimalPlaces),
      );
    } else {
      // Update existing controller if the price has changed
      _updateControllerIfNeeded(key, price, decimalPlaces);
    }
    
    return _controllers[key]!;
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildComponentTile(
    CompostComponent component,
    CompostState compostState,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(component.getName()),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => _showEditAvailabilityDialog(
                      context,
                      component,
                      compostState,
                    ),
                    icon:
                        Icon(Icons.edit_calendar, color: Colors.brown.shade700),
                    tooltip: S.of(context).editAvailability,
                    constraints:
                        const BoxConstraints(minWidth: 40, minHeight: 40),
                  ),
                  Expanded(
                    child: Text(
                      component.availability.getLocalizedPeriod(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          trailing: SizedBox(
            width: 120,
            child: _buildPriceInput(component, compostState, context),
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildPriceInput(
    CompostComponent component,
    CompostState compostState,
    BuildContext context,
  ) {
    final controller = _getController(
      component.getName(),
      component,
      compostState.selectedCurrency,
    );
    
    return TextFormField(
      key: ValueKey('${component.getName()}_${compostState.selectedCurrency}'),
      controller: controller,
      decoration: InputDecoration(
        labelText: S.of(context).costPerTon,
        suffixText: CurrencyConstants.getCurrencySymbol(compostState.selectedCurrency),
        isDense: true,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      onChanged: (value) {
        final newPrice = double.tryParse(value);
        if (newPrice != null) {
          // Save the price in the selected currency (regional pricing)
          compostState.updateComponentPrice(
            component.getName(),
            newPrice,
            currency: compostState.selectedCurrency,
          );
          
          // If this is a CFA price change, update controllers for untouched currencies
          if (compostState.selectedCurrency == 'CFA') {
            _updateUntouchedControllers(compostState.components, compostState.selectedCurrency);
          }
        }
      },
    );
  }

  void _showEditAvailabilityDialog(
    BuildContext context,
    CompostComponent component,
    CompostState compostState,
  ) {
    showDialog(
      context: context,
      builder: (context) => EditAvailabilityDialog(
        componentId: component.id,
        componentName: component.getName(),
        currentAvailability: component.availability,
        onSave: (newAvailability) {
          compostState.updateComponentAvailability(
              component.id, newAvailability);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CompostState>(
        builder: (context, compostState, child) {
          final components = compostState.components;

          return ListView(
            children: [
              const CurrencySelector(),
              const Divider(),
              _buildSectionTitle(S.of(context).allIngredients),
              ...components.map((component) =>
                  _buildComponentTile(component, compostState, context)),
            ],
          );
        },
      ),
    );
  }
}
