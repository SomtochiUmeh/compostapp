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

  group('CompostGuidelinesPage Navigation Tests', () {
    // testWidgets('Navigation to all guideline detail pages works correctly',
    //     (WidgetTester tester) async {
    //   // Define all guideline titles to test
    //   final guidelineTitles = [
    //     'Aerobic Composting Process',
    //     'How to Make Compost',
    //     'C:N Ratio & Optimum Compost Conditions',
    //     'Troubleshooting Compost Problems'
    //   ];

    //   // Test navigation for each guideline item
    //   for (final title in guidelineTitles) {
    //     // Build the CompostGuidelinesPage fresh for each test
    //     await tester.pumpWidget(createTestableCompostGuidelinesPage());
    //     await tester.pumpAndSettle();

    //     // Verify the CompostGuidelinesPage is rendered with the expected items
    //     expect(find.text(title, skipOffstage: false), findsOneWidget);

    //     // Find and tap on the guideline item
    //     await tester.tap(find.text(title, skipOffstage: false));
    //     await tester.pumpAndSettle();

    //     // Verify navigation to GuidelineDetailPage with correct title
    //     expect(find.byType(GuidelineDetailPage), findsOneWidget);
    //     expect(find.text(title, skipOffstage: false), findsAtLeastNWidgets(1));

    //     // Verify some content is displayed - different for each type of guideline
    //     if (title == 'Aerobic Composting Process') {
    //       expect(
    //           find.text('Composting happens in four stages:',
    //               skipOffstage: false),
    //           findsOneWidget);
    //     } else if (title == 'How to Make Compost') {
    //       expect(find.text('Visual Tip', skipOffstage: false), findsOneWidget);
    //     } else if (title == 'C:N Ratio & Optimum Compost Conditions') {
    //       expect(find.text('C:N Ratio Explained:', skipOffstage: false),
    //           findsOneWidget);
    //     } else if (title == 'Troubleshooting Compost Problems') {
    //       expect(
    //           find.text('Common Compost Problems & Solutions',
    //               skipOffstage: false),
    //           findsOneWidget);
    //     }
    //   }
    // });

    // Test each navigation individually for more detailed coverage
    testWidgets('Navigate to Aerobic Composting Process detail page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableCompostGuidelinesPage());
      await tester.pumpAndSettle();

      const title = 'Aerobic Composting Process';
      await tester.tap(find.text(title));
      await tester.pumpAndSettle();

      expect(find.byType(GuidelineDetailPage), findsOneWidget);
      expect(find.text(title), findsOneWidget);

      // Check for specific Aerobic Composting content
      expect(find.text('Composting happens in four stages:'), findsOneWidget);
      expect(find.text('Start-up'), findsOneWidget);
      expect(find.text('Heating'), findsOneWidget);
      expect(find.text('Cooling'), findsOneWidget);
      expect(find.text('Maturing'), findsOneWidget);
    });

    testWidgets('Navigate to How to Make Compost detail page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableCompostGuidelinesPage());
      await tester.pumpAndSettle();

      const title = 'How to Make Compost';
      await tester.tap(find.text(title));
      await tester.pumpAndSettle();

      expect(find.byType(GuidelineDetailPage), findsOneWidget);
      expect(find.text(title), findsOneWidget);

      // Check for specific How to Make Compost content
      expect(find.text('Visual Tip'), findsOneWidget);
      expect(find.text('Choose a site'), findsOneWidget);
      expect(find.text('Layer materials'), findsOneWidget);
    });

    testWidgets(
        'Navigate to C:N Ratio & Optimum Compost Conditions detail page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableCompostGuidelinesPage());
      await tester.pumpAndSettle();

      const title = 'C:N Ratio & Optimum Compost Conditions';
      await tester.tap(find.text(title));
      await tester.pumpAndSettle();

      expect(find.byType(GuidelineDetailPage), findsOneWidget);
      expect(find.text(title), findsOneWidget);

      // Check for specific C:N Ratio content
      expect(find.text('C:N Ratio Explained:'), findsOneWidget);
      expect(find.text('High Carbon'), findsOneWidget);
      expect(find.text('High Nitrogen'), findsOneWidget);
    });

    testWidgets('Navigate to Troubleshooting Compost Problems detail page',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableCompostGuidelinesPage());
      await tester.pumpAndSettle();

      const title = 'Troubleshooting Compost Problems';
      await tester.tap(find.text(title));
      await tester.pumpAndSettle();

      expect(find.byType(GuidelineDetailPage), findsOneWidget);
      expect(find.text(title), findsOneWidget);

      // Check for specific Troubleshooting content
      expect(find.text('Common Compost Problems & Solutions'), findsOneWidget);
      expect(find.text('Quick Check'), findsOneWidget);
      expect(find.text('Pile Isn\'t Heating Up'), findsOneWidget);
    });
  });
}
