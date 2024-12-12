// lib/screens/recipe_builder_page.dart
import 'package:flutter/material.dart';
import '../models/recipe_component_model.dart';
import '../models/recipe_model.dart';
import '../models/compost_component_model.dart';
import '../widgets/component_table.dart';
import '../widgets/add_component_dialog.dart';
import '../widgets/nutrient_totals_table.dart';
import '../data/compost_components_data.dart';
import '../services/persistence_manager.dart';

class RecipeBuilderPage extends StatefulWidget {
  final PersistenceManager persistenceManager;

  const RecipeBuilderPage({
    super.key,
    required this.persistenceManager,
  });

  @override
  State<RecipeBuilderPage> createState() => _RecipeBuilderPageState();
}

class _RecipeBuilderPageState extends State<RecipeBuilderPage> {
  List<RecipeComponent> selectedComponents = [];

  @override
  void initState() {
    super.initState();
    _loadSavedRecipe();
  }

  Future<void> _loadSavedRecipe() async {
    final savedRecipe = await widget.persistenceManager.getLatestRecipe();
    if (savedRecipe != null) {
      setState(() {
        selectedComponents = savedRecipe.components;
      });
    }
  }

  Future<void> _saveRecipe() async {
    final recipe = Recipe(components: selectedComponents);
    await widget.persistenceManager.saveRecipe(recipe);
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isLandscape ? 5.0 : 10.0),
      child: Row(
        children: [
          Icon(icon, size: isLandscape ? 20 : 30),
          SizedBox(width: isLandscape ? 5 : 10),
          Text(
            title,
            style: TextStyle(
              fontSize: isLandscape ? 16 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddComponentDialog(BuildContext context) {
    final availableComponents =
        CompostComponentsData.getAvailableComponents(DateTime.now())
            .where((component) => !selectedComponents
                .any((selected) => selected.component.name == component.name))
            .toList();

    if (availableComponents.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All available components have been added'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AddComponentDialog(
        availableComponents: availableComponents,
        onAdd: _addComponent,
      ),
    );
  }

  void _addComponent(CompostComponent component, double weight) {
    setState(() {
      selectedComponents.add(RecipeComponent(
        component: component,
        amount: weight,
      ));
      _saveRecipe();
    });
  }

  void _editComponent(int index) {
    final component = selectedComponents[index];

    showDialog(
      context: context,
      builder: (context) => AddComponentDialog(
        availableComponents: [component.component],
        initialWeight: component.amount,
        onAdd: (comp, weight) {
          setState(() {
            selectedComponents[index] = RecipeComponent(
              component: comp,
              amount: weight,
            );
            _saveRecipe();
          });
        },
      ),
    );
  }

  void _deleteComponent(int index) {
    setState(() {
      selectedComponents.removeAt(index);
      _saveRecipe();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        elevation: 0,
        title: Text(
          'Compost Recipe Builder',
          style: TextStyle(
            color: Colors.white,
            fontSize: isLandscape ? 16 : 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Recipe Quality Guide'),
                  content: const SingleChildScrollView(
                    child: Text(
                      'Green checkmark: Nutrient level is within recommended range\n'
                      'Red up arrow: Nutrient level is below recommended range\n'
                      'Orange down arrow: Nutrient level is above recommended range\n\n'
                      'Recommended ranges are based on municipal compost standards.',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSectionTitle('Components', Icons.compost),
                    if (selectedComponents.isEmpty)
                      const Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'No components added yet. Click the button below to add components to your compost recipe.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    else
                      ComponentTable(
                        items: selectedComponents,
                        onEdit: _editComponent,
                        onDelete: _deleteComponent,
                      ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () => _showAddComponentDialog(context),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Component'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade300,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (selectedComponents.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _buildSectionTitle('Nutrient Analysis', Icons.analytics),
                  NutrientTotalsTable(
                    components: selectedComponents,
                  ),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}
