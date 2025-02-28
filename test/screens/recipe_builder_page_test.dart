import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:compostapp/screens/recipe_builder_page.dart';
import 'package:compostapp/widgets/component_table.dart';
import 'package:compostapp/widgets/add_component_dialog.dart';
import 'package:compostapp/widgets/nutrient_totals_table.dart';
import 'package:compostapp/compost_state.dart';
import 'package:compostapp/services/persistence_manager.dart';
import 'package:compostapp/models/compost_component_model.dart';
import 'package:compostapp/models/recipe_component_model.dart';
import 'package:compostapp/models/recipe_model.dart';
import 'package:compostapp/models/availability_model.dart';
import 'package:compostapp/models/nutrient_content_model.dart';
import 'package:compostapp/models/price_model.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Generate mocks for the classes we need
@GenerateMocks([PersistenceManager, CompostState])
import 'recipe_builder_page_test.mocks.dart';

void main() {
  late MockPersistenceManager mockPersistenceManager;
  late MockCompostState mockCompostState;
  late List<CompostComponent> testComponents;

  setUp(() {
    mockPersistenceManager = MockPersistenceManager();
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
    ];

    // Set up mock behaviors that might be called
    when(mockCompostState.components).thenReturn(testComponents);
    when(mockCompostState.getAvailableComponents(any))
        .thenReturn(testComponents);
    when(mockCompostState.updateComponent(any)).thenReturn(null);
    when(mockCompostState.updateComponentPrice(any, any)).thenReturn(null);
    when(mockCompostState.updateComponentAvailability(any, any))
        .thenReturn(null);

    // Stub all PersistenceManager methods
    when(mockPersistenceManager.getLatestRecipe())
        .thenAnswer((_) => Future.value(null));
    when(mockPersistenceManager.saveRecipe(any))
        .thenAnswer((_) => Future.value(true));
    when(mockPersistenceManager.getSavedComponents())
        .thenAnswer((_) => Future.value([]));
    when(mockPersistenceManager.updateComponentInfo(any))
        .thenAnswer((_) => Future.value(true));
    when(mockPersistenceManager.getRecipeHistory())
        .thenAnswer((_) => Future.value([]));
    when(mockPersistenceManager.clearCurrentRecipe())
        .thenAnswer((_) => Future.value(true));
    when(mockPersistenceManager.clearRecipeHistory())
        .thenAnswer((_) => Future.value(true));
    when(mockPersistenceManager.clearComponentData())
        .thenAnswer((_) => Future.value(true));
    when(mockPersistenceManager.clearAll())
        .thenAnswer((_) => Future.value(true));
  });

  // Helper function to create a testable RecipeBuilderPage widget
  Widget createTestableRecipeBuilderPage() {
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
        home: RecipeBuilderPage(
          persistenceManager: mockPersistenceManager,
        ),
      ),
    );
  }

  group('RecipeBuilderPage Widget Tests', () {
    testWidgets('RecipeBuilderPage renders empty state correctly',
        (WidgetTester tester) async {
      // Set up for empty state
      when(mockPersistenceManager.getLatestRecipe())
          .thenAnswer((_) => Future.value(null));

      await tester.pumpWidget(createTestableRecipeBuilderPage());
      await tester.pumpAndSettle();

      // Verify empty state message - find it even if it's in a Text or RichText widget
      expect(find.byWidgetPredicate((widget) {
        if (widget is Text) {
          return widget.data?.contains('No components added yet') ?? false;
        } else if (widget is RichText) {
          return widget.text.toPlainText().contains('No components added yet');
        }
        return false;
      }), findsAtLeastNWidgets(1),
          reason: "Empty state message should be shown");

      // Verify add button
      expect(find.text('Add Ingredient'), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);

      // Verify that we attempted to load the latest recipe
      verify(mockPersistenceManager.getLatestRecipe()).called(1);
    });

    testWidgets('Loads saved recipe on init', (WidgetTester tester) async {
      // Create a recipe with one component
      final savedRecipe = Recipe(
        components: [
          RecipeComponent(
            component: testComponents[0],
            amount: 10.0,
          ),
        ],
      );
      when(mockPersistenceManager.getLatestRecipe())
          .thenAnswer((_) => Future.value(savedRecipe));

      await tester.pumpWidget(createTestableRecipeBuilderPage());
      await tester.pumpAndSettle();

      // Verify component table is shown
      expect(find.byType(ComponentTable), findsOneWidget);
      expect(find.text('Unknown component'), findsOneWidget);

      // Verify 'Nutrient Analysis' is shown
      expect(find.byWidgetPredicate((widget) {
        if (widget is Text) {
          return widget.data?.contains('Nutrient Analysis') ?? false;
        } else if (widget is RichText) {
          return widget.text.toPlainText().contains('Nutrient Analysis');
        }
        return false;
      }), findsAtLeastNWidgets(1));
      expect(find.byType(NutrientTotalsTable), findsOneWidget);

      // Verify that we attempted to load the latest recipe
      verify(mockPersistenceManager.getLatestRecipe()).called(1);
    });

    testWidgets('Add component dialog appears on button tap',
        (WidgetTester tester) async {
      when(mockPersistenceManager.getLatestRecipe())
          .thenAnswer((_) => Future.value(null));

      await tester.pumpWidget(createTestableRecipeBuilderPage());
      await tester.pumpAndSettle();

      // Tap add button
      await tester.tap(find.text('Add Ingredient'));
      await tester.pumpAndSettle();

      // Verify dialog appears
      expect(find.byType(AddComponentDialog), findsOneWidget);
      expect(find.text('Add Component'), findsOneWidget);
      expect(find.text('Choose Component'), findsOneWidget);
      expect(find.text('Weight (kg)'), findsOneWidget);
    });

    testWidgets('Can add a component to the recipe',
        (WidgetTester tester) async {
      when(mockPersistenceManager.getLatestRecipe())
          .thenAnswer((_) => Future.value(null));

      await tester.pumpWidget(createTestableRecipeBuilderPage());
      await tester.pumpAndSettle();

      // Tap add button
      await tester.tap(find.text('Add Ingredient'));
      await tester.pumpAndSettle();

      // Select component from dropdown
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DropdownMenuItem<String>).first);
      await tester.pumpAndSettle();

      // Enter weight
      await tester.enterText(find.byType(TextField), '10');
      await tester.pumpAndSettle();

      // Tap add button in dialog
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      // Verify recipe is saved
      verify(mockPersistenceManager.saveRecipe(any)).called(1);

      // Verify component table shows the component
      expect(find.byType(ComponentTable), findsOneWidget);
      expect(find.text('Unknown component'), findsOneWidget);
    });

    testWidgets('Shows info dialog when info button is tapped',
        (WidgetTester tester) async {
      // Create a recipe with one component
      final savedRecipe = Recipe(
        components: [
          RecipeComponent(
            component: testComponents[0],
            amount: 10.0,
          ),
        ],
      );
      when(mockPersistenceManager.getLatestRecipe())
          .thenAnswer((_) => Future.value(savedRecipe));

      await tester.pumpWidget(createTestableRecipeBuilderPage());
      await tester.pumpAndSettle();

      // Find and tap info button
      await tester.tap(find.byIcon(Icons.info_outline));
      await tester.pumpAndSettle();

      // Verify info dialog appears
      expect(find.text('Recipe Quality Guide'), findsOneWidget);
      expect(find.text('Close'), findsOneWidget);
    });
  });
}
