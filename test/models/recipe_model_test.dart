import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/models/recipe_model.dart';
import 'package:compostapp/models/recipe_component_model.dart';
import 'package:compostapp/models/compost_component_model.dart';
import 'package:compostapp/models/availability_model.dart';
import 'package:compostapp/models/nutrient_content_model.dart';
import 'package:compostapp/models/price_model.dart';

// Create a mock CompostComponent for testing
class MockCompostComponent extends CompostComponent {
  final String mockName;

  MockCompostComponent({
    required super.id,
    required this.mockName,
    required super.availability,
    required super.nutrients,
    super.price,
  }) : super(
          name: mockName,
        );

  @override
  String getName() => mockName;
}

void main() {
  group('Recipe', () {
    late List<RecipeComponent> testComponents;
    final testDate = DateTime(2023, 5, 15);

    setUp(() {
      // Create test components that can be reused across tests
      final component1 = MockCompostComponent(
        id: 'comp1',
        mockName: 'Component 1',
        availability: AvailabilityPeriod.janToDec,
        nutrients: const NutrientContent(
          dryMatterPercent: 0.5, // 50%
          organicCarbonPercent: 0.3, // 30%
          nitrogenPercent: 0.01, // 1%
          phosphorusPercent: 0.05,
          potassiumPercent: 0.02,
          calciumPercent: 0.03,
          magnesiumPercent: 0.01,
          carbonNitrogenRatio: 30.0,
        ),
        price: Price(pricePerTon: 100),
      );

      final component2 = MockCompostComponent(
        id: 'comp2',
        mockName: 'Component 2',
        availability: AvailabilityPeriod.marToAug,
        nutrients: const NutrientContent(
          dryMatterPercent: 0.8, // 80%
          organicCarbonPercent: 0.4, // 40%
          nitrogenPercent: 0.02, // 2%
          phosphorusPercent: 0.06,
          potassiumPercent: 0.03,
          calciumPercent: 0.04,
          magnesiumPercent: 0.02,
          carbonNitrogenRatio: 20.0,
        ),
      );

      testComponents = [
        RecipeComponent(component: component1, amount: 10.0),
        RecipeComponent(component: component2, amount: 5.0),
      ];
    });

    test('constructor initializes properties correctly', () {
      final recipe = Recipe(
        components: testComponents,
        createdAt: testDate,
      );

      expect(recipe.components, equals(testComponents));
      expect(recipe.createdAt, equals(testDate));
    });

    test('constructor uses current DateTime if createdAt is not provided', () {
      final beforeTime = DateTime.now();
      final recipe = Recipe(components: testComponents);
      final afterTime = DateTime.now();

      // Recipe creation time should be between the before and after timestamps
      expect(
          recipe.createdAt.isAfter(beforeTime) ||
              recipe.createdAt.isAtSameMomentAs(beforeTime),
          true);
      expect(
          recipe.createdAt.isBefore(afterTime) ||
              recipe.createdAt.isAtSameMomentAs(afterTime),
          true);
    });

    test('totalWeight returns sum of all component weights', () {
      final recipe = Recipe(components: testComponents);

      // 10.0 + 5.0 = 15.0
      expect(recipe.totalWeight, equals(15.0));
    });

    test('totalWeight returns 0 for empty recipe', () {
      final recipe = Recipe(components: []);
      expect(recipe.totalWeight, equals(0.0));
    });

    test('calculateNutrients returns correct nutrient percentages', () {
      final recipe = Recipe(components: testComponents);
      final nutrients = recipe.calculateNutrients();

      // Calculate expected values:
      // Component 1: 10.0 kg, 50% dry matter = 5.0 kg DM
      // Component 2: 5.0 kg, 80% dry matter = 4.0 kg DM
      // Total: 9.0 kg DM out of 15.0 kg total = 60% DM
      expect(nutrients['dryMatter'], closeTo(0.6, 0.001)); // 60%

      // Organic Carbon:
      // Component 1: 10.0 kg, 30% organic carbon = 3.0 kg OC
      // Component 2: 5.0 kg, 40% organic carbon = 2.0 kg OC
      // Total: 5.0 kg OC out of 15.0 kg total = 33.33% OC
      expect(nutrients['organicCarbon'], closeTo(0.333, 0.001)); // 33.3%

      // Nitrogen:
      // Component 1: 10.0 kg, 1% nitrogen = 0.1 kg N
      // Component 2: 5.0 kg, 2% nitrogen = 0.1 kg N
      // Total: 0.2 kg N out of 15.0 kg total = 1.33% N
      expect(nutrients['nitrogen'], closeTo(0.0133, 0.001)); // 1.33%
    });

    test('calculateNutrients returns empty map for empty recipe', () {
      final recipe = Recipe(components: []);
      final nutrients = recipe.calculateNutrients();

      expect(nutrients, isEmpty);
    });

    test('calculateNutrients works with single component', () {
      final singleComponentRecipe = Recipe(
        components: [testComponents.first], // Just the first component
      );

      final nutrients = singleComponentRecipe.calculateNutrients();

      // For the first component, the values should match its nutrient percentages
      expect(nutrients['dryMatter'], closeTo(0.5, 0.001)); // 50%
      expect(nutrients['organicCarbon'], closeTo(0.3, 0.001)); // 30%
      expect(nutrients['nitrogen'], closeTo(0.01, 0.001)); // 1%
    });
  });
}
