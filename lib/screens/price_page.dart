import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../compost_state.dart';
import '../models/compost_component_model.dart';

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
    return ListTile(
      title: Text(component.name),
      subtitle: Text(
        'Available: ${component.availability.toString().split('.').last}',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 120,
            child: TextFormField(
              initialValue: (component.price?.pricePerUnit ?? 0).toString(),
              decoration: const InputDecoration(
                labelText: 'Cost/Unit',
                suffixText: 'FCFA',
                isDense: true,
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                final newPrice = double.tryParse(value);
                if (newPrice != null) {
                  compostState.updateComponentPrice(component.name, newPrice);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        elevation: 0,
        title: const Text(
          'Component Prices',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Consumer<CompostState>(
        builder: (context, compostState, child) {
          final components = compostState.components;

          return ListView(
            children: [
              _buildSectionTitle('All Components'),
              ...components.map((component) =>
                  _buildComponentTile(component, compostState, context)),
            ],
          );
        },
      ),
    );
  }
}
