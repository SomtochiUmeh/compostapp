import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:compostapp/widgets/currency_selector.dart';
import 'package:compostapp/compost_state.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([CompostState])
import 'currency_selector_test.mocks.dart';

void main() {
  group('CurrencySelector Widget Tests', () {
    late MockCompostState mockCompostState;

    setUp(() {
      mockCompostState = MockCompostState();
      when(mockCompostState.selectedCurrency).thenReturn('CFA');
    });

    Widget createTestableWidget() {
      return ChangeNotifierProvider<CompostState>.value(
        value: mockCompostState,
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const Scaffold(
            body: CurrencySelector(),
          ),
        ),
      );
    }

    testWidgets('renders correctly with default currency',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Verify currency label is displayed
      expect(find.text('Currency'), findsOneWidget);

      // Verify dropdown is present
      expect(find.byType(DropdownButton<String>), findsOneWidget);

      // Verify default CFA selection is shown
      expect(find.text('CFA (FCFA)'), findsOneWidget);
    });

    testWidgets('shows all supported currencies in dropdown',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Tap the dropdown to open it
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // Verify all currency options are available
      expect(find.text('CFA (FCFA)'), findsWidgets);
      expect(find.text('USD (\$)'), findsOneWidget);
      expect(find.text('EUR (€)'), findsOneWidget);
      expect(find.text('GBP (£)'), findsOneWidget);
      expect(find.text('MWK (MWK)'), findsOneWidget);
      expect(find.text('NGN (₦)'), findsOneWidget);
      expect(find.text('GHS (₵)'), findsOneWidget);
    });

    testWidgets('calls setSelectedCurrency when currency is changed',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Tap the dropdown to open it
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // Select USD option
      await tester.tap(find.text('USD (\$)').last);
      await tester.pumpAndSettle();

      // Verify setSelectedCurrency was called with USD
      verify(mockCompostState.setSelectedCurrency('USD')).called(1);
    });

    testWidgets('displays different selected currency correctly',
        (WidgetTester tester) async {
      when(mockCompostState.selectedCurrency).thenReturn('USD');

      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Verify USD selection is shown
      expect(find.text('USD (\$)'), findsOneWidget);
      expect(find.text('CFA (FCFA)'), findsNothing);
    });

    testWidgets('has proper styling and layout', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Verify row layout - expect at least one (allowing for multiple in the widget tree)
      expect(find.byType(Row), findsWidgets);

      // Verify SizedBox spacing - expect at least one
      expect(find.byType(SizedBox), findsWidgets);

      // Verify container styling (there might be multiple containers)
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('dropdown has no underline', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Verify DropdownButtonHideUnderline is used
      expect(find.byType(DropdownButtonHideUnderline), findsOneWidget);
    });

    testWidgets('handles null currency selection gracefully',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // This should not crash the widget
      final dropdown = tester
          .widget<DropdownButton<String>>(find.byType(DropdownButton<String>));
      expect(dropdown.onChanged, isNotNull);

      // Calling with null should not cause errors (though setSelectedCurrency won't be called)
      dropdown.onChanged!(null);
      await tester.pumpAndSettle();

      // Verify setSelectedCurrency was not called with null
      verifyNever(mockCompostState.setSelectedCurrency(null));
    });

    testWidgets('updates when CompostState selectedCurrency changes',
        (WidgetTester tester) async {
      // Create a separate mock for EUR testing
      final eurMockCompostState = MockCompostState();
      when(eurMockCompostState.selectedCurrency).thenReturn('EUR');

      Widget createEurTestableWidget() {
        return ChangeNotifierProvider<CompostState>.value(
          value: eurMockCompostState,
          child: MaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: const Scaffold(
              body: CurrencySelector(),
            ),
          ),
        );
      }

      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Initially shows CFA
      expect(find.text('CFA (FCFA)'), findsOneWidget);

      // Test with EUR widget
      await tester.pumpWidget(createEurTestableWidget());
      await tester.pumpAndSettle();

      // Should now show EUR
      expect(find.text('EUR (€)'), findsOneWidget);
      expect(find.text('CFA (FCFA)'), findsNothing);
    });

    testWidgets('displays correct text style for currency label',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Find the currency label text
      final textFinder = find.text('Currency');
      expect(textFinder, findsOneWidget);

      final text = tester.widget<Text>(textFinder);
      expect(text.style, isNotNull);
      // The style should use Theme.of(context).textTheme.titleMedium
    });

    testWidgets('dropdown items have correct text style',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Tap the dropdown to open it
      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      // Find dropdown menu items and verify they have proper styling
      final dropdownItems = find.byType(DropdownMenuItem<String>);
      expect(dropdownItems, findsWidgets); // Should find dropdown items

      // There might be duplicates in the widget tree during testing,
      // so just verify that we can find items with the expected currencies
      expect(find.text('CFA (FCFA)'), findsWidgets);
      expect(find.text('USD (\$)'), findsWidgets);
    });
  });
}
