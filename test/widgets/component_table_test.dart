import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:compostapp/widgets/component_table.dart';
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
import 'component_table_test.mocks.dart';

// Helper function to create a testable component table
Widget createTestableTable({
  required List<RecipeComponent> items,
  required Function(int) onEdit,
  required Function(int) onDelete,
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
      home: Scaffold(
        body: ComponentTable(
          items: items,
          onEdit: onEdit,
          onDelete: onDelete,
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
  late List<RecipeComponent> testItems;

  setUp(() {
    // Initialize test items
    testItems = [
      RecipeComponent(
        component: TestCompostComponent(
          id: 'test1',
          displayName: 'Test Component 1',
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
            nitrogenPercent: 0.2,
            phosphorusPercent: 0.06,
            potassiumPercent: 0.03,
            calciumPercent: 0.04,
            magnesiumPercent: 0.02,
            carbonNitrogenRatio: 2.0,
          ),
        ),
        amount: 15.0,
      ),
    ];
  });

  group('ComponentTable Widget Tests', () {
    testWidgets('Renders correct columns and rows',
        (WidgetTester tester) async {
      int editIndex = -1;
      int deleteIndex = -1;

      await tester.pumpWidget(createTestableTable(
        items: testItems,
        onEdit: (index) => editIndex = index,
        onDelete: (index) => deleteIndex = index,
      ));

      await tester.pumpAndSettle();

      // Verify component names are in the table
      expect(find.text('Test Component 1'), findsOneWidget);
      expect(find.text('Test Component 2'), findsOneWidget);

      // Verify formatted weight values
      expect(find.text('10.00'), findsOneWidget); // First component weight
      expect(find.text('15.00'), findsOneWidget); // Second component weight

      // Verify edit buttons work
      await tester.tap(find.byIcon(Icons.edit).first);
      expect(editIndex, 0);

      // Verify delete buttons work
      await tester.tap(find.byIcon(Icons.delete).last);
      expect(deleteIndex, 1);
    });

    testWidgets('Handles empty items list', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTable(
        items: [],
        onEdit: (_) {},
        onDelete: (_) {},
      ));

      await tester.pumpAndSettle();

      // No data rows are rendered
      expect(find.byType(DataRow), findsNothing);

      // No edit/delete buttons
      expect(find.byIcon(Icons.edit), findsNothing);
      expect(find.byIcon(Icons.delete), findsNothing);
    });

    testWidgets('Handles components without price',
        (WidgetTester tester) async {
      // Create test items without prices
      final itemsWithoutPrice = [
        RecipeComponent(
          component: TestCompostComponent(
            id: 'test3',
            displayName: 'Test No Price',
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
          ),
          amount: 10.0,
        ),
      ];

      await tester.pumpWidget(createTestableTable(
        items: itemsWithoutPrice,
        onEdit: (_) {},
        onDelete: (_) {},
      ));

      await tester.pumpAndSettle();

      // Verify component name is in the table
      expect(find.text('Test No Price'), findsOneWidget);
    });

    testWidgets('Calculates water content correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTable(
        items: testItems,
        onEdit: (_) {},
        onDelete: (_) {},
      ));

      await tester.pumpAndSettle();

      // For first component, water = amount - (dryMatter * amount) = 10 - (0.5 * 10) = 5.00
      expect(find.text('5.00'), findsAtLeastNWidgets(1));

      // For second component, water = 15 - (0.6 * 15) = 6.00
      expect(find.text('6.00'), findsAtLeastNWidgets(1));
    });

    testWidgets('Formats nutrient values correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableTable(
        items: testItems,
        onEdit: (_) {},
        onDelete: (_) {},
      ));

      await tester.pumpAndSettle();

      // Test nutrient values are correctly calculated and formatted
      // First component organic carbon: 0.3 * 10 = 3.00
      expect(find.text('3.00'), findsAtLeastNWidgets(1));

      // First component nitrogen: 0.1 * 10 = 1.00
      expect(find.text('1.00'), findsAtLeastNWidgets(1));
    });
  });
}
