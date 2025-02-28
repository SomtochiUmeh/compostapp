import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/models/availability_model.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

// Create a testable app with localization
Widget createTestableApp() {
  return MaterialApp(
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: const SizedBox(),
  );
}

void main() {
  group('AvailabilityPeriod', () {
    testWidgets('predefined periods have correct month ranges',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableApp());

      expect(AvailabilityPeriod.janToDec.startMonth, 1);
      expect(AvailabilityPeriod.janToDec.endMonth, 12);

      expect(AvailabilityPeriod.marToAug.startMonth, 3);
      expect(AvailabilityPeriod.marToAug.endMonth, 8);

      expect(AvailabilityPeriod.octToDec.startMonth, 10);
      expect(AvailabilityPeriod.octToDec.endMonth, 12);

      expect(AvailabilityPeriod.octToJan.startMonth, 10);
      expect(AvailabilityPeriod.octToJan.endMonth, 1);

      expect(AvailabilityPeriod.mayToJul.startMonth, 5);
      expect(AvailabilityPeriod.mayToJul.endMonth, 7);

      expect(AvailabilityPeriod.sepToDec.startMonth, 9);
      expect(AvailabilityPeriod.sepToDec.endMonth, 12);
    });

    testWidgets('custom period can be created', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableApp());

      final customPeriod = AvailabilityPeriod(2, 5);
      expect(customPeriod.startMonth, 2);
      expect(customPeriod.endMonth, 5);
      expect(customPeriod.name, 'custom_2_to_5');
    });

    test('isAvailable works for continuous period (startMonth <= endMonth)',
        () {
      final period = AvailabilityPeriod(3, 8); // Mar-Aug

      // Inside period
      expect(period.isAvailable(DateTime(2023, 3, 1)), true);
      expect(period.isAvailable(DateTime(2023, 5, 15)), true);
      expect(period.isAvailable(DateTime(2023, 8, 31)), true);

      // Outside period
      expect(period.isAvailable(DateTime(2023, 1, 1)), false);
      expect(period.isAvailable(DateTime(2023, 2, 28)), false);
      expect(period.isAvailable(DateTime(2023, 9, 1)), false);
      expect(period.isAvailable(DateTime(2023, 12, 31)), false);
    });

    test('isAvailable works for wrapped period (startMonth > endMonth)', () {
      final period =
          AvailabilityPeriod(10, 2); // Oct-Feb (wraps around year end)

      // Inside period
      expect(period.isAvailable(DateTime(2023, 10, 1)), true);
      expect(period.isAvailable(DateTime(2023, 12, 25)), true);
      expect(period.isAvailable(DateTime(2023, 1, 15)), true);
      expect(period.isAvailable(DateTime(2023, 2, 28)), true);

      // Outside period
      expect(period.isAvailable(DateTime(2023, 3, 1)), false);
      expect(period.isAvailable(DateTime(2023, 6, 15)), false);
      expect(period.isAvailable(DateTime(2023, 9, 30)), false);
    });

    testWidgets(
        'getLocalizedPeriod returns correct string for predefined periods',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableApp());

      // Wait for localization to initialize
      await tester.pumpAndSettle();

      // Now test the localized strings
      expect(AvailabilityPeriod.janToDec.getLocalizedPeriod(), isNotEmpty);
      expect(AvailabilityPeriod.marToAug.getLocalizedPeriod(), isNotEmpty);
      expect(AvailabilityPeriod.octToDec.getLocalizedPeriod(), isNotEmpty);
      expect(AvailabilityPeriod.octToJan.getLocalizedPeriod(), isNotEmpty);
      expect(AvailabilityPeriod.mayToJul.getLocalizedPeriod(), isNotEmpty);
      expect(AvailabilityPeriod.sepToDec.getLocalizedPeriod(), isNotEmpty);
    });

    testWidgets('getLocalizedPeriod generates string for custom periods',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableApp());

      // Wait for localization to initialize
      await tester.pumpAndSettle();

      final customPeriod = AvailabilityPeriod(2, 5);

      // Should include both month names
      final localizedString = customPeriod.getLocalizedPeriod();

      expect(localizedString, isNotEmpty);
      // Month name testing isn't 100% reliable since it depends on localization,
      // but this should be a good indication if it's working
      expect(
          localizedString.contains('2'), false); // Should use name not number
      expect(
          localizedString.contains('5'), false); // Should use name not number
    });

    test('toJson and fromJson work correctly', () {
      // Test predefined period
      const predefinedPeriod = AvailabilityPeriod.marToAug;
      final json = predefinedPeriod.toJson();
      final restoredPeriod = AvailabilityPeriod.fromJson(json);

      expect(restoredPeriod, equals(predefinedPeriod));
      expect(restoredPeriod.startMonth, predefinedPeriod.startMonth);
      expect(restoredPeriod.endMonth, predefinedPeriod.endMonth);
      expect(restoredPeriod.name, predefinedPeriod.name);

      // Test custom period
      final customPeriod = AvailabilityPeriod(2, 5);
      final customJson = customPeriod.toJson();
      final restoredCustom = AvailabilityPeriod.fromJson(customJson);

      expect(restoredCustom.startMonth, customPeriod.startMonth);
      expect(restoredCustom.endMonth, customPeriod.endMonth);
      expect(restoredCustom.name, customPeriod.name);
    });

    test('equality comparisons work correctly', () {
      final period1 = AvailabilityPeriod(3, 8);
      final period2 = AvailabilityPeriod(3, 8);
      final period3 = AvailabilityPeriod(3, 9);

      expect(period1 == period2, true);
      expect(period1 == period3, false);

      // Compare with predefined period that has the same start/end months
      expect(period1 == AvailabilityPeriod.marToAug, true);

      // Hash codes
      expect(period1.hashCode == period2.hashCode, true);
      expect(period1.hashCode == period3.hashCode, false);
    });

    test('toString returns the name', () {
      expect(AvailabilityPeriod.janToDec.toString(), 'janToDec');
      expect(AvailabilityPeriod(2, 5).toString(), 'custom_2_to_5');
    });

    test('values list contains all predefined periods', () {
      expect(AvailabilityPeriod.values.length, 6);
      expect(AvailabilityPeriod.values.contains(AvailabilityPeriod.janToDec),
          true);
      expect(AvailabilityPeriod.values.contains(AvailabilityPeriod.marToAug),
          true);
      expect(AvailabilityPeriod.values.contains(AvailabilityPeriod.octToDec),
          true);
      expect(AvailabilityPeriod.values.contains(AvailabilityPeriod.octToJan),
          true);
      expect(AvailabilityPeriod.values.contains(AvailabilityPeriod.mayToJul),
          true);
      expect(AvailabilityPeriod.values.contains(AvailabilityPeriod.sepToDec),
          true);
    });

    test('periods with same month values are equal regardless of internal name',
        () {
      // Create a custom period with the same months as a predefined one
      final customJanToDec = AvailabilityPeriod(1, 12);
      expect(customJanToDec == AvailabilityPeriod.janToDec, true);

      // But the names should be different
      expect(customJanToDec.name != AvailabilityPeriod.janToDec.name, true);
    });
  });
}
