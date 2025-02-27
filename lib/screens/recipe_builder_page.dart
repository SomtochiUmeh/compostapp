import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe_component_model.dart';
import '../models/recipe_model.dart';
import '../models/compost_component_model.dart';
import '../widgets/component_table.dart';
import '../widgets/add_component_dialog.dart';
import '../widgets/nutrient_totals_table.dart';
import '../compost_state.dart';
import '../services/persistence_manager.dart';
import '../generated/l10n.dart';

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
      padding: const EdgeInsets.symmetric(vertical: 0.5),
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
    // Get the latest component data from CompostState
    final compostState = context.read<CompostState>();
    final availableComponents = compostState.components
        .where((component) => !selectedComponents.any(
            (selected) => selected.component.getName() == component.getName()))
        .toList();

    if (availableComponents.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).allAvailableComponentsHaveBeenAdded),
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
    // // Convert weight to kg if the component is measured in tons
    // final adjustedWeight =
    //     component.unit.toLowerCase() == 'tons' ? weight * 1000 : weight;

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
    // Get the latest component data from CompostState
    final compostState = context.read<CompostState>();
    final updatedComponent = compostState.components
        .firstWhere((c) => c.getName() == component.component.getName());

    showDialog(
      context: context,
      builder: (context) => AddComponentDialog(
        availableComponents: [updatedComponent],
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
    return Scaffold(
      body: Consumer<CompostState>(
        builder: (context, compostState, child) {
          // Update selected components with latest prices and availability
          final updatedComponents = selectedComponents.map((component) {
            final latestComponent = compostState.components.firstWhere(
              (c) => c.getName() == component.component.getName(),
              orElse: () => component.component,
            );
            return RecipeComponent(
              component: latestComponent,
              amount: component.amount,
            );
          }).toList();

          if (updatedComponents.length == selectedComponents.length) {
            selectedComponents = updatedComponents;
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildSectionTitle(
                            S.of(context).ingredients, Icons.compost),
                        if (selectedComponents.isEmpty)
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                S
                                    .of(context)
                                    .noComponentsAddedYetClickTheButtonBelowToAdd,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 16),
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
                          label: Text(S.of(context).addIngredient),
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
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  children: [
                    if (selectedComponents.isNotEmpty) ...[
                      Row(
                        children: [
                          _buildSectionTitle(
                              S.of(context).nutrientAnalysis, Icons.analytics),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.info_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(S.of(context).recipeQualityGuide),
                                  content: SingleChildScrollView(
                                    child: Text(
                                      S.of(context).recipeQualityInfo,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(S.of(context).close),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      NutrientTotalsTable(
                        components: selectedComponents,
                      ),
                    ]
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
