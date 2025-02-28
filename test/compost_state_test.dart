import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:compostapp/compost_state.dart';
import 'package:compostapp/services/persistence_manager.dart';
import 'package:compostapp/models/compost_component_model.dart';
import 'package:compostapp/models/availability_model.dart';
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
    required super.availability,
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

    // Set up mock response for getSavedComponents - default to null
    when(mockPersistenceManager.getSavedComponents())
        .thenAnswer((_) => Future.value(null));

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
      );

      // Update with non-existent component
      compostState.updateComponent(nonExistentComponent);

      // Verify persistence was not called
      verifyNever(mockPersistenceManager.updateComponentInfo(any));
    });

    testWidgets(
        'getAvailableComponents returns components available on specific date',
        (WidgetTester tester) async {
      // Create a test widget to initialize localization
      await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

      // Set up initial components
      compostState.components = List.from(testComponents);

      // Test for a date when only first component should be available
      final janDate = DateTime(2023, 1, 15);
      final availableInJan = compostState.getAvailableComponents(janDate);
      expect(availableInJan.length, equals(1));
      expect(availableInJan[0].id, equals('test1'));

      // Test for a date when both should be available
      final aprDate = DateTime(2023, 4, 15);
      final availableInApr = compostState.getAvailableComponents(aprDate);
      expect(availableInApr.length, equals(2));

      // Test for a date when only the year-round component should be available
      final sepDate = DateTime(2023, 9, 15);
      final availableInSep = compostState.getAvailableComponents(sepDate);
      expect(availableInSep.length, equals(1));
      expect(availableInSep[0].id, equals('test1'));
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

    testWidgets(
        'updateComponentAvailability updates availability and persists changes',
        (WidgetTester tester) async {
      // Create a test widget to initialize localization
      await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

      // Set up initial components
      compostState.components = List.from(testComponents);

      // Mock successful persistence
      when(mockPersistenceManager.updateComponentInfo(any))
          .thenAnswer((_) => Future.value(true));

      // Update the availability using component ID
      compostState.updateComponentAvailability(
          'test1', AvailabilityPeriod.marToAug);

      // Verify availability was updated
      final updatedIndex =
          compostState.components.indexWhere((comp) => comp.id == 'test1');
      expect(updatedIndex, isNot(-1));
      expect(compostState.components[updatedIndex].availability,
          equals(AvailabilityPeriod.marToAug));

      // Verify persistence was called
      verify(mockPersistenceManager.updateComponentInfo(any)).called(1);
    });

    testWidgets(
        'updateComponentAvailability does nothing if component not found',
        (WidgetTester tester) async {
      // Create a test widget to initialize localization
      await tester.pumpWidget(createTestableWidget(child: const SizedBox()));

      // Set up initial components
      compostState.components = List.from(testComponents);

      // Mock successful persistence
      when(mockPersistenceManager.updateComponentInfo(any))
          .thenAnswer((_) => Future.value(true));

      // Update with non-existent component ID
      compostState.updateComponentAvailability(
          'nonexistent', AvailabilityPeriod.marToAug);

      // Verify persistence was not called
      verifyNever(mockPersistenceManager.updateComponentInfo(any));
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
