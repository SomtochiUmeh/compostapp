import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/screens/sample_recipes_page.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Helper function to create a testable SampleRecipesPage widget
Widget createTestableSampleRecipesPage() {
  return MaterialApp(
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: const SampleRecipesPage(),
  );
}

void main() {
  group('SampleRecipesPage Widget Tests', () {
    testWidgets('SampleRecipesPage renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableSampleRecipesPage());
      await tester.pumpAndSettle();

      // Verify app bar
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Sample Compost Recipes'), findsOneWidget);

      // Verify recipe cards
      expect(find.text('Basic Garden Compost'), findsOneWidget);
      expect(find.text('Fast Hot Compost'), findsOneWidget);

      // Verify recipe descriptions
      expect(find.text('A simple, balanced recipe for general garden use.'),
          findsOneWidget);
      expect(find.text('For when you need compost quickly.'), findsOneWidget);

      // Verify section headers
      expect(find.text('Ingredients'), findsNWidgets(2)); // One for each recipe
      expect(
          find.text('Instructions'), findsNWidgets(2)); // One for each recipe
    });

    testWidgets('Basic Garden Compost recipe has correct ingredients',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableSampleRecipesPage());
      await tester.pumpAndSettle();

      // Find the Basic Garden Compost card
      expect(find.text('Basic Garden Compost'), findsOneWidget);

      // Verify ingredients
      expect(find.text('• 3 parts dry leaves'), findsOneWidget);
      expect(find.text('• 1 part fresh grass clippings'), findsOneWidget);
      expect(find.text('• 1 part vegetable scraps'), findsOneWidget);
    });

    testWidgets('Fast Hot Compost recipe has correct ingredients',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableSampleRecipesPage());
      await tester.pumpAndSettle();

      // Find the Fast Hot Compost card
      expect(find.text('Fast Hot Compost'), findsOneWidget);

      // Verify ingredients
      expect(
          find.text('• 2 parts chopped straw or wood chips'), findsOneWidget);
      expect(find.text('• 1 part chicken manure'), findsOneWidget);
      expect(find.text('• 1 part green garden waste (chopped small)'),
          findsOneWidget);
    });

    testWidgets('Basic Garden Compost recipe has correct instructions',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableSampleRecipesPage());
      await tester.pumpAndSettle();

      // Find the Basic Garden Compost card
      expect(find.text('Basic Garden Compost'), findsOneWidget);

      // Verify instructions
      expect(
          find.text(
              'Layer ingredients, moisten, and turn every 1-2 weeks. Ready in 3-6 months.'),
          findsOneWidget);
    });

    testWidgets('Fast Hot Compost recipe has correct instructions',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableSampleRecipesPage());
      await tester.pumpAndSettle();

      // Find the Fast Hot Compost card
      expect(find.text('Fast Hot Compost'), findsOneWidget);

      // Verify instructions
      expect(
          find.text(
              'Mix thoroughly, ensure adequate moisture, and turn every 3 days. Can be ready in 3-4 weeks if conditions are ideal.'),
          findsOneWidget);
    });

    testWidgets('Recipe cards have correct visual elements',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableSampleRecipesPage());
      await tester.pumpAndSettle();

      // Verify card widgets
      expect(find.byType(Card), findsNWidgets(2));

      // Check for proper styling and layout
      final basicCard = find.ancestor(
          of: find.text('Basic Garden Compost'), matching: find.byType(Card));
      final fastCard = find.ancestor(
          of: find.text('Fast Hot Compost'), matching: find.byType(Card));

      expect(basicCard, findsOneWidget);
      expect(fastCard, findsOneWidget);

      // Check for bullet points in ingredient lists
      expect(
          find.textContaining('•'),
          findsAtLeastNWidgets(
              6)); // At least 6 bullet points across both recipes
    });

    testWidgets('Recipe page scrolls correctly with multiple recipes',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableSampleRecipesPage());
      await tester.pumpAndSettle();

      // Find the ListView
      expect(find.byType(ListView), findsOneWidget);

      // Verify first recipe is visible
      expect(find.text('Basic Garden Compost'), findsOneWidget);

      // Scroll down to see second recipe
      await tester.dragFrom(
        tester.getCenter(find.byType(ListView)),
        const Offset(0, -300),
      );
      await tester.pumpAndSettle();

      // Verify second recipe is now visible
      expect(find.text('Fast Hot Compost'), findsOneWidget);
    });
  });
}
