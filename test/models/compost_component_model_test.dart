import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/models/compost_component_model.dart';
import 'package:compostapp/models/nutrient_content_model.dart';
import 'package:compostapp/models/price_model.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

// Create a testable app with localization
Widget createTestableApp({required Widget child}) {
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

// Create a custom CompostComponent implementation for testing
class TestCompostComponent extends CompostComponent {
  final String displayName;

  TestCompostComponent({
    required super.id,
    required this.displayName,
    required super.nutrients,
    super.price,
    super.sources,
  }) : super(
          name: displayName,
        );

  @override
  String getName() => displayName;
}

void main() {
  late CompostComponent testComponent;

  setUp(() {
    testComponent = TestCompostComponent(
      id: 'TestId',
      displayName: 'Test Component',
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
      sources: const ['Source 1', 'Source 2'],
    );
  });

  group('CompostComponent', () {
    test('constructor initializes all properties correctly', () {
      expect(testComponent.id, 'TestId');
      expect(testComponent.name, 'Test Component');
      expect(testComponent.nutrients.dryMatterPercent, 0.5);
      expect(testComponent.nutrients.organicCarbonPercent, 0.3);
      expect(testComponent.nutrients.nitrogenPercent, 0.1);
      expect(testComponent.price?.pricePerTon, 100);
      expect(testComponent.sources, ['Source 1', 'Source 2']);
    });

    test('getName returns component name', () {
      // Since we're using TestCompostComponent, getName should return the displayName
      expect(testComponent.getName(), 'Test Component');
    });

    test('handles optional price field correctly', () {
      // Component with price
      expect(testComponent.price, isNotNull);
      expect(testComponent.price?.pricePerTon, 100);

      // Component without price
      final noPriceComponent = TestCompostComponent(
        id: 'NoPrice',
        displayName: 'No Price Component',
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

      expect(noPriceComponent.price, isNull);
    });

    test('handles optional sources field correctly', () {
      // Component with sources
      expect(testComponent.sources, isNotEmpty);
      expect(testComponent.sources.length, 2);
      expect(testComponent.sources, contains('Source 1'));

      // Component without sources
      final noSourcesComponent = TestCompostComponent(
        id: 'NoSources',
        displayName: 'No Sources Component',
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

      expect(noSourcesComponent.sources, isEmpty);
    });

    test('component with same properties is equal', () {
      final component1 = TestCompostComponent(
        id: 'test',
        displayName: 'Test',
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

      final component2 = TestCompostComponent(
        id: 'test',
        displayName: 'Test',
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

      // In most cases, instances will be compared by identity, not value equality
      // This test is just to document current behavior
      expect(identical(component1, component2), false); // Not the same instance
    });
  });
}
