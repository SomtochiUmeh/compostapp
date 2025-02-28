import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/screens/compost_guidelines_page.dart';
import 'package:compostapp/screens/guideline_detail_page.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Helper function to create a testable CompostGuidelinesPage widget
Widget createTestableCompostGuidelinesPage() {
  return MaterialApp(
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: const CompostGuidelinesPage(),
  );
}

void main() {
  group('CompostGuidelinesPage Widget Tests', () {
    testWidgets('CompostGuidelinesPage renders correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableCompostGuidelinesPage());
      await tester.pumpAndSettle();

      // Verify app bar
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Compost Guidelines'), findsOneWidget);

      // Verify guideline items
      expect(find.text('Aerobic Composting Process'), findsOneWidget);
      expect(find.text('How to Make Compost'), findsOneWidget);
      expect(
          find.text('C:N Ratio & Optimum Compost Conditions'), findsOneWidget);
      expect(find.text('Troubleshooting Compost Problems'), findsOneWidget);

      // Verify icons
      expect(find.byIcon(Icons.recycling), findsOneWidget);
      expect(find.byIcon(Icons.format_list_numbered), findsOneWidget);
      expect(find.byIcon(Icons.balance), findsOneWidget);
      expect(find.byIcon(Icons.build), findsOneWidget);
    });

    testWidgets('Navigation to GuidelineDetailPage works',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableCompostGuidelinesPage());
      await tester.pumpAndSettle();

      // Tap on the first guideline item
      await tester.tap(find.text('Aerobic Composting Process'));
      await tester.pumpAndSettle();

      // Verify navigation to GuidelineDetailPage with correct title
      expect(find.byType(GuidelineDetailPage), findsOneWidget);
      expect(find.text('Aerobic Composting Process'), findsOneWidget);
    });

    testWidgets('All guideline items navigate correctly',
        (WidgetTester tester) async {
      final guidelineItems = [
        'Aerobic Composting Process',
        'How to Make Compost',
        'C:N Ratio & Optimum Compost Conditions',
        'Troubleshooting Compost Problems'
      ];

      for (final item in guidelineItems) {
        await tester.pumpWidget(createTestableCompostGuidelinesPage());
        await tester.pumpAndSettle();

        // Tap on the guideline item
        await tester.tap(find.text(item, skipOffstage: false),
            warnIfMissed: false);
        await tester.pumpAndSettle();

        // Verify navigation to GuidelineDetailPage with correct title
        expect(find.byType(GuidelineDetailPage), findsOneWidget);
        expect(find.text(item, skipOffstage: false), findsAtLeastNWidgets(1));
      }
    });
  });
}
