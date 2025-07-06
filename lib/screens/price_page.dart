import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../compost_state.dart';
import '../models/compost_component_model.dart';
import '../generated/l10n.dart';
import '../widgets/currency_selector.dart';
import '../widgets/custom_ingredient_dialog.dart';
import '../widgets/edit_custom_ingredient_dialog.dart';
import '../constants/currency_constants.dart';
import '../constants/app_colors.dart';

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
  void _updateControllerIfNeeded(
      String key, double newPrice, int decimalPlaces) {
    if (_controllers.containsKey(key)) {
      final expectedText = newPrice.toStringAsFixed(decimalPlaces);
      if (_controllers[key]!.text != expectedText) {
        _controllers[key]!.text = expectedText;
      }
    }
  }

  /// Update all controllers for untouched currencies when CFA base price changes
  void _updateUntouchedControllers(
      List<CompostComponent> components, String currentCurrency) {
    for (var component in components) {
      for (var currency in CurrencyConstants.getSupportedCurrencies()) {
        if (currency != currentCurrency &&
            component.price?.isUntouchedCurrency(currency) == true) {
          final key = '${component.getName()}_$currency';
          final price = component.price!.getPriceForCurrency(currency);
          final decimalPlaces =
              CurrencyConstants.currencies[currency]!['decimalPlaces'];
          _updateControllerIfNeeded(key, price, decimalPlaces);
        }
      }
    }
  }

  TextEditingController _getController(
      String componentName, CompostComponent component, String currency) {
    final key = '${componentName}_$currency';
    final price = component.price?.getPriceForCurrency(currency) ?? 0.0;
    final decimalPlaces =
        CurrencyConstants.currencies[currency]!['decimalPlaces'];

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
        Row(
          children: [
            Expanded(
              child: ListTile(
                title: Row(
                  children: [
                    if (component.isCustom) ...[
                      const Icon(
                        Icons.person_add,
                        size: 16,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Expanded(child: Text(component.getName())),
                  ],
                ),
                trailing: SizedBox(
                  width: 120,
                  child: _buildPriceInput(component, compostState, context),
                ),
              ),
            ),
            if (component.isCustom) ...[
              Column(
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildCompactIconButton(
                        Icons.edit,
                        () => _editCustomIngredient(
                            context, compostState, component),
                      ),
                      _buildCompactIconButton(
                        Icons.delete,
                        () => _deleteCustomIngredient(
                            context, compostState, component),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ],
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
        suffixText:
            CurrencyConstants.getCurrencySymbol(compostState.selectedCurrency),
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
            _updateUntouchedControllers(
                compostState.components, compostState.selectedCurrency);
          }
        }
      },
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

  void _showAddCustomIngredientDialog(
      BuildContext context, CompostState compostState) {
    showDialog(
      context: context,
      builder: (context) => CustomIngredientDialog(
        onAdd: (ingredient) async {
          await compostState.addCustomIngredient(ingredient);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(S.of(context).addedCustomIngredient(ingredient.name))),
            );
          }
        },
      ),
    );
  }

  void _editCustomIngredient(BuildContext context, CompostState compostState,
      CompostComponent component) {
    showDialog(
      context: context,
      builder: (context) => EditCustomIngredientDialog(
        ingredient: component,
        onUpdate: (updatedIngredient) async {
          await compostState.updateCustomIngredient(updatedIngredient);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text(S.of(context).updatedIngredient(updatedIngredient.name))),
            );
          }
        },
      ),
    );
  }

  void _deleteCustomIngredient(BuildContext context, CompostState compostState,
      CompostComponent component) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).deleteCustomIngredient),
        content: Text(S.of(context).areYouSureDeleteIngredient(component.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () async {
              await compostState.deleteCustomIngredient(component.id);
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(S.of(context).deletedIngredient(component.name))),
                );
              }
            },
            child:
                Text(S.of(context).delete, style: const TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CompostState>(
        builder: (context, compostState, child) {
          final components = compostState.allComponents;

          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Expanded(child: CurrencySelector()),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () =>
                          _showAddCustomIngredientDialog(context, compostState),
                      icon: const Icon(Icons.add,
                          size: 16, color: AppColors.onSecondary),
                      label: Text(S.of(context).addIngredient),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        foregroundColor: AppColors.onSecondary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        minimumSize: const Size(0, 32),
                      ),
                    ),
                  ],
                ),
              ),
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
