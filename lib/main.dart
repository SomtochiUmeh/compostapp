import 'package:flutter/material.dart';
import './screens/recipe_builder_page.dart';
import './services/persistence_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PersistenceManager.init();
  runApp(MaterialApp(
    home: RecipeBuilderPage(
      persistenceManager: PersistenceManager(),
    ),
  ));
}
