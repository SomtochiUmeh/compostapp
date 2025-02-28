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
@GenerateMocks([PersistenceManager])
import 'main_test.mocks.dart';

void main() {
  late MockPersistenceManager mockPersistenceManager;

  setUp(() {
    mockPersistenceManager = MockPersistenceManager();

    // Mock the necessary methods of PersistenceManager
    when(mockPersistenceManager.getSavedComponents())
        .thenAnswer((_) => Future.value([]));
  });

  testWidgets('CompostCalculatorApp initializes with correct structure',
      (WidgetTester tester) async {
    // Create a CompostCalculatorApp with the mock persistence manager
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CompostState>(
            create: (context) => CompostState(mockPersistenceManager),
          ),
          Provider<PersistenceManager>.value(value: mockPersistenceManager),
        ],
        child: const CompostCalculatorApp(),
      ),
    );

    // Allow widget to build
    await tester.pumpAndSettle();

    // Verify MaterialApp is correctly configured
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(materialApp.title, 'Compost Calculator');

    // Verify localization is set up
    expect(materialApp.localizationsDelegates, isNotNull);
    expect(materialApp.localizationsDelegates!.length,
        equals(4)); // Should have 4 delegates

    // Verify supported locales
    expect(materialApp.supportedLocales, isNotNull);
    expect(materialApp.supportedLocales.isNotEmpty, isTrue);

    // Verify theme
    expect(materialApp.theme, isNotNull);
    expect(materialApp.theme!.useMaterial3, isTrue);
    expect(materialApp.theme!.colorScheme, isNotNull);

    // Verify home page
    expect(materialApp.home.runtimeType, AppHomePage);
  });

  testWidgets('Providers are correctly instantiated',
      (WidgetTester tester) async {
    // Create a test widget that consumes the providers
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CompostState>(
            create: (context) => CompostState(mockPersistenceManager),
          ),
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
          home: Builder(
            builder: (context) {
              // Access the providers - use try-catch to handle potential exceptions
              CompostState? compostState;
              PersistenceManager? persistenceManager;

              try {
                compostState =
                    Provider.of<CompostState>(context, listen: false);
              } catch (e) {
                debugPrint('Error accessing CompostState: $e');
              }

              try {
                persistenceManager =
                    Provider.of<PersistenceManager>(context, listen: false);
              } catch (e) {
                debugPrint('Error accessing PersistenceManager: $e');
              }

              // Return a widget that displays info about the providers
              return Column(
                children: [
                  Text(
                      'CompostState: ${compostState != null ? 'initialized' : 'null'}'),
                  Text(
                      'PersistenceManager: ${persistenceManager != null ? 'initialized' : 'null'}'),
                ],
              );
            },
          ),
        ),
      ),
    );

    // Verify providers are accessible
    expect(find.text('CompostState: initialized'), findsOneWidget);
    expect(find.text('PersistenceManager: initialized'), findsOneWidget);
  });

  // Note: We can't easily test main() directly as it calls static methods and creates
  // instances that are difficult to mock in Dart. Instead, we test the components
  // that main() uses and verify their behavior individually.

  testWidgets('ColorScheme is properly initialized from seed color',
      (WidgetTester tester) async {
    // Create a CompostCalculatorApp
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<CompostState>(
            create: (context) => CompostState(mockPersistenceManager),
          ),
          Provider<PersistenceManager>.value(value: mockPersistenceManager),
        ],
        child: const CompostCalculatorApp(),
      ),
    );

    // Allow widget to build
    await tester.pumpAndSettle();

    // Get the MaterialApp
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));

    // Verify that a color scheme is created and it uses a brown seed color
    final colorScheme = materialApp.theme!.colorScheme;

    // We can't directly check the seed color, but we can verify that
    // the primary color is in the brown family
    expect(colorScheme.primary, isNotNull);

    // Check that the primary color has more red than blue or green,
    // which is characteristic of brown
    final primaryColor = colorScheme.primary;
    expect(primaryColor.red > primaryColor.blue, isTrue);
    expect(primaryColor.red > primaryColor.green, isTrue);
  });
}
