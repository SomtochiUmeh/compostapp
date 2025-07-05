import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:compostapp/widgets/nutrient_totals_table.dart';
import 'package:compostapp/models/recipe_component_model.dart';
import 'package:compostapp/models/compost_component_model.dart';
import 'package:compostapp/models/nutrient_content_model.dart';
import 'package:compostapp/models/price_model.dart';
import 'package:compostapp/compost_state.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([CompostState])
import 'nutrient_totals_table_test.mocks.dart';

// Helper function to create a testable nutrient totals table
Widget createTestableTable({
  required List<RecipeComponent> components,
}) {
  final mockCompostState = MockCompostState();
  when(mockCompostState.selectedCurrency).thenReturn('CFA');

  return ChangeNotifierProvider<CompostState>.value(
    value: mockCompostState,
    child: MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: ScaffoldMessenger(
        child: Builder(
          builder: (BuildContext context) {
            return Scaffold(
              body: NutrientTotalsTable(
                components: components,
              ),
            );
          },
        ),
      ),
    ),
  );
}

// Create a custom CompostComponent implementation for testing
class TestCompostComponent extends CompostComponent {
  final String displayName;

  TestCompostComponent({
    required super.id,
    required this.displayName,
    required super.nutrients,
    super.price,
    super.sources,
  }) : super(
          name: displayName,
        );

  @override
  String getName() => displayName;
}

void main() {
  late List<RecipeComponent> testComponents;

  setUp(() {
    // Clear shown notifications before each test
    NutrientTotalsTable.shownNotifications.clear();

    // Initialize test components
    testComponents = [
      RecipeComponent(
        component: TestCompostComponent(
          id: 'test1',
          displayName: 'Test Component 1',
          nutrients: const NutrientContent(
            dryMatterPercent: 0.5,
            organicCarbonPercent: 0.3,
            nitrogenPercent: 0.01,
            phosphorusPercent: 0.05,
            potassiumPercent: 0.02,
            calciumPercent: 0.03,
            magnesiumPercent: 0.01,
            carbonNitrogenRatio: 30.0,
          ),
          price: Price(pricePerTon: 100),
        ),
        amount: 10.0,
      ),
      RecipeComponent(
        component: TestCompostComponent(
          id: 'test2',
          displayName: 'Test Component 2',
          nutrients: const NutrientContent(
            dryMatterPercent: 0.6,
            organicCarbonPercent: 0.4,
            nitrogenPercent: 0.02,
            phosphorusPercent: 0.06,
            potassiumPercent: 0.03,
            calciumPercent: 0.04,
            magnesiumPercent: 0.02,
            carbonNitrogenRatio: 20.0,
          ),
        ),
        amount: 5.0,
      ),
    ];
  });

  group('NutrientTotalsTable Widget Tests', () {
    testWidgets('Renders correctly with components',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTable(
        components: testComponents,
      ));

      await tester.pumpAndSettle();

      // Verify total weight calculation
      // Total weight should be 10.0 + 5.0 = 15.0
      expect(find.text('15.00'), findsOneWidget);

      // Find the DataTable
      expect(find.byType(DataTable), findsOneWidget);
    });

    testWidgets('Handles empty components list', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTable(
        components: [],
      ));

      await tester.pumpAndSettle();

      // DataTable is rendered even when empty
      expect(find.byType(DataTable), findsOneWidget);

      // Should show 0.00 for all values
      expect(find.text('0.00'), findsAtLeastNWidgets(1));
    });

    testWidgets('Shows comparison icons for C/N ratio',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTable(
        components: testComponents,
      ));

      await tester.pumpAndSettle();

      // Verify upward arrow icon is present since test data is less than ideal C/N ratio
      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
    });

    testWidgets('Shows too low alert for C/N ratio',
        (WidgetTester tester) async {
      // Create components with low C/N ratio
      final lowCNComponents = [
        RecipeComponent(
          component: TestCompostComponent(
            id: 'low1',
            displayName: 'Low CN Component',
            nutrients: const NutrientContent(
              dryMatterPercent: 0.5,
              organicCarbonPercent: 0.2,
              nitrogenPercent: 0.1,
              phosphorusPercent: 0.05,
              potassiumPercent: 0.02,
              calciumPercent: 0.03,
              magnesiumPercent: 0.01,
              carbonNitrogenRatio: 2.0,
            ),
          ),
          amount: 10.0,
        ),
      ];

      await tester.pumpWidget(createTestableTable(
        components: lowCNComponents,
      ));

      await tester.pumpAndSettle();

      // Wait for all post frame callbacks to complete
      await tester.pump(const Duration(seconds: 1));

      // Verify upward arrow (too low) is shown
      expect(find.byIcon(Icons.arrow_upward), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsNothing);
    });

    testWidgets('Shows too high alert for C/N ratio',
        (WidgetTester tester) async {
      // Create components with high C/N ratio
      final highCNComponents = [
        RecipeComponent(
          component: TestCompostComponent(
            id: 'high1',
            displayName: 'High CN Component',
            nutrients: const NutrientContent(
              dryMatterPercent: 0.5,
              organicCarbonPercent: 0.8,
              nitrogenPercent: 0.01,
              phosphorusPercent: 0.05,
              potassiumPercent: 0.02,
              calciumPercent: 0.03,
              magnesiumPercent: 0.01,
              carbonNitrogenRatio: 80.0,
            ),
          ),
          amount: 10.0,
        ),
      ];

      await tester.pumpWidget(createTestableTable(
        components: highCNComponents,
      ));

      await tester.pumpAndSettle();

      // Wait for all post frame callbacks to complete
      await tester.pump(const Duration(seconds: 1));

      // Verify downward arrow (too high) is shown
      expect(find.byIcon(Icons.arrow_downward), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsNothing);
    });

    testWidgets('Calculates total cost correctly', (WidgetTester tester) async {
      // Only first component has price (100 per ton)
      // Cost = 100/1000 * 10 = 1.00
      await tester.pumpWidget(createTestableTable(
        components: testComponents,
      ));

      await tester.pumpAndSettle();

      // Verify total cost is shown correctly (formatted with currency)
      expect(find.text('FCFA 1'), findsOneWidget);
    });
  });
}
