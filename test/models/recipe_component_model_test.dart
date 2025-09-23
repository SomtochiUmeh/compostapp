import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/models/recipe_component_model.dart';
import 'package:compostapp/models/compost_component_model.dart';
import 'package:compostapp/models/nutrient_content_model.dart';
import 'package:compostapp/models/price_model.dart';

// Create a mock CompostComponent for testing
class MockCompostComponent extends CompostComponent {
  final String mockName;

  MockCompostComponent({
    required super.id,
    required this.mockName,
    required super.nutrients,
    super.price,
  }) : super(
          name: mockName,
        );

  @override
  String getName() => mockName;
}

void main() {
  group('RecipeComponent', () {
    late CompostComponent testComponent;

    setUp(() {
      // Create a test component that can be reused across tests
      testComponent = MockCompostComponent(
        id: 'test-id',
        mockName: 'Test Component',
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
    });

    test('constructor initializes all properties correctly', () {
      const amount = 10.5;
      final recipeComponent = RecipeComponent(
        component: testComponent,
        amount: amount,
      );

      expect(recipeComponent.component, equals(testComponent));
      expect(recipeComponent.amount, equals(amount));
    });

    test('component property can be accessed directly', () {
      final recipeComponent = RecipeComponent(
        component: testComponent,
        amount: 5.0,
      );

      expect(recipeComponent.component.id, equals('test-id'));
      expect(recipeComponent.component.getName(), equals('Test Component'));
      expect(recipeComponent.component.price?.pricePerTon, equals(100));
    });

    test('amount property can be accessed directly', () {
      const testAmount = 7.25;
      final recipeComponent = RecipeComponent(
        component: testComponent,
        amount: testAmount,
      );

      expect(recipeComponent.amount, equals(testAmount));
    });

    test('works with zero amount', () {
      final recipeComponent = RecipeComponent(
        component: testComponent,
        amount: 0.0,
      );

      expect(recipeComponent.amount, equals(0.0));
    });

    test('works with negative amount (though semantically unusual)', () {
      // This is an edge case test, as negative amounts don't make practical sense
      // but the model should handle it without crashing
      final recipeComponent = RecipeComponent(
        component: testComponent,
        amount: -5.0,
      );

      expect(recipeComponent.amount, equals(-5.0));
    });

    test('works with very large amount', () {
      final recipeComponent = RecipeComponent(
        component: testComponent,
        amount: 9999999.0,
      );

      expect(recipeComponent.amount, equals(9999999.0));
    });

    test('handles component with null price', () {
      // Create component without price
      final noPriceComponent = MockCompostComponent(
        id: 'no-price-id',
        mockName: 'No Price Component',
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

      final recipeComponent = RecipeComponent(
        component: noPriceComponent,
        amount: 10.0,
      );

      expect(recipeComponent.component.price, isNull);
    });
  });
}
