import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/screens/app_home_page.dart';
import 'package:compostapp/screens/compost_guidelines_page.dart';
import 'package:compostapp/screens/sample_recipes_page.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Helper function to create a testable AppHomePage widget
Widget createTestableAppHomePage() {
  return MaterialApp(
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: const AppHomePage(),
  );
}

// Helper to find widgets by type and print their runtimeType
void debugPrintWidgetTypes(WidgetTester tester) {
  debugPrint("=== All scrollable widgets in tree: ===");
  for (var widget in tester.allWidgets) {
    if (widget is ScrollView ||
        widget is SingleChildScrollView ||
        widget is GridView ||
        widget is PageView) {
      debugPrint("Scrollable widget: ${widget.runtimeType}");
    }
  }

  debugPrint("=== All interactive widgets in tree: ===");
  for (var widget in tester.allWidgets) {
    if (widget is InkWell ||
        widget is GestureDetector ||
        widget is ElevatedButton ||
        widget is Card) {
      debugPrint("Interactive widget: ${widget.runtimeType}");
    }
  }
}

void main() {
  group('AppHomePage Widget Tests', () {
    testWidgets('AppHomePage renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableAppHomePage());
      await tester.pumpAndSettle();

      // Verify app bar
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Compost Calculator'), findsOneWidget);

      // Verify welcome card
      expect(find.text('Welcome to Compost Calculator'), findsOneWidget);

      // Verify navigation buttons - using findRichText helper for possible RichText widgets
      expect(find.text('Compost Guidelines'), findsOneWidget);

      // If Sample Compost Recipes button is not immediately visible, scroll to it
      if (find.text('Sample Compost Recipes').evaluate().isEmpty) {
        await tester.dragUntilVisible(
          find
              .byType(Card, skipOffstage: false)
              .last, // Target something we know is near the button
          find.byType(ListView), // The scrollable container
          const Offset(0, -100), // Scroll up direction
        );
        await tester.pumpAndSettle();
      }
      expect(find.text('Sample Compost Recipes'), findsOneWidget);

      // If Recipe Builder button is not immediately visible, scroll to it
      if (find.text('Recipe Builder').evaluate().isEmpty) {
        await tester.dragUntilVisible(
          find
              .byType(Card, skipOffstage: false)
              .last, // Target last card to scroll to bottom
          find.byType(ListView), // The scrollable container
          const Offset(0, -200), // Scroll up direction
        );
        await tester.pumpAndSettle();
      }
      expect(find.text('Recipe Builder'), findsOneWidget);
    });

    testWidgets('Navigation to CompostGuidelinesPage works',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableAppHomePage());
      await tester.pumpAndSettle();

      // Tap on the Compost Guidelines button
      await tester.tap(find.text('Compost Guidelines'));
      await tester.pumpAndSettle();

      // Verify navigation to CompostGuidelinesPage
      expect(find.byType(CompostGuidelinesPage), findsOneWidget);
    });

    testWidgets('Navigation to SampleRecipesPage works',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableAppHomePage());
      await tester.pumpAndSettle();

      // If Sample Compost Recipes button is not immediately visible, scroll to it
      if (find.text('Sample Compost Recipes').evaluate().isEmpty) {
        await tester.dragUntilVisible(
          find
              .byType(Card, skipOffstage: false)
              .last, // Target something we know is near the button
          find.byType(ListView), // The scrollable container
          const Offset(0, -100), // Scroll up direction
        );
        await tester.pumpAndSettle();
      }
      expect(find.text('Sample Compost Recipes'), findsOneWidget);

      // Tap on the Sample Compost Recipes button
      await tester.tap(find.text('Sample Compost Recipes'));
      await tester.pumpAndSettle();

      // Verify navigation to SampleRecipesPage
      expect(find.byType(SampleRecipesPage), findsOneWidget);
    });
  });
}
