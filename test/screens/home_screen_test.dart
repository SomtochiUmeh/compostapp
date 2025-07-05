import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:compostapp/screens/home_screen.dart';
import 'package:compostapp/screens/recipe_builder_page.dart';
import 'package:compostapp/screens/price_page.dart';
import 'package:compostapp/compost_state.dart';
import 'package:compostapp/services/persistence_manager.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Generate mocks for the classes we need
@GenerateMocks([PersistenceManager, CompostState])
import 'home_screen_test.mocks.dart';

void main() {
  late MockPersistenceManager mockPersistenceManager;
  late MockCompostState mockCompostState;

  setUp(() {
    mockPersistenceManager = MockPersistenceManager();
    mockCompostState = MockCompostState();

    // Setup default responses for all methods that will be called
    when(mockCompostState.components).thenReturn([]);
    when(mockCompostState.allComponents).thenReturn([]);

    // Stub all methods that might be called on PersistenceManager
    when(mockPersistenceManager.getSavedComponents())
        .thenAnswer((_) => Future.value([]));
    when(mockPersistenceManager.getLatestRecipe())
        .thenAnswer((_) => Future.value(null));
    when(mockPersistenceManager.saveRecipe(any))
        .thenAnswer((_) => Future.value(true));
    when(mockPersistenceManager.updateComponentInfo(any))
        .thenAnswer((_) => Future.value(true));

    // Add stubs for the CompostState methods that might be called
    when(mockCompostState.selectedCurrency).thenReturn('CFA');
    when(mockCompostState.updateComponent(any)).thenReturn(null);
    when(mockCompostState.updateComponentPrice(any, any)).thenReturn(null);
  });

  // Helper function to create a testable HomeScreen widget with mocks
  Widget createTestableHomeScreen() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CompostState>.value(value: mockCompostState),
        Provider<PersistenceManager>.value(value: mockPersistenceManager),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: const HomeScreen(),
      ),
    );
  }

  // Helper to find text in RichText widgets
  Finder findRichText(String text) {
    return find.byWidgetPredicate((widget) {
      if (widget is RichText) {
        final textSpan = widget.text;
        if (textSpan is TextSpan) {
          return textSpan.toPlainText().contains(text);
        }
      }
      return false;
    });
  }

  group('HomeScreen Widget Tests', () {
    testWidgets('HomeScreen renders with bottom navigation bar',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableHomeScreen());
      await tester.pumpAndSettle();

      // Verify app bar
      expect(find.byType(AppBar), findsOneWidget);

      // Check if title is directly in text or in RichText
      final titleFinder = find.text('Recipe Builder');
      final richTextTitleFinder = findRichText('Recipe Builder');

      expect(
          titleFinder.evaluate().isNotEmpty ||
              richTextTitleFinder.evaluate().isNotEmpty,
          isTrue,
          reason:
              "Title 'Recipe Builder' should be found either as Text or RichText");

      // Verify navigation bar
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byIcon(Icons.compost), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.attach_money), findsOneWidget);
    });

    testWidgets('HomeScreen initially shows RecipeBuilderPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableHomeScreen());
      await tester.pumpAndSettle();

      // RecipeBuilderPage should be visible
      expect(
          find.byType(RecipeBuilderPage, skipOffstage: false), findsOneWidget);
    });

    testWidgets('Navigation to PricePage works', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableHomeScreen());
      await tester.pumpAndSettle();

      // Find the price icon in the navigation bar and tap it
      final priceIcon = find.byIcon(Icons.attach_money);
      expect(priceIcon, findsOneWidget,
          reason: "Money icon should be visible in the navigation bar");

      await tester.tap(priceIcon);
      await tester.pumpAndSettle();

      // Verify app bar title changed - check both Text and RichText
      final pricesTitleFinder = find.text('Prices');
      final richTextPricesFinder = findRichText('Prices');

      expect(
          pricesTitleFinder.evaluate().isNotEmpty ||
              richTextPricesFinder.evaluate().isNotEmpty,
          isTrue,
          reason: "Title 'Prices' should be found either as Text or RichText");

      // PricePage should be visible
      expect(find.byType(PricesPage, skipOffstage: false), findsOneWidget);
    });

    testWidgets('Navigation back to RecipeBuilderPage works',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableHomeScreen());
      await tester.pumpAndSettle();

      // Navigate to PricePage
      final priceIcon = find.byIcon(Icons.attach_money);
      await tester.tap(priceIcon);
      await tester.pumpAndSettle();

      // Navigate back to RecipeBuilderPage
      final compostIcon = find.byIcon(Icons.compost);
      expect(compostIcon, findsOneWidget,
          reason: "Compost icon should be visible in the navigation bar");

      await tester.tap(compostIcon);
      await tester.pumpAndSettle();

      // Verify app bar title changed back - check both Text and RichText
      final titleFinder = find.text('Recipe Builder');
      final richTextTitleFinder = findRichText('Recipe Builder');

      expect(
          titleFinder.evaluate().isNotEmpty ||
              richTextTitleFinder.evaluate().isNotEmpty,
          isTrue,
          reason:
              "Title 'Recipe Builder' should be found either as Text or RichText");

      // RecipeBuilderPage should be visible
      expect(
          find.byType(RecipeBuilderPage, skipOffstage: false), findsOneWidget);
    });
  });
}

// Mock for NavigatorObserver to track navigation
class MockNavigatorObserver extends Mock implements NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {}
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {}
}
