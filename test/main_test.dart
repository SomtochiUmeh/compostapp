import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:compostapp/main.dart' show CompostCalculatorApp;
import 'package:compostapp/compost_state.dart';
import 'package:compostapp/services/persistence_manager.dart';
import 'package:compostapp/screens/app_home_page.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Generate mocks
@GenerateMocks([PersistenceManager, CompostState])
import 'main_test.mocks.dart';

void main() {
  late MockPersistenceManager mockPersistenceManager;
  late MockCompostState mockCompostState;

  setUp(() {
    mockPersistenceManager = MockPersistenceManager();
    mockCompostState = MockCompostState();

    // Setup default mock behavior
    when(mockPersistenceManager.getSavedComponents())
        .thenAnswer((_) => Future.value([]));
    when(mockCompostState.components).thenReturn([]);
    when(mockCompostState.getAvailableComponents(any)).thenReturn([]);
  });

  // Helper function to create the test app with the necessary providers and mocks
  Widget createTestApp({bool useInnerState = false}) {
    if (!useInnerState) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<CompostState>.value(value: mockCompostState),
          Provider<PersistenceManager>.value(value: mockPersistenceManager),
        ],
        child: const CompostCalculatorApp(),
      );
    } else {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<CompostState>.value(value: mockCompostState),
          Provider<PersistenceManager>.value(value: mockPersistenceManager),
        ],
        child: Builder(
          builder: (context) {
            return const CompostCalculatorApp();
          },
        ),
      );
    }
  }

  group('CompostCalculatorApp Tests', () {
    testWidgets('renders MaterialApp with correct theme',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.useMaterial3, true);

      // Verify the theme is using a brown-based color scheme
      final colorScheme = materialApp.theme!.colorScheme;
      expect(colorScheme, isNotNull);

      // Brown typically has red > green & blue
      final primaryColor = colorScheme.primary;
      expect(primaryColor.red > primaryColor.blue, isTrue);
      expect(primaryColor.red > primaryColor.green, isTrue);
    });

    testWidgets('configures correct localization delegates',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      final expectedDelegates = [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ];

      for (final delegate in expectedDelegates) {
        expect(materialApp.localizationsDelegates, contains(delegate));
      }
    });

    testWidgets('supports correct locales', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.supportedLocales, equals(S.delegate.supportedLocales));
      expect(materialApp.supportedLocales.isNotEmpty, isTrue);
    });

    testWidgets('sets AppHomePage as the home screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(AppHomePage), findsOneWidget);
    });

    testWidgets('provides all required providers', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final homeContext = tester.element(find.byType(AppHomePage));

      // Verify both providers are accessible
      expect(Provider.of<CompostState>(homeContext, listen: false), isNotNull);
      expect(Provider.of<PersistenceManager>(homeContext, listen: false),
          isNotNull);
    });

    testWidgets('providers are accessible throughout widget tree',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Get contexts at different levels of the widget tree
      final appHomePageContext = tester.element(find.byType(AppHomePage));

      // Find a child widget of AppHomePage (e.g., a Card or Text widget)
      final childWidgetContext = tester.element(find.byType(Card).first);

      // Verify providers are accessible at both levels
      expect(Provider.of<CompostState>(appHomePageContext, listen: false),
          isNotNull);
      expect(Provider.of<PersistenceManager>(appHomePageContext, listen: false),
          isNotNull);

      expect(Provider.of<CompostState>(childWidgetContext, listen: false),
          isNotNull);
      expect(Provider.of<PersistenceManager>(childWidgetContext, listen: false),
          isNotNull);
    });
  });

  group('CompostCalculatorApp Theme Tests', () {
    testWidgets('theme uses Material 3', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme?.useMaterial3, isTrue);
    });

    testWidgets('theme provides consistent colors to descendants',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final appContext = tester.element(find.byType(AppHomePage));
      final theme = Theme.of(appContext);

      // Test theme properties
      expect(theme.useMaterial3, isTrue);

      // Seed color should be brown, which means red > green & blue
      final primaryColor = theme.colorScheme.primary;
      expect(primaryColor.red > primaryColor.blue, isTrue);
      expect(primaryColor.red > primaryColor.green, isTrue);

      // Test consistency of colors throughout different theme properties
      expect(theme.colorScheme.primary, theme.primaryColor);
      expect(theme.colorScheme.surface, theme.scaffoldBackgroundColor);
    });
  });

  group('CompostCalculatorApp Structure Tests', () {
    testWidgets('MaterialApp is properly configured',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

      // Check basic MaterialApp configuration
      expect(materialApp.title, 'Compost Calculator');
      expect(materialApp.home, isA<AppHomePage>());
      expect(materialApp.localizationsDelegates, isNotNull);
      expect(materialApp.supportedLocales, isNotNull);
      expect(materialApp.theme, isNotNull);
    });

    testWidgets('Home screen is properly rendered',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Verify the AppHomePage is rendered with expected content
      expect(find.byType(AppHomePage), findsOneWidget);

      // Verify some key elements of the home page
      expect(find.text('Compost Calculator'), findsOneWidget); // App title

      // AppHomePage should have some basic UI elements
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.byType(Card), findsAtLeastNWidgets(1));
    });
  });

  // Note: We can't easily test main() directly as it calls static methods and creates
  // instances that are difficult to mock in Dart.
}
