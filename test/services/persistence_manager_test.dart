import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:compostapp/services/persistence_manager.dart';
import 'package:compostapp/models/recipe_model.dart';
import 'package:compostapp/models/recipe_component_model.dart';
import 'package:compostapp/models/compost_component_model.dart';
import 'package:compostapp/models/price_model.dart';
import 'package:compostapp/models/nutrient_content_model.dart';
import 'package:compostapp/models/availability_model.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';

// Create a test-friendly version of CompostComponent with overridden getName
class TestCompostComponent extends CompostComponent {
  TestCompostComponent({
    required super.id,
    required super.name,
    required super.availability,
    required super.nutrients,
    super.price,
    super.sources,
  });

  @override
  String getName() => name; // Directly return name without using S.current
}

void main() {
  late PersistenceManager persistenceManager;
  late Map<String, Object> fakeSharedPrefs;

  // Initialize the widget binding for tests
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  // Sample test data using our test-friendly component
  final testComponent = TestCompostComponent(
    id: 'test1',
    name: 'Test Component 1',
    availability: AvailabilityPeriod.janToDec,
    nutrients: const NutrientContent(
      dryMatterPercent: 0.5,
      organicCarbonPercent: 0.3,
      nitrogenPercent: 0.1,
      phosphorusPercent: 0.05,
      potassiumPercent: 0.02,
      calciumPercent: 0.03,
      magnesiumPercent: 0.01,
      carbonNitrogenRatio: 3.0,
    ),
    price: Price(pricePerTon: 100),
  );

  final testRecipe = Recipe(
    components: [
      RecipeComponent(
        component: testComponent,
        amount: 10.0,
      ),
    ],
    createdAt: DateTime(2023, 5, 15),
  );

  setUp(() async {
    // Initialize fake shared preferences data
    fakeSharedPrefs = {};

    // Set up the fake SharedPreferences instance
    SharedPreferences.setMockInitialValues(fakeSharedPrefs);

    // Initialize PersistenceManager
    await PersistenceManager.init();
    persistenceManager = PersistenceManager();
  });

  group('PersistenceManager Tests', () {
    test('saveRecipe saves current recipe correctly', () async {
      // Act
      final result = await persistenceManager.saveRecipe(testRecipe);

      // Assert
      expect(result, true);

      // Verify SharedPreferences was updated correctly
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('current_recipe'), isNotNull);

      // Decode the stored recipe and verify content
      final recipeJson = prefs.getString('current_recipe');
      final decodedMap = json.decode(recipeJson!);
      expect(decodedMap['components'], isNotEmpty);
      expect(decodedMap['createdAt'], isNotNull);
    });

    test('saveRecipe updates recipe history correctly', () async {
      // Act
      final result = await persistenceManager.saveRecipe(testRecipe);

      // Assert
      expect(result, true);

      // Verify recipe history was updated
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getString('recipes_history');
      expect(historyJson, isNotNull);

      // Decode the stored history and verify content
      final historyList = json.decode(historyJson!);
      expect(historyList, isA<List>());
      expect(historyList.length, 1);
      expect(historyList[0]['components'], isNotEmpty);
    });

    test('getLatestRecipe returns null when no recipe exists', () async {
      // Act
      final recipe = await persistenceManager.getLatestRecipe();

      // Assert
      expect(recipe, isNull);
    });

    test('getLatestRecipe returns saved recipe correctly', () async {
      // Arrange - Save a recipe first
      await persistenceManager.saveRecipe(testRecipe);

      // Act
      final recipe = await persistenceManager.getLatestRecipe();

      // Assert
      expect(recipe, isNotNull);
      expect(recipe!.components.length, 1);
      expect(recipe.components[0].amount, 10.0);
      expect(recipe.components[0].component.id, 'test1');
    });

    test('getRecipeHistory returns empty list when no history exists',
        () async {
      // Act
      final history = await persistenceManager.getRecipeHistory();

      // Assert
      expect(history, isEmpty);
    });

    test('getRecipeHistory returns correct history', () async {
      // Arrange - Save multiple recipes to create history
      await persistenceManager.saveRecipe(testRecipe);

      // Create a second recipe with different amounts
      final testRecipe2 = Recipe(
        components: [
          RecipeComponent(
            component: testComponent,
            amount: 20.0,
          ),
        ],
        createdAt: DateTime(2023, 5, 16),
      );
      await persistenceManager.saveRecipe(testRecipe2);

      // Act
      final history = await persistenceManager.getRecipeHistory();

      // Assert
      expect(history, isNotEmpty);
      expect(history.length, 2);
      expect(history[0].components[0].amount, 20.0); // Most recent first
      expect(history[1].components[0].amount, 10.0);
    });

    test('updateComponentInfo saves components correctly', () async {
      // Arrange
      final components = [testComponent];

      // Act
      final result = await persistenceManager.updateComponentInfo(components);

      // Assert
      expect(result, true);

      // Verify components were saved correctly
      final prefs = await SharedPreferences.getInstance();
      final componentsJson = prefs.getString('components_data');
      expect(componentsJson, isNotNull);

      // Decode and verify content
      final decodedComponents = json.decode(componentsJson!);
      expect(decodedComponents, isA<List>());
      expect(decodedComponents.length, 1);
      expect(decodedComponents[0]['id'], 'test1');
    });

    test('getSavedComponents returns null when no components exist', () async {
      // Act
      final components = await persistenceManager.getSavedComponents();

      // Assert
      expect(components, isNull);
    });

    test('getSavedComponents returns saved components correctly', () async {
      // Arrange - Save components first
      final components = [testComponent];
      await persistenceManager.updateComponentInfo(components);

      // Act
      final savedComponents = await persistenceManager.getSavedComponents();

      // Assert
      expect(savedComponents, isNotNull);
      expect(savedComponents!.length, 1);
      expect(savedComponents[0].id, 'test1');

      // Test the name property directly instead of getName()
      expect(savedComponents[0].name, 'Test Component 1');
    });

    test('clearCurrentRecipe removes current recipe', () async {
      // Arrange - Save a recipe first
      await persistenceManager.saveRecipe(testRecipe);

      // Act
      final result = await persistenceManager.clearCurrentRecipe();

      // Assert
      expect(result, true);

      // Verify recipe was removed
      final recipe = await persistenceManager.getLatestRecipe();
      expect(recipe, isNull);
    });

    test('clearRecipeHistory removes history', () async {
      // Arrange - Save a recipe to create history
      await persistenceManager.saveRecipe(testRecipe);

      // Act
      final result = await persistenceManager.clearRecipeHistory();

      // Assert
      expect(result, true);

      // Verify history was cleared
      final history = await persistenceManager.getRecipeHistory();
      expect(history, isEmpty);
    });

    test('clearComponentData removes saved components', () async {
      // Arrange - Save components first
      final components = [testComponent];
      await persistenceManager.updateComponentInfo(components);

      // Act
      final result = await persistenceManager.clearComponentData();

      // Assert
      expect(result, true);

      // Verify components were removed
      final savedComponents = await persistenceManager.getSavedComponents();
      expect(savedComponents, isNull);
    });

    test('clearAll removes all saved data', () async {
      // Arrange - Save recipe and components
      await persistenceManager.saveRecipe(testRecipe);
      await persistenceManager.updateComponentInfo([testComponent]);

      // Act
      final result = await persistenceManager.clearAll();

      // Assert
      expect(result, true);

      // Verify all data was cleared
      final recipe = await persistenceManager.getLatestRecipe();
      final history = await persistenceManager.getRecipeHistory();
      final components = await persistenceManager.getSavedComponents();

      expect(recipe, isNull);
      expect(history, isEmpty);
      expect(components, isNull);
    });

    test('_recipeToJson and _recipeFromJson correctly serialize recipe',
        () async {
      // This is testing a private method indirectly by using saveRecipe and getLatestRecipe
      // Arrange
      await persistenceManager.saveRecipe(testRecipe);

      // Act
      final savedRecipe = await persistenceManager.getLatestRecipe();

      // Assert - Check if properties match after serialization and deserialization
      expect(savedRecipe?.components.length, testRecipe.components.length);
      expect(
          savedRecipe?.components[0].amount, testRecipe.components[0].amount);
      expect(savedRecipe?.components[0].component.id,
          testRecipe.components[0].component.id);
      expect(savedRecipe?.createdAt.year, testRecipe.createdAt.year);
      expect(savedRecipe?.createdAt.month, testRecipe.createdAt.month);
      expect(savedRecipe?.createdAt.day, testRecipe.createdAt.day);
    });

    test('Recipe history is limited to 10 recipes', () async {
      // Arrange - Create and save 12 recipes
      for (int i = 0; i < 12; i++) {
        final recipe = Recipe(
          components: [
            RecipeComponent(
              component: testComponent,
              amount: (i + 1) * 10.0,
            ),
          ],
          createdAt: DateTime(2023, 5, i + 1),
        );
        await persistenceManager.saveRecipe(recipe);
      }

      // Act
      final history = await persistenceManager.getRecipeHistory();

      // Assert
      expect(history.length, 10); // Should be limited to 10
      expect(history[0].components[0].amount, 120.0); // Most recent first
    });

    test('Components with custom availability periods are serialized correctly',
        () async {
      // Arrange
      final customComponent = CompostComponent(
        id: 'custom1',
        name: 'Custom Component',
        availability: AvailabilityPeriod(2, 7), // Custom Feb-Jul availability
        nutrients: const NutrientContent(
          dryMatterPercent: 0.5,
          organicCarbonPercent: 0.3,
          nitrogenPercent: 0.1,
          phosphorusPercent: 0.05,
          potassiumPercent: 0.02,
          calciumPercent: 0.03,
          magnesiumPercent: 0.01,
          carbonNitrogenRatio: 3.0,
        ),
      );

      // Act
      await persistenceManager.updateComponentInfo([customComponent]);
      final savedComponents = await persistenceManager.getSavedComponents();

      // Assert
      expect(savedComponents, isNotNull);
      expect(savedComponents!.length, 1);
      expect(savedComponents[0].availability.startMonth, 2);
      expect(savedComponents[0].availability.endMonth, 7);
    });

    group('Currency Management', () {
      test('setSelectedCurrency saves currency successfully', () async {
        // Act
        final result = await persistenceManager.setSelectedCurrency('USD');

        // Assert
        expect(result, isTrue);
        
        // Verify by reading back from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('selected_currency'), 'USD');
      });

      test('getSelectedCurrency returns saved currency', () async {
        // Arrange
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('selected_currency', 'EUR');

        // Act
        final currency = await persistenceManager.getSelectedCurrency();

        // Assert
        expect(currency, 'EUR');
      });

      test('getSelectedCurrency returns null when no currency saved', () async {
        // Act
        final currency = await persistenceManager.getSelectedCurrency();

        // Assert
        expect(currency, isNull);
      });

      test('setSelectedCurrency overwrites existing currency', () async {
        // Arrange
        await persistenceManager.setSelectedCurrency('USD');

        // Act
        final result = await persistenceManager.setSelectedCurrency('GBP');

        // Assert
        expect(result, isTrue);
        
        // Verify by reading back from SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('selected_currency'), 'GBP');
      });
    });

    group('Regional Pricing Serialization', () {
      test('components with regional prices are serialized correctly', () async {
        // Arrange
        final componentWithRegionalPricing = TestCompostComponent(
          id: 'regional1',
          name: 'Regional Component',
          availability: AvailabilityPeriod.janToDec,
          nutrients: const NutrientContent(
            dryMatterPercent: 0.5,
            organicCarbonPercent: 0.3,
            nitrogenPercent: 0.1,
            phosphorusPercent: 0.05,
            potassiumPercent: 0.02,
            calciumPercent: 0.03,
            magnesiumPercent: 0.01,
            carbonNitrogenRatio: 3.0,
          ),
          price: Price(
            pricePerTon: 1000,
            regionalPrices: {
              'USD': 1.5,
              'EUR': 2.0,
              'GBP': 2.5,
            },
          ),
        );

        // Act
        await persistenceManager.updateComponentInfo([componentWithRegionalPricing]);
        final savedComponents = await persistenceManager.getSavedComponents();

        // Assert
        expect(savedComponents, isNotNull);
        expect(savedComponents!.length, 1);
        
        final savedComponent = savedComponents[0];
        expect(savedComponent.price, isNotNull);
        expect(savedComponent.price!.pricePerTon, 1000);
        expect(savedComponent.price!.regionalPrices, isNotNull);
        expect(savedComponent.price!.regionalPrices!['USD'], 1.5);
        expect(savedComponent.price!.regionalPrices!['EUR'], 2.0);
        expect(savedComponent.price!.regionalPrices!['GBP'], 2.5);
      });

      test('components without regional prices are serialized correctly', () async {
        // Arrange
        final componentWithoutRegionalPricing = TestCompostComponent(
          id: 'no_regional1',
          name: 'No Regional Component',
          availability: AvailabilityPeriod.janToDec,
          nutrients: const NutrientContent(
            dryMatterPercent: 0.5,
            organicCarbonPercent: 0.3,
            nitrogenPercent: 0.1,
            phosphorusPercent: 0.05,
            potassiumPercent: 0.02,
            calciumPercent: 0.03,
            magnesiumPercent: 0.01,
            carbonNitrogenRatio: 3.0,
          ),
          price: Price(pricePerTon: 500),
        );

        // Act
        await persistenceManager.updateComponentInfo([componentWithoutRegionalPricing]);
        final savedComponents = await persistenceManager.getSavedComponents();

        // Assert
        expect(savedComponents, isNotNull);
        expect(savedComponents!.length, 1);
        
        final savedComponent = savedComponents[0];
        expect(savedComponent.price, isNotNull);
        expect(savedComponent.price!.pricePerTon, 500);
        expect(savedComponent.price!.regionalPrices, isNull);
      });

      test('regional prices with decimal values are preserved', () async {
        // Arrange
        final componentWithDecimalPrices = TestCompostComponent(
          id: 'decimal1',
          name: 'Decimal Component',
          availability: AvailabilityPeriod.janToDec,
          nutrients: const NutrientContent(
            dryMatterPercent: 0.5,
            organicCarbonPercent: 0.3,
            nitrogenPercent: 0.1,
            phosphorusPercent: 0.05,
            potassiumPercent: 0.02,
            calciumPercent: 0.03,
            magnesiumPercent: 0.01,
            carbonNitrogenRatio: 3.0,
          ),
          price: Price(
            pricePerTon: 1234.56,
            regionalPrices: {
              'USD': 1.234,
              'EUR': 2.567,
            },
          ),
        );

        // Act
        await persistenceManager.updateComponentInfo([componentWithDecimalPrices]);
        final savedComponents = await persistenceManager.getSavedComponents();

        // Assert
        final savedComponent = savedComponents![0];
        expect(savedComponent.price!.pricePerTon, 1234.56);
        expect(savedComponent.price!.regionalPrices!['USD'], 1.234);
        expect(savedComponent.price!.regionalPrices!['EUR'], 2.567);
      });

      test('empty regional prices map is handled correctly', () async {
        // Arrange - Create price with empty regional prices
        final price = Price(pricePerTon: 1000, regionalPrices: {});
        final component = TestCompostComponent(
          id: 'empty1',
          name: 'Empty Regional',
          availability: AvailabilityPeriod.janToDec,
          nutrients: const NutrientContent(
            dryMatterPercent: 0.5,
            organicCarbonPercent: 0.3,
            nitrogenPercent: 0.1,
            phosphorusPercent: 0.05,
            potassiumPercent: 0.02,
            calciumPercent: 0.03,
            magnesiumPercent: 0.01,
            carbonNitrogenRatio: 3.0,
          ),
          price: price,
        );

        // Act
        await persistenceManager.updateComponentInfo([component]);
        final savedComponents = await persistenceManager.getSavedComponents();

        // Assert
        final savedComponent = savedComponents![0];
        expect(savedComponent.price, isNotNull);
        expect(savedComponent.price!.regionalPrices, isNotNull);
        expect(savedComponent.price!.regionalPrices!.isEmpty, isTrue);
      });
    });
  });
}
