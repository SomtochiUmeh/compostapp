import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/screens/guideline_detail_page.dart';
import 'package:compostapp/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Helper function to create a testable GuidelineDetailPage widget
Widget createTestableGuidelineDetailPage(String title) {
  return MaterialApp(
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: GuidelineDetailPage(title: title),
  );
}

void main() {
  group('GuidelineDetailPage Widget Tests', () {
    testWidgets('GuidelineDetailPage renders with Aerobic Composting content',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          createTestableGuidelineDetailPage('Aerobic Composting Process'));
      await tester.pumpAndSettle();

      // Verify app bar
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Aerobic Composting Process'), findsOneWidget);

      // Verify content specific to Aerobic Composting
      expect(find.text('Composting happens in four stages:'), findsOneWidget);
      expect(find.text('Start-up'), findsOneWidget);
      expect(find.text('Heating'), findsOneWidget);
      expect(find.text('Cooling'), findsOneWidget);
      expect(find.text('Maturing'), findsOneWidget);

      // Verify timeline is showing
      expect(find.byIcon(Icons.play_arrow), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.whatshot), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.ac_unit), findsAtLeastNWidgets(1));
      expect(find.byIcon(Icons.eco), findsAtLeastNWidgets(1));
    });

    testWidgets('GuidelineDetailPage renders with How to Make Compost content',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(createTestableGuidelineDetailPage('How to Make Compost'));
      await tester.pumpAndSettle();

      // Verify app bar
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('How to Make Compost'), findsOneWidget);

      // Verify content specific to How to Make Compost
      expect(find.text('Visual Tip'), findsOneWidget);
      expect(find.text('Choose a site'), findsOneWidget);
      expect(find.text('Layer materials'), findsOneWidget);
      expect(find.text('Maintain moisture'), findsOneWidget);
      expect(find.text('Turn the pile regularly'), findsOneWidget);
      expect(find.text('Check readiness'), findsOneWidget);
    });

    testWidgets(
        'GuidelineDetailPage renders with C/N Ratio & Optimum Conditions content',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableGuidelineDetailPage(
          'C:N Ratio & Optimum Compost Conditions'));
      await tester.pumpAndSettle();

      // Verify app bar
      expect(find.byType(AppBar), findsOneWidget);
      expect(
          find.text('C:N Ratio & Optimum Compost Conditions'), findsOneWidget);

      // Verify content specific to C/N Ratio
      expect(find.text('C:N Ratio Explained:'), findsOneWidget);
      expect(find.text('High Carbon'), findsOneWidget);
      expect(find.text('High Nitrogen'), findsOneWidget);
      expect(find.text('Browns'), findsOneWidget);
      expect(find.text('Greens'), findsOneWidget);
      expect(find.text('Optimum Moisture'), findsOneWidget);
      expect(find.text('Oxygen Requirements'), findsOneWidget);
    });

    testWidgets(
        'GuidelineDetailPage renders with Troubleshooting Problems content',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableGuidelineDetailPage(
          'Troubleshooting Compost Problems'));
      await tester.pumpAndSettle();

      // Verify app bar
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Troubleshooting Compost Problems'), findsOneWidget);

      // Verify content specific to Troubleshooting
      expect(find.text('Common Compost Problems & Solutions'), findsOneWidget);
      expect(find.text('Quick Check'), findsOneWidget);
      expect(find.text('Pile Isn\'t Heating Up'), findsOneWidget);
      expect(find.text('Bad Odors'), findsOneWidget);
      expect(find.text('Pests in the Compost'), findsOneWidget);

      // Verify common sections
      expect(find.text('Possible Causes:'), findsAtLeastNWidgets(1));
      expect(find.text('Solutions:'), findsAtLeastNWidgets(1));
    });

    testWidgets('GuidelineDetailPage handles unknown content gracefully',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(createTestableGuidelineDetailPage('Unknown Content'));
      await tester.pumpAndSettle();

      // Verify app bar
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Unknown Content'), findsOneWidget);

      // Verify fallback message
      expect(find.text('Content not available'), findsOneWidget);
    });
  });
}
