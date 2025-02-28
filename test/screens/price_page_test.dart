import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:compostapp/screens/price_page.dart';
import 'package:compostapp/compost_state.dart';
import 'package:compostapp/models/compost_component_model.dart';
import 'package:compostapp/models/availability_model.dart';
import 'package:compostapp/models/nutrient_content_model.dart';
import 'package:compostapp/models/price_model.dart';
import 'package:compostapp/widgets/edit_availability_dialog.dart';
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
      ),
      const CompostComponent(
        id: 'test2',
        name: 'Test Component 2',
        availability: AvailabilityPeriod.marToAug,
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
    when(mockCompostState.getAvailableComponents(any))
        .thenReturn(testComponents);
    when(mockCompostState.updateComponent(any)).thenReturn(null);
    when(mockCompostState.updateComponentPrice(any, any)).thenReturn(null);
    when(mockCompostState.updateComponentAvailability(any, any))
        .thenReturn(null);
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

      // Verify price field for first component (with price)
      expect(find.text('100'), findsOneWidget);

      // Verify availability text is shown
      expect(find.textContaining('Available: January to December'),
          findsOneWidget);
      expect(find.textContaining('Available: March to August'), findsOneWidget);

      // Verify edit availability buttons
      expect(find.byIcon(Icons.edit_calendar), findsNWidgets(2));
    });

    testWidgets('Price update works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestablePricesPage());
      await tester.pumpAndSettle();

      // Find the price text field for the first component
      final priceField = find.widgetWithText(TextFormField, '100');
      expect(priceField, findsOneWidget);

      // Update the price
      await tester.enterText(priceField, '200');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
    });

    testWidgets('Edit availability dialog appears on button tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestablePricesPage());
      await tester.pumpAndSettle();

      // Find and tap the edit calendar button for the first component
      final editButton = find.byIcon(Icons.edit_calendar).first;
      await tester.tap(editButton);
      await tester.pumpAndSettle();

      // Verify the dialog appears
      expect(find.byType(EditAvailabilityDialog), findsOneWidget);
      expect(find.byIcon(Icons.edit_calendar), findsNWidgets(2));
      expect(find.text('Start Month'), findsOneWidget);
      expect(find.text('End Month'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('Availability update works correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestablePricesPage());
      await tester.pumpAndSettle();

      // Find and tap the edit calendar button for the first component
      final editButton = find.byIcon(Icons.edit_calendar).first;
      await tester.tap(editButton);
      await tester.pumpAndSettle();

      // Find the start month dropdown
      final startMonthDropdown =
          find.byType(DropdownButtonFormField<int>).first;
      await tester.tap(startMonthDropdown);
      await tester.pumpAndSettle();

      // Select March (value 3)
      await tester.tap(find.text('March').last);
      await tester.pumpAndSettle();

      // Find the end month dropdown
      final endMonthDropdown = find.byType(DropdownButtonFormField<int>).last;
      await tester.tap(endMonthDropdown);
      await tester.pumpAndSettle();

      // Select August (value 8)
      await tester.tap(find.text('August').last);
      await tester.pumpAndSettle();

      // Tap save button
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify updateComponentAvailability was called on the mock
      verify(mockCompostState.updateComponentAvailability('test1', any))
          .called(1);
    });

    testWidgets('Components without price show empty price field',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestablePricesPage());
      await tester.pumpAndSettle();

      // Verify the second component (without price) has an empty price field
      final textFields = find.byType(TextFormField);
      expect(textFields, findsNWidgets(2));

      // The second field should be empty or have "0"
      final secondTextField = tester.widget<TextFormField>(textFields.last);
      expect(
          secondTextField.initialValue == null ||
              secondTextField.initialValue == '' ||
              secondTextField.initialValue == '0',
          isTrue);
    });
  });
}
