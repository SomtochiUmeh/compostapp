import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:compostapp/compost_state.dart';
import 'package:compostapp/services/persistence_manager.dart';
import 'package:compostapp/models/compost_component_model.dart';
import 'package:compostapp/models/nutrient_content_model.dart';
import 'package:compostapp/models/price_model.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Generate mocks for the classes we need
@GenerateMocks([PersistenceManager])
import 'compost_state_test.mocks.dart';

// Create a test-friendly component class to avoid localization issues
class TestCompostComponent extends CompostComponent {
  TestCompostComponent({
    required super.id,
    required super.name,
    required super.nutrients,
    super.price,
    super.sources,
  });

  @override
  String getName() => name; // Directly return name without using S.current
}

// Wrapper to provide the necessary localization for tests
Widget createTestableWidget({required Widget child}) {
  return MaterialApp(
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: Material(child: child),
  );
}

void main() {
  late MockPersistenceManager mockPersistenceManager;
  late CompostState compostState;
  late List<CompostComponent> testComponents;

  // Initialize the widget binding for tests
  setUpAll(() {
    WidgetsFlutterBinding.ensureInitialized();
  });

  setUp(() {
    mockPersistenceManager = MockPersistenceManager();

    // Create test components using our test-friendly component class
    testComponents = [
      TestCompostComponent(
        id: 'test1',
        name: 'Test Component 1',
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

    // Set up mock response for getSavedComponents - default to null
    when(mockPersistenceManager.getSavedComponents())
        .thenAnswer((_) => Future.value(null));
    when(mockPersistenceManager.getSelectedCurrency())
        .thenAnswer((_) => Future.value(null));
    when(mockPersistenceManager.getCustomIngredients())
        .thenAnswer((_) => Future.value([]));
    when(mockPersistenceManager.saveCustomIngredients(any))
        .thenAnswer((_) => Future.value(true));

    // Initialize CompostState with the mock
    compostState = CompostState(mockPersistenceManager);
  });

  group('CompostState Tests', () {
    testWidgets('loads saved components on initialization',
        (WidgetTester tester) async {
      // Set up mock to return components
      when(mockPersistenceManager.getSavedComponents())
          .thenAnswer((_) => Future.value(testComponents));

      // Pump a widget to allow the async operations to complete
      await tester.pumpWidget(createTestableWidget(child: const SizedBox()));
      await tester.pump(const Duration(milliseconds: 50));

      // Verify getSavedComponents was called
      verify(mockPersistenceManager.getSavedComponents())
          .called(greaterThan(0));
    });

    test('loads default components when saved components is null', () async {
      // Mock the persistence manager to return null for saved components
      when(mockPersistenceManager.getSavedComponents())
          .thenAnswer((_) => Future.value(null));

      // Create a new CompostState to trigger initialization
      final newCompostState = CompostState(mockPersistenceManager);

      // Allow async operations to complete
      await Future.delayed(const Duration(milliseconds: 50));

      // Verify components list is not empty (should use default components)
      expect(newCompostState.components, isNotEmpty);
      verify(mockPersistenceManager.getSavedComponents())
          .called(greaterThan(0));
    });

    testWidgets(
        'updateComponent updates the correct component and persists changes',
        (WidgetTester tester) async {
      // Create a test widget to initialize localization
      await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

      // Set up initial components
      compostState.components = List.from(testComponents);

      // Create an updated component
      final updatedComponent = TestCompostComponent(
        id: 'test1',
        name: 'Test Component 1',
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
        price: Price(pricePerTon: 200), // Changed price
      );

      // Mock successful persistence
      when(mockPersistenceManager.updateComponentInfo(any))
          .thenAnswer((_) => Future.value(true));

      // Update the component
      compostState.updateComponent(updatedComponent);

      // Verify component was updated
      final updatedIndex = compostState.components.indexWhere(
          (comp) => comp.id == 'test1'); // Use ID instead of getName
      expect(updatedIndex, isNot(-1));
      expect(compostState.components[updatedIndex].price?.pricePerTon,
          equals(200));

      // Verify persistence was called
      verify(mockPersistenceManager.updateComponentInfo(any)).called(1);
    });

    testWidgets('updateComponent does nothing if component not found',
        (WidgetTester tester) async {
      // Create a test widget to initialize localization
      await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

      // Set up initial components
      compostState.components = List.from(testComponents);

      // Create a component that doesn't exist in the list
      final nonExistentComponent = TestCompostComponent(
        id: 'nonexistent',
        name: 'Non-existent Component',
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
      );

      // Update with non-existent component
      compostState.updateComponent(nonExistentComponent);

      // Verify persistence was not called
      verifyNever(mockPersistenceManager.updateComponentInfo(any));
    });

    testWidgets('updateComponentPrice updates price and persists changes',
        (WidgetTester tester) async {
      // Create a test widget to initialize localization
      await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

      // Set up initial components
      compostState.components = List.from(testComponents);

      // Mock successful persistence
      when(mockPersistenceManager.updateComponentInfo(any))
          .thenAnswer((_) => Future.value(true));

      // Update the price using component name
      compostState.updateComponentPrice('Test Component 1', 300);

      // Verify price was updated
      final updatedIndex = compostState.components.indexWhere((comp) =>
          comp.id ==
          'test1'); // Use ID instead of getName to avoid localization issues
      expect(updatedIndex, isNot(-1));
      expect(compostState.components[updatedIndex].price?.pricePerTon,
          equals(300));

      // Verify persistence was called
      verify(mockPersistenceManager.updateComponentInfo(any)).called(1);
    });

    testWidgets('updateComponentPrice does nothing if component not found',
        (WidgetTester tester) async {
      // Create a test widget to initialize localization
      await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

      // Set up initial components
      compostState.components = List.from(testComponents);

      // Mock successful persistence
      when(mockPersistenceManager.updateComponentInfo(any))
          .thenAnswer((_) => Future.value(true));

      // Update with non-existent component name
      compostState.updateComponentPrice('Non-existent Component', 300);

      // Verify persistence was not called
      verifyNever(mockPersistenceManager.updateComponentInfo(any));
    });

    group('Currency Management', () {
      testWidgets('setSelectedCurrency updates currency and notifies listeners',
          (WidgetTester tester) async {
        // Create a test widget to initialize localization
        await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

        // Mock successful currency persistence
        when(mockPersistenceManager.setSelectedCurrency(any))
            .thenAnswer((_) => Future.value(true));

        // Track notifications
        bool notifierCalled = false;
        compostState.addListener(() {
          notifierCalled = true;
        });

        // Change currency to USD
        await compostState.setSelectedCurrency('USD');

        // Verify currency was updated
        expect(compostState.selectedCurrency, equals('USD'));

        // Verify persistence was called
        verify(mockPersistenceManager.setSelectedCurrency('USD')).called(1);

        // Verify listeners were notified
        expect(notifierCalled, isTrue);
      });

      testWidgets('setSelectedCurrency does nothing for unsupported currency',
          (WidgetTester tester) async {
        // Create a test widget to initialize localization
        await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

        final originalCurrency = compostState.selectedCurrency;

        // Track notifications
        bool notifierCalled = false;
        compostState.addListener(() {
          notifierCalled = true;
        });

        // Try to set unsupported currency
        await compostState.setSelectedCurrency('XYZ');

        // Verify currency was not changed
        expect(compostState.selectedCurrency, equals(originalCurrency));

        // Verify persistence was not called
        verifyNever(mockPersistenceManager.setSelectedCurrency(any));

        // Verify listeners were not notified
        expect(notifierCalled, isFalse);
      });

      testWidgets(
          'updateComponentPrice with currency parameter sets regional price',
          (WidgetTester tester) async {
        // Create a test widget to initialize localization
        await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

        // Set up initial components
        compostState.components = List.from(testComponents);

        // Mock successful persistence
        when(mockPersistenceManager.updateComponentInfo(any))
            .thenAnswer((_) => Future.value(true));

        // Update price in USD (regional pricing)
        compostState.updateComponentPrice('Test Component 1', 2.5,
            currency: 'USD');

        // Verify regional price was set
        final updatedComponent = compostState.components.firstWhere(
          (comp) => comp.id == 'test1',
        );
        expect(updatedComponent.price?.getPriceForCurrency('USD'), equals(2.5));
        expect(updatedComponent.price?.hasRegionalPrice('USD'), isTrue);

        // Verify CFA price remains unchanged
        expect(updatedComponent.price?.pricePerTon,
            equals(100)); // original CFA price
      });

      testWidgets(
          'updateComponentPrice with CFA currency updates base price and preserves regional',
          (WidgetTester tester) async {
        // Create a test widget to initialize localization
        await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

        // Set up initial components with regional pricing
        compostState.components = List.from(testComponents);

        // Mock successful persistence
        when(mockPersistenceManager.updateComponentInfo(any))
            .thenAnswer((_) => Future.value(true));

        // First set a regional price
        compostState.updateComponentPrice('Test Component 1', 2.5,
            currency: 'USD');

        // Verify base CFA price is still 100 and regional USD price is set
        var checkComponent = compostState.components.firstWhere(
          (comp) => comp.id == 'test1',
        );
        expect(checkComponent.price?.pricePerTon,
            equals(100)); // Should still be 100
        expect(checkComponent.price?.getPriceForCurrency('USD'), equals(2.5));

        // Reset mock calls
        clearInteractions(mockPersistenceManager);

        // Mock successful persistence for second call
        when(mockPersistenceManager.updateComponentInfo(any))
            .thenAnswer((_) => Future.value(true));

        // Then update CFA price
        compostState.updateComponentPrice('Test Component 1', 200,
            currency: 'CFA');
        final updatedComponent = compostState.components.firstWhere(
          (comp) => comp.id == 'test1',
        );

        // Verify regional USD price is preserved
        expect(updatedComponent.price?.getPriceForCurrency('USD'), equals(2.5));
        expect(updatedComponent.price?.hasRegionalPrice('USD'), isTrue);
      });

      testWidgets('loads saved currency on initialization',
          (WidgetTester tester) async {
        // Create a test widget to initialize localization
        await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

        // Mock saved currency
        when(mockPersistenceManager.getSelectedCurrency())
            .thenAnswer((_) => Future.value('EUR'));

        // Create new CompostState to trigger initialization
        final newCompostState = CompostState(mockPersistenceManager);

        // Wait for async initialization to complete
        await tester.pump(const Duration(milliseconds: 100));

        // Verify currency was loaded
        expect(newCompostState.selectedCurrency, equals('EUR'));
      });

      testWidgets(
          'falls back to default currency when saved currency is invalid',
          (WidgetTester tester) async {
        // Create a test widget to initialize localization
        await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

        // Mock invalid saved currency
        when(mockPersistenceManager.getSelectedCurrency())
            .thenAnswer((_) => Future.value('INVALID'));

        // Create new CompostState to trigger initialization
        final newCompostState = CompostState(mockPersistenceManager);

        // Wait for async initialization to complete
        await tester.pump(const Duration(milliseconds: 100));

        // Verify falls back to default currency
        expect(newCompostState.selectedCurrency, equals('CFA'));
      });

      testWidgets('falls back to default currency when no saved currency',
          (WidgetTester tester) async {
        // Create a test widget to initialize localization
        await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

        // Mock no saved currency
        when(mockPersistenceManager.getSelectedCurrency())
            .thenAnswer((_) => Future.value(null));

        // Create new CompostState to trigger initialization
        final newCompostState = CompostState(mockPersistenceManager);

        // Wait for async initialization to complete
        await tester.pump(const Duration(milliseconds: 100));

        // Verify uses default currency
        expect(newCompostState.selectedCurrency, equals('CFA'));
      });
    });

    testWidgets('notifyListeners is called after component updates',
        (WidgetTester tester) async {
      // Create a test widget to initialize localization
      await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

      // We need a way to track if notifyListeners is called
      bool notifierCalled = false;
      compostState.addListener(() {
        notifierCalled = true;
      });

      // Set up initial components
      compostState.components = List.from(testComponents);

      // Mock successful persistence
      when(mockPersistenceManager.updateComponentInfo(any))
          .thenAnswer((_) => Future.value(true));

      // Update component
      compostState.updateComponentPrice('Test Component 1', 300);

      // Verify notifyListeners was called
      expect(notifierCalled, isTrue);
    });
  });
}
