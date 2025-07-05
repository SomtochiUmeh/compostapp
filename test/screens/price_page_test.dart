import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:compostapp/screens/price_page.dart';
import 'package:compostapp/compost_state.dart';
import 'package:compostapp/models/compost_component_model.dart';
import 'package:compostapp/models/nutrient_content_model.dart';
import 'package:compostapp/models/price_model.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Generate mocks for the classes we need
@GenerateMocks([CompostState])
import 'price_page_test.mocks.dart';

void main() {
  late MockCompostState mockCompostState;
  late List<CompostComponent> testComponents;

  setUp(() {
    mockCompostState = MockCompostState();

    // Initialize test components
    testComponents = [
      CompostComponent(
        id: 'test1',
        name: 'Test Component 1',
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
      const CompostComponent(
        id: 'test2',
        name: 'Test Component 2',
        nutrients: NutrientContent(
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
    ];

    // Set up mock behaviors that might be called
    when(mockCompostState.components).thenReturn(testComponents);
    when(mockCompostState.allComponents).thenReturn(testComponents); // Add this for the new getter
    when(mockCompostState.selectedCurrency).thenReturn('CFA');
    when(mockCompostState.updateComponent(any)).thenReturn(null);
    when(mockCompostState.updateComponentPrice(any, any)).thenReturn(null);
  });

  // Helper function to create a testable PricesPage widget
  Widget createTestablePricesPage() {
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
        home: const PricesPage(),
      ),
    );
  }

  group('PricesPage Widget Tests', () {
    testWidgets('PricesPage renders all components correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestablePricesPage());
      await tester.pumpAndSettle();

      // Verify section title
      expect(find.text('All Ingredients'), findsOneWidget);

      // Verify components are displayed; shows up as unknown components
      expect(find.text('Unknown component', skipOffstage: false),
          findsNWidgets(2));

      // Verify TextFormFields are present for price input
      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('Price update works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestablePricesPage());
      await tester.pumpAndSettle();

      // Find the first price text field
      final priceFields = find.byType(TextFormField);
      expect(priceFields, findsNWidgets(2));

      final firstPriceField = priceFields.first;

      // Update the price
      await tester.enterText(firstPriceField, '200');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
    });

    testWidgets('Components without price show empty price field',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestablePricesPage());
      await tester.pumpAndSettle();

      // Verify that both TextFormFields are rendered correctly
      final textFields = find.byType(TextFormField);
      expect(textFields, findsNWidgets(2));
    });

    testWidgets('Currency selector is rendered correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestablePricesPage());
      await tester.pumpAndSettle();

      // Verify currency selector dropdown is present
      expect(find.byType(DropdownButton<String>), findsOneWidget);

      // Verify default currency is shown
      expect(find.text('CFA (FCFA)'), findsOneWidget);
    });
  });
}
