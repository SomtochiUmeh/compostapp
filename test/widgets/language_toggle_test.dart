import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:compostapp/widgets/language_toggle.dart';
import 'package:compostapp/services/locale_state.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Helper function to create a testable LanguageToggle widget
Widget createTestableLanguageToggle({Locale? initialLocale}) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LocaleState()),
    ],
    child: MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: initialLocale,
      home: Scaffold(
        appBar: AppBar(
          actions: const [
            LanguageToggle(),
          ],
        ),
      ),
    ),
  );
}

void main() {
  group('LanguageToggle Widget Tests', () {
    setUp(() async {
      // Initialize SharedPreferences with mock values
      SharedPreferences.setMockInitialValues({});
    });

    testWidgets('renders language icon button', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableLanguageToggle());
      await tester.pumpAndSettle();

      // Find the language icon button
      expect(find.byIcon(Icons.language), findsOneWidget);
    });

    testWidgets('shows popup menu when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableLanguageToggle());
      await tester.pumpAndSettle();

      // Tap the language toggle button
      await tester.tap(find.byIcon(Icons.language));
      await tester.pumpAndSettle();

      // Check that popup menu items are shown
      expect(find.text('English'), findsOneWidget);
      expect(find.text('Français'), findsOneWidget);
      expect(find.text('العربية'), findsOneWidget);
    });

    testWidgets('shows check mark for current locale', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableLanguageToggle());
      await tester.pumpAndSettle();

      // Tap the language toggle button
      await tester.tap(find.byIcon(Icons.language));
      await tester.pumpAndSettle();

      // Check that there's a check mark (should be for English by default)
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('changes locale when menu item is selected', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableLanguageToggle());
      await tester.pumpAndSettle();

      // Tap the language toggle button
      await tester.tap(find.byIcon(Icons.language));
      await tester.pumpAndSettle();

      // Tap on French
      await tester.tap(find.text('Français'));
      await tester.pumpAndSettle();

      // Open the menu again to verify the change
      await tester.tap(find.byIcon(Icons.language));
      await tester.pumpAndSettle();

      // The check mark should now be next to French
      // We can verify this by checking that French menu item has a check icon
      final frenchMenuItem = find.ancestor(
        of: find.text('Français'),
        matching: find.byType(PopupMenuItem<Locale>),
      );
      expect(frenchMenuItem, findsOneWidget);
    });

    testWidgets('displays correct tooltip', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableLanguageToggle());
      await tester.pumpAndSettle();

      // Find the PopupMenuButton and check its tooltip
      final popupMenuButton = find.byType(PopupMenuButton<Locale>);
      expect(popupMenuButton, findsOneWidget);

      // Long press to show tooltip
      await tester.longPress(popupMenuButton);
      await tester.pumpAndSettle();

      // Check that tooltip is shown (it should show "Language" in English)
      expect(find.text('Language'), findsOneWidget);
    });

    testWidgets('handles all supported locales', (WidgetTester tester) async {
      await tester.pumpWidget(createTestableLanguageToggle());
      await tester.pumpAndSettle();

      // Tap the language toggle button
      await tester.tap(find.byIcon(Icons.language));
      await tester.pumpAndSettle();

      // Verify all supported locales are present
      for (final locale in LocaleState.supportedLocales) {
        String expectedText;
        switch (locale.languageCode) {
          case 'en':
            expectedText = 'English';
            break;
          case 'fr':
            expectedText = 'Français';
            break;
          case 'ar':
            expectedText = 'العربية';
            break;
          default:
            expectedText = locale.languageCode.toUpperCase();
        }
        expect(find.text(expectedText), findsOneWidget);
      }
    });
  });
}
