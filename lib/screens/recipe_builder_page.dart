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
import '../constants/app_colors.dart';

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
    final availableComponents = compostState.allComponents
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

    // For custom ingredients, look up by ID to handle name changes
    // For predefined ingredients, look up by name for backwards compatibility
    CompostComponent? updatedComponent;
    if (component.component.isCustom) {
      updatedComponent = compostState.allComponents
          .where((c) => c.id == component.component.id)
          .firstOrNull;
    } else {
      updatedComponent = compostState.allComponents
          .where((c) => c.getName() == component.component.getName())
          .firstOrNull;
    }

    // If component not found (e.g., custom ingredient was deleted), show error
    if (updatedComponent == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                S.of(context).ingredientNoLongerExists(component.component.getName()))),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AddComponentDialog(
        availableComponents: [updatedComponent!],
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

  // Helper method to compare component lists for changes
  bool _componentsEqual(
      List<RecipeComponent> list1, List<RecipeComponent> list2) {
    if (list1.length != list2.length) return false;

    for (int i = 0; i < list1.length; i++) {
      if (list1[i].component.id != list2[i].component.id ||
          list1[i].amount != list2[i].amount) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CompostState>(
        builder: (context, compostState, child) {
          // Update selected components with latest prices and availability
          // Also filter out any deleted custom ingredients
          final updatedComponents = selectedComponents.where((component) {
            // Keep component only if it still exists
            if (component.component.isCustom) {
              return compostState.allComponents
                  .any((c) => c.id == component.component.id);
            } else {
              return compostState.allComponents
                  .any((c) => c.getName() == component.component.getName());
            }
          }).map((component) {
            CompostComponent latestComponent;

            // For custom ingredients, look up by ID to handle name changes
            if (component.component.isCustom) {
              latestComponent = compostState.allComponents
                      .where((c) => c.id == component.component.id)
                      .firstOrNull ??
                  component.component;
            } else {
              // For predefined ingredients, look up by name
              latestComponent = compostState.allComponents
                      .where(
                          (c) => c.getName() == component.component.getName())
                      .firstOrNull ??
                  component.component;
            }
            return RecipeComponent(
              component: latestComponent,
              amount: component.amount,
            );
          }).toList();

          // Update selectedComponents if there are changes (updates or deletions)
          final originalLength = selectedComponents.length;
          if (updatedComponents.length != selectedComponents.length ||
              !_componentsEqual(selectedComponents, updatedComponents)) {
            // Defer setState to avoid calling it during build
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  selectedComponents = updatedComponents;
                });
                if (updatedComponents.length < originalLength) {
                  // Some ingredients were deleted, save the updated recipe and notify user
                  _saveRecipe();
                  final removedCount =
                      originalLength - updatedComponents.length;
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          removedCount == 1
                              ? S.of(context).removedDeletedIngredientSingle
                              : S.of(context).removedDeletedIngredientsMultiple(removedCount),
                        ),
                        backgroundColor: AppColors.secondary,
                      ),
                    );
                  }
                }
              }
            });
          }

          // Use updatedComponents for rendering to immediately reflect changes
          final componentsToDisplay = updatedComponents;

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
                        if (componentsToDisplay.isEmpty)
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
                            items: componentsToDisplay,
                            onEdit: _editComponent,
                            onDelete: _deleteComponent,
                          ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () => _showAddComponentDialog(context),
                          icon: const Icon(Icons.add),
                          label: Text(S.of(context).addIngredient),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            foregroundColor: AppColors.onSecondary,
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
                    if (componentsToDisplay.isNotEmpty) ...[
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
                        components: componentsToDisplay,
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
