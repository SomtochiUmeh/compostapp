import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../compost_state.dart';
import '../models/compost_component_model.dart';
import '../generated/l10n.dart';
import '../widgets/edit_availability_dialog.dart';

class PricesPage extends StatelessWidget {
  const PricesPage({super.key});

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
            child: TextFormField(
              initialValue: (component.price?.pricePerTon ?? 0).toString(),
              decoration: InputDecoration(
                labelText: S.of(context).costPerTon,
                suffixText: S.of(context).currencyFCFA,
                isDense: true,
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                final newPrice = double.tryParse(value);
                if (newPrice != null) {
                  compostState.updateComponentPrice(
                      component.getName(), newPrice);
                }
              },
            ),
          ),
        ),
        const Divider(),
      ],
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
