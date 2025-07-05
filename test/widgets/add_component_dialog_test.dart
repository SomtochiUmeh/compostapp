import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/widgets/add_component_dialog.dart';
import 'package:compostapp/models/compost_component_model.dart';
import 'package:compostapp/models/nutrient_content_model.dart';
import 'package:compostapp/models/price_model.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Helper function to create a testable dialog wrapped with necessary providers
Widget createTestableDialog({
  required List<CompostComponent> availableComponents,
  required Function(CompostComponent, double) onAdd,
  double? initialWeight,
}) {
  return MaterialApp(
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
            // Add Scaffold for SnackBar display
            body: AddComponentDialog(
              availableComponents: availableComponents,
              onAdd: onAdd,
              initialWeight: initialWeight,
            ),
          );
        },
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
  // Sample test data
  late List<CompostComponent> testComponents;

  setUp(() {
    testComponents = [
      TestCompostComponent(
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
      TestCompostComponent(
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
    ];
  });

  group('AddComponentDialog Widget Tests', () {
    testWidgets('Dialog renders correctly in add mode',
        (WidgetTester tester) async {
      bool addCalled = false;

      await tester.pumpWidget(createTestableDialog(
        availableComponents: testComponents,
        onAdd: (_, __) => addCalled = true,
      ));

      await tester.pumpAndSettle();

      // Verify dialog title and elements
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Add Component'), findsOneWidget);
      expect(find.text('Choose Component'), findsOneWidget);
      expect(find.text('Weight (kg)'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
      expect(find.text('Update'), findsNothing);
      expect(addCalled, false);
    });

    testWidgets('Dialog renders correctly in edit mode',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableDialog(
        availableComponents: testComponents,
        onAdd: (_, __) {},
        initialWeight: 5.0,
      ));

      await tester.pumpAndSettle();

      // Verify dialog title shows "Edit Component" in edit mode
      expect(find.text('Edit Component'), findsOneWidget);

      // Verify weight field is pre-filled
      expect(find.text('5.0'), findsOneWidget);

      // Verify we have Update button instead of Add
      expect(find.text('Update'), findsOneWidget);
      expect(find.text('Add'), findsNothing);
    });

    testWidgets('Cancel button closes dialog without calling onAdd',
        (WidgetTester tester) async {
      bool addCalled = false;

      await tester.pumpWidget(createTestableDialog(
        availableComponents: testComponents,
        onAdd: (_, __) => addCalled = true,
      ));

      await tester.pumpAndSettle();

      // Tap the cancel button
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(addCalled, false);
    });

    testWidgets('Add button calls onAdd with correct values when form is valid',
        (WidgetTester tester) async {
      CompostComponent? addedComponent;
      double? addedWeight;

      await tester.pumpWidget(createTestableDialog(
        availableComponents: [testComponents.first],
        onAdd: (component, weight) {
          addedComponent = component;
          addedWeight = weight;
        },
      ));

      await tester.pumpAndSettle();

      // First, select the component from the dropdown
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Select the component (it's the only one in the list)
      await tester.tap(find.text('Test Component 1').last);
      await tester.pumpAndSettle();

      // Enter weight
      await tester.enterText(find.byType(TextField), '10.5');
      await tester.pumpAndSettle();

      // Tap add button
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      expect(addedComponent, testComponents.first);
      expect(addedWeight, 10.5);
    });

    testWidgets('Shows error message when trying to add with invalid weight',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableDialog(
        availableComponents: [testComponents.first],
        onAdd: (_, __) {},
      ));

      await tester.pumpAndSettle();

      // Enter invalid weight (zero)
      await tester.enterText(find.byType(TextField), '0');
      await tester.pumpAndSettle();

      // Tap add button
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Verify error snackbar is shown
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets(
        'Shows error message when trying to add without entering weight',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableDialog(
        availableComponents: [testComponents.first],
        onAdd: (_, __) {},
      ));

      await tester.pumpAndSettle();

      // Tap add button without entering weight
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Verify error snackbar is shown
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Please fill all fields'), findsOneWidget);
    });

    testWidgets('Dropdown shows all available components',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableDialog(
        availableComponents: testComponents,
        onAdd: (_, __) {},
      ));

      await tester.pumpAndSettle();

      // Open the dropdown
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Verify all components are shown in the dropdown
      expect(find.text('Test Component 1'), findsOneWidget);
      expect(find.text('Test Component 2'), findsOneWidget);

      // Select a component
      await tester.tap(find.text('Test Component 2').last);
      await tester.pumpAndSettle();
    });
  });
}
