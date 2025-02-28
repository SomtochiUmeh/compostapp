import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/widgets/custom_dropdown_field.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Helper function to create a testable dropdown field
Widget createTestableDropdown({
  required List<String> options,
  required String value,
  required Function(String) onChanged,
  required String labelText,
}) {
  return MaterialApp(
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomDropdownField(
          options: options,
          value: value,
          onChanged: onChanged,
          labelText: labelText,
        ),
      ),
    ),
  );
}

void main() {
  const List<String> testOptions = ['Option 1', 'Option 2', 'Option 3'];
  const String testLabel = 'Test Label';

  group('CustomDropdownField Widget Tests', () {
    testWidgets('Renders correctly with empty value',
        (WidgetTester tester) async {
      String? selectedValue;

      await tester.pumpWidget(createTestableDropdown(
        options: testOptions,
        value: '',
        onChanged: (value) => selectedValue = value,
        labelText: testLabel,
      ));

      await tester.pumpAndSettle();

      // Verify label is shown
      expect(find.text(testLabel), findsOneWidget);

      // Verify dropdown is rendered
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);

      // Tap to open dropdown
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Verify all options are shown
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);

      // Select an option
      await tester.tap(find.text('Option 2').last);
      await tester.pumpAndSettle();

      // Verify onChanged was called with correct value
      expect(selectedValue, 'Option 2');
    });

    testWidgets('Renders correctly with initial value',
        (WidgetTester tester) async {
      String selectedValue = 'Option 1';

      await tester.pumpWidget(createTestableDropdown(
        options: testOptions,
        value: selectedValue,
        onChanged: (value) => selectedValue = value,
        labelText: testLabel,
      ));

      await tester.pumpAndSettle();

      // Verify initial value is shown
      expect(find.text('Option 1'), findsOneWidget);

      // Tap to open dropdown
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();

      // Select a different option
      await tester.tap(find.text('Option 3').last);
      await tester.pumpAndSettle();

      // Verify onChanged was called with correct value
      expect(selectedValue, 'Option 3');
    });

    testWidgets('Handles empty options list gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableDropdown(
        options: [],
        value: '',
        onChanged: (_) {},
        labelText: testLabel,
      ));

      await tester.pumpAndSettle();

      // Verify label is shown
      expect(find.text(testLabel), findsOneWidget);

      // Verify dropdown is present
      final dropdownFinder = find.byType(DropdownButtonFormField<String>);
      expect(dropdownFinder, findsOneWidget);
    });

    testWidgets('Has proper decoration', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableDropdown(
        options: testOptions,
        value: 'Option 1',
        onChanged: (_) {},
        labelText: testLabel,
      ));

      await tester.pumpAndSettle();

      // Find the DropdownButtonFormField
      final dropdownFinder = find.byType(DropdownButtonFormField<String>);
      final dropdown =
          tester.widget<DropdownButtonFormField<String>>(dropdownFinder);

      // Verify it has proper decoration
      expect(dropdown.decoration.labelText, testLabel);
      expect(dropdown.decoration.border, isA<OutlineInputBorder>());
    });
  });
}
