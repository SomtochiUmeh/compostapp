import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/widgets/custom_text_field.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Helper function to create a testable text field
Widget createTestableTextField({
  required String labelText,
  required TextEditingController controller,
  TextInputType? keyboardType,
  List<TextInputFormatter>? inputFormatters,
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
        child: CustomTextField(
          labelText: labelText,
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
        ),
      ),
    ),
  );
}

void main() {
  const String testLabel = 'Test Label';

  group('CustomTextField Widget Tests', () {
    testWidgets('Renders correctly with basic properties',
        (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(createTestableTextField(
        labelText: testLabel,
        controller: controller,
      ));

      await tester.pumpAndSettle();

      // Verify label is shown
      expect(find.text(testLabel), findsOneWidget);

      // Verify TextField is rendered
      expect(find.byType(TextField), findsOneWidget);

      // Enter text
      await tester.enterText(find.byType(TextField), 'Test Input');

      // Verify controller has the text
      expect(controller.text, 'Test Input');
    });

    testWidgets('Sets keyboardType correctly', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(createTestableTextField(
        labelText: testLabel,
        controller: controller,
        keyboardType: TextInputType.number,
      ));

      await tester.pumpAndSettle();

      // Find the TextField
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);

      // Check keyboard type
      final TextField textField = tester.widget(textFieldFinder);
      expect(textField.keyboardType, TextInputType.number);
    });

    testWidgets('Applies input formatters', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(createTestableTextField(
        labelText: testLabel,
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
      ));

      await tester.pumpAndSettle();

      // Find the TextField
      final textFieldFinder = find.byType(TextField);

      // Try entering non-numeric text
      await tester.enterText(textFieldFinder, 'abc123');

      // Verify only digits were allowed
      expect(controller.text, '123');
    });

    testWidgets('Uses text keyboard by default', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(createTestableTextField(
        labelText: testLabel,
        controller: controller,
      ));

      await tester.pumpAndSettle();

      // Find the TextField
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);

      // Check default keyboard type
      final TextField textField = tester.widget(textFieldFinder);
      expect(textField.keyboardType, TextInputType.text);
    });

    testWidgets('Has proper decoration', (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(createTestableTextField(
        labelText: testLabel,
        controller: controller,
      ));

      await tester.pumpAndSettle();

      // Find the TextField
      final textFieldFinder = find.byType(TextField);
      final textField = tester.widget<TextField>(textFieldFinder);

      // Verify it has proper decoration
      expect(textField.decoration?.labelText, testLabel);
      expect(textField.decoration?.border, isA<OutlineInputBorder>());
    });

    testWidgets('Handles complex input formatters',
        (WidgetTester tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(createTestableTextField(
        labelText: testLabel,
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
      ));

      await tester.pumpAndSettle();

      // Find the TextField
      final textFieldFinder = find.byType(TextField);

      // Try entering decimals
      await tester.enterText(textFieldFinder, '123.45');
      expect(controller.text, '123.45');

      // Try entering too many decimal places
      await tester.enterText(textFieldFinder, '123.456');
      expect(controller.text, '123.45');

      // Try entering non-numeric text
      await tester.enterText(textFieldFinder, 'abc');
      expect(controller.text, '');
    });
  });
}
