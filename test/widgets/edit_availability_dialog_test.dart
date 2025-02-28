import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/widgets/edit_availability_dialog.dart';
import 'package:compostapp/models/availability_model.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Helper function to create a testable dialog
Widget createTestableDialog({
  required String componentId,
  required String componentName,
  required AvailabilityPeriod currentAvailability,
  required Function(AvailabilityPeriod) onSave,
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
            body: EditAvailabilityDialog(
              componentId: componentId,
              componentName: componentName,
              currentAvailability: currentAvailability,
              onSave: onSave,
            ),
          );
        },
      ),
    ),
  );
}

void main() {
  group('EditAvailabilityDialog Widget Tests', () {
    testWidgets('Dialog renders correctly with initial values',
        (WidgetTester tester) async {
      // ignore: unused_local_variable
      AvailabilityPeriod? savedAvailability;

      await tester.pumpWidget(createTestableDialog(
        componentId: 'test-id',
        componentName: 'Test Component',
        currentAvailability: AvailabilityPeriod.marToAug,
        onSave: (availability) {
          savedAvailability = availability;
        },
      ));

      await tester.pumpAndSettle();

      // Verify dropdowns are present
      expect(find.byType(DropdownButtonFormField<int>), findsNWidgets(2));

      // Verify buttons
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('Allows changing months and saving',
        (WidgetTester tester) async {
      AvailabilityPeriod? savedAvailability;

      await tester.pumpWidget(createTestableDialog(
        componentId: 'test-id',
        componentName: 'Test Component',
        currentAvailability: AvailabilityPeriod.marToAug,
        onSave: (availability) {
          savedAvailability = availability;
        },
      ));

      await tester.pumpAndSettle();

      // Find start month dropdown
      final startMonthDropdown =
          find.byType(DropdownButtonFormField<int>).first;

      // Tap to open dropdown
      await tester.tap(startMonthDropdown);
      await tester.pumpAndSettle();

      // Select January (value 1)
      await tester.tap(find.text('January'));
      await tester.pumpAndSettle();

      // Find end month dropdown
      final endMonthDropdown = find.byType(DropdownButtonFormField<int>).last;

      // Tap to open dropdown
      await tester.tap(endMonthDropdown);
      await tester.pumpAndSettle();

      // Select December (value 12)
      await tester.tap(find.text('December'));
      await tester.pumpAndSettle();

      // Tap Save button
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify the callback was called with correct values
      // Should return the predefined janToDec period
      expect(savedAvailability, AvailabilityPeriod.janToDec);
    });

    testWidgets('Creates custom period if needed', (WidgetTester tester) async {
      AvailabilityPeriod? savedAvailability;

      await tester.pumpWidget(createTestableDialog(
        componentId: 'test-id',
        componentName: 'Test Component',
        currentAvailability: AvailabilityPeriod.marToAug,
        onSave: (availability) {
          savedAvailability = availability;
        },
      ));

      await tester.pumpAndSettle();

      // Find start month dropdown
      final startMonthDropdown =
          find.byType(DropdownButtonFormField<int>).first;

      // Tap to open dropdown
      await tester.tap(startMonthDropdown);
      await tester.pumpAndSettle();

      // Select February (value 2)
      await tester.tap(find.text('February'));
      await tester.pumpAndSettle();

      // Find end month dropdown
      final endMonthDropdown = find.byType(DropdownButtonFormField<int>).last;

      // Tap to open dropdown
      await tester.tap(endMonthDropdown);
      await tester.pumpAndSettle();

      // Select April (value 4)
      await tester.tap(find.text('April'));
      await tester.pumpAndSettle();

      // Tap Save button
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      // Verify a custom period was created
      expect(savedAvailability?.startMonth, 2); // February
      expect(savedAvailability?.endMonth, 4); // April
      expect(savedAvailability?.name, startsWith('custom_'));
    });

    testWidgets('Cancel button dismisses dialog', (WidgetTester tester) async {
      bool onSaveCalled = false;

      // Create a widget that has a Navigator
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: Builder(
          builder: (context) {
            return ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => EditAvailabilityDialog(
                    componentId: 'test-id',
                    componentName: 'Test Component',
                    currentAvailability: AvailabilityPeriod.marToAug,
                    onSave: (_) {
                      onSaveCalled = true;
                    },
                  ),
                );
              },
              child: const Text('Show Dialog'),
            );
          },
        ),
      ));

      await tester.pumpAndSettle();

      // Tap the button to show the dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Verify dialog is shown
      expect(find.byType(EditAvailabilityDialog), findsOneWidget);

      // Tap the Cancel button
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Verify dialog is dismissed
      expect(find.byType(EditAvailabilityDialog), findsNothing);

      // Verify callback wasn't called
      expect(onSaveCalled, false);
    });
  });
}
