import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
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

// Generate mocks for the dependencies
@GenerateMocks([PersistenceManager, CompostState])
import 'recipe_builder_page_test.mocks.dart';

// Create a test-friendly CompostComponent class
class TestCompostComponent extends CompostComponent {
  TestCompostComponent({
    required super.id,
    required super.name,
    required super.availability,
    required super.nutrients,
    super.price,
    super.sources,
  });

  @override
  String getName() => name; // Override to avoid localization issues
}

void main() {
  late MockPersistenceManager mockPersistenceManager;
  late MockCompostState mockCompostState;
  late List<CompostComponent> testComponents;
  late Recipe testRecipe;

  setUp(() {
    mockPersistenceManager = MockPersistenceManager();
    mockCompostState = MockCompostState();

    // Initialize test components
    testComponents = [
      TestCompostComponent(
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
      TestCompostComponent(
        id: 'test2',
        name: 'Test Component 2',
        availability: AvailabilityPeriod.marToAug,
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

    // Create a test recipe with components
    testRecipe = Recipe(
      components: [
        RecipeComponent(
          component: testComponents[0],
          amount: 10.0,
        ),
        RecipeComponent(
          component: testComponents[1],
          amount: 5.0,
        ),
      ],
    );

    // Set up mock behaviors
    when(mockCompostState.components).thenReturn(testComponents);
    when(mockCompostState.selectedCurrency).thenReturn('CFA');
    when(mockCompostState.getAvailableComponents(any))
        .thenReturn(testComponents);

    // Setup responses for PersistenceManager
    when(mockPersistenceManager.getLatestRecipe())
        .thenAnswer((_) => Future.value(testRecipe));
    when(mockPersistenceManager.saveRecipe(any))
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
      expect(find.text('Test Component 1'), findsOneWidget);

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
      expect(find.text('Test Component 1'), findsOneWidget);
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

    testWidgets('Shows SnackBar when no available components are left',
        (WidgetTester tester) async {
      // Create a recipe that already contains all available components
      final allComponentsRecipe = Recipe(
        components: testComponents
            .map((comp) => RecipeComponent(component: comp, amount: 10.0))
            .toList(),
      );

      // Set up the mock to return this recipe
      when(mockPersistenceManager.getLatestRecipe())
          .thenAnswer((_) => Future.value(allComponentsRecipe));

      // Build the widget
      await tester.pumpWidget(createTestableRecipeBuilderPage());
      await tester.pumpAndSettle();

      // Find and tap the "Add Ingredient" button
      await tester.tap(find.text('Add Ingredient'));
      await tester.pumpAndSettle();

      // Verify that a SnackBar is shown
      expect(find.byType(SnackBar), findsOneWidget);

      // Verify that the correct message is shown
      expect(find.text('All available components have been added'),
          findsOneWidget);

      // Verify that the AddComponentDialog is NOT shown
      expect(find.byType(AddComponentDialog), findsNothing);
    });
  });

  group('RecipeBuilderPage Edit and Delete Tests', () {
    testWidgets('Tapping edit button shows edit dialog with correct values',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableRecipeBuilderPage());
      await tester.pumpAndSettle();

      // Verify recipe is loaded and components are displayed
      expect(find.byType(ComponentTable), findsOneWidget);

      // Find and tap the first edit button
      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();

      // Verify edit dialog appears with correct values
      expect(find.byType(AddComponentDialog), findsOneWidget);
      expect(find.text('Edit Component'), findsOneWidget);

      // The first component's weight should be pre-filled
      expect(find.text('10.0'), findsOneWidget);

      // There should be an update button
      expect(find.text('Update'), findsOneWidget);
    });

    testWidgets('Editing a component updates the recipe and persists changes',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableRecipeBuilderPage());
      await tester.pumpAndSettle();

      // Find and tap the first edit button
      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();

      // Change the weight value
      await tester.enterText(find.byType(TextField), '20.0');
      await tester.pumpAndSettle();

      // Tap the update button
      await tester.tap(find.text('Update'));
      await tester.pumpAndSettle();

      // Verify saveRecipe was called (indicating changes were saved)
      verify(mockPersistenceManager.saveRecipe(any)).called(greaterThan(0));
    });

    testWidgets(
        'Deleting a component removes it from the recipe and persists changes',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableRecipeBuilderPage());
      await tester.pumpAndSettle();

      // Find and tap the first delete button
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pumpAndSettle();

      // Verify saveRecipe was called (indicating changes were saved)
      verify(mockPersistenceManager.saveRecipe(any)).called(greaterThan(0));
    });

    testWidgets('EditComponent function works with custom component values',
        (WidgetTester tester) async {
      // Start with a custom recipe with just one component for simplicity
      when(mockPersistenceManager.getLatestRecipe())
          .thenAnswer((_) => Future.value(Recipe(
                components: [
                  RecipeComponent(
                    component: testComponents[0],
                    amount: 10.0,
                  ),
                ],
              )));

      await tester.pumpWidget(createTestableRecipeBuilderPage());
      await tester.pumpAndSettle();

      // Find and tap the edit button
      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();

      // Change the weight to a new value
      await tester.enterText(find.byType(TextField), '30.0');
      await tester.pumpAndSettle();

      // Tap the update button
      await tester.tap(find.text('Update'));
      await tester.pumpAndSettle();

      // Verify saveRecipe was called with the updated component
      // We need to capture the actual Recipe that was passed to saveRecipe
      final recipeCaptor =
          verify(mockPersistenceManager.saveRecipe(captureAny)).captured;

      // Ensure at least one Recipe was captured
      expect(recipeCaptor, isNotEmpty);

      // Get the first captured Recipe
      final capturedRecipe = recipeCaptor.first as Recipe;

      // Verify it has the updated amount
      expect(capturedRecipe.components.length, 1);
      expect(capturedRecipe.components[0].amount, 30.0);
    });

    testWidgets('DeleteComponent function removes the correct component',
        (WidgetTester tester) async {
      // Start with a recipe with two components so we can delete one
      when(mockPersistenceManager.getLatestRecipe())
          .thenAnswer((_) => Future.value(Recipe(
                components: [
                  RecipeComponent(
                    component: testComponents[0],
                    amount: 10.0,
                  ),
                  RecipeComponent(
                    component: testComponents[1],
                    amount: 5.0,
                  ),
                ],
              )));

      await tester.pumpWidget(createTestableRecipeBuilderPage());
      await tester.pumpAndSettle();

      // Store the component name of the first component before deletion
      final firstComponentName = testComponents[0].getName();

      // Find and tap the delete button for the first component
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pumpAndSettle();

      // Verify saveRecipe was called with a recipe that doesn't contain the deleted component
      final recipeCaptor =
          verify(mockPersistenceManager.saveRecipe(captureAny)).captured;

      expect(recipeCaptor, isNotEmpty);

      final capturedRecipe = recipeCaptor.last as Recipe;

      // The recipe should now have only one component
      expect(capturedRecipe.components.length, 1);

      // And that component should NOT be the one we deleted
      expect(
          capturedRecipe.components[0].component.getName() !=
              firstComponentName,
          isTrue);
    });
  });
}
