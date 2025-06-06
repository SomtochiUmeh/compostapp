import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:compostapp/services/locale_state.dart';

void main() {
  group('LocaleState Tests', () {
    late LocaleState localeState;

    setUp(() async {
      // Initialize SharedPreferences with mock values
      SharedPreferences.setMockInitialValues({});
      localeState = LocaleState();
      // Wait for the initial load to complete
      await Future.delayed(const Duration(milliseconds: 100));
    });

    test('initializes with default English locale', () {
      expect(localeState.currentLocale, equals(const Locale('en')));
    });

    test('supportedLocales contains all expected locales', () {
      expect(LocaleState.supportedLocales, contains(const Locale('en')));
      expect(LocaleState.supportedLocales, contains(const Locale('fr')));
      expect(LocaleState.supportedLocales, contains(const Locale('ar')));
      expect(LocaleState.supportedLocales.length, equals(4));
    });

    test('setLocale changes current locale', () async {
      const newLocale = Locale('fr');
      await localeState.setLocale(newLocale);
      expect(localeState.currentLocale, equals(newLocale));
    });

    test('setLocale persists locale to SharedPreferences', () async {
      const newLocale = Locale('ar');
      await localeState.setLocale(newLocale);
      
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('selected_locale'), equals('ar'));
    });

    test('setLocale does not change locale for unsupported locale', () async {
      const originalLocale = Locale('en');
      const unsupportedLocale = Locale('de'); // German - not supported
      
      expect(localeState.currentLocale, equals(originalLocale));
      await localeState.setLocale(unsupportedLocale);
      expect(localeState.currentLocale, equals(originalLocale));
    });

    test('setLocale does not change locale if same locale is set', () async {
      const locale = Locale('en');
      bool notifierCalled = false;
      
      localeState.addListener(() {
        notifierCalled = true;
      });
      
      await localeState.setLocale(locale);
      expect(notifierCalled, isFalse);
    });

    test('loads saved locale from SharedPreferences', () async {
      // Set up SharedPreferences with a saved locale
      SharedPreferences.setMockInitialValues({'selected_locale': 'fr'});
      
      // Create a new LocaleState instance
      final newLocaleState = LocaleState();
      
      // Wait for the async load to complete
      await Future.delayed(const Duration(milliseconds: 100));
      
      expect(newLocaleState.currentLocale, equals(const Locale('fr')));
    });

    test('ignores invalid saved locale from SharedPreferences', () async {
      // Set up SharedPreferences with an invalid locale
      SharedPreferences.setMockInitialValues({'selected_locale': 'invalid'});
      
      // Create a new LocaleState instance
      final newLocaleState = LocaleState();
      
      // Wait for the async load to complete
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Should fall back to default English
      expect(newLocaleState.currentLocale, equals(const Locale('en')));
    });

    test('getLanguageDisplayName returns correct names', () {
      expect(localeState.getLanguageDisplayName(const Locale('en'), MockBuildContext()), equals('English'));
      expect(localeState.getLanguageDisplayName(const Locale('fr'), MockBuildContext()), equals('Français'));
      expect(localeState.getLanguageDisplayName(const Locale('ar'), MockBuildContext()), equals('العربية'));
      expect(localeState.getLanguageDisplayName(const Locale('unknown'), MockBuildContext()), equals('UNKNOWN'));
    });

    test('getSupportedLocalesWithNames returns correct list', () {
      final localesWithNames = localeState.getSupportedLocalesWithNames(MockBuildContext());
      
      expect(localesWithNames.length, equals(3));
      expect(localesWithNames.any((entry) => entry.key == const Locale('en') && entry.value == 'English'), isTrue);
      expect(localesWithNames.any((entry) => entry.key == const Locale('fr') && entry.value == 'Français'), isTrue);
      expect(localesWithNames.any((entry) => entry.key == const Locale('ar') && entry.value == 'العربية'), isTrue);
    });
  });
}

// Mock BuildContext for testing
class MockBuildContext extends BuildContext {
  @override
  bool get debugDoingBuild => false;

  @override
  InheritedWidget dependOnInheritedElement(InheritedElement ancestor, {Object? aspect}) {
    throw UnimplementedError();
  }

  @override
  T? dependOnInheritedWidgetOfExactType<T extends InheritedWidget>({Object? aspect}) {
    throw UnimplementedError();
  }

  @override
  T? getInheritedWidgetOfExactType<T extends InheritedWidget>() {
    throw UnimplementedError();
  }

  @override
  DiagnosticsNode describeElement(String name, {Object? style}) {
    throw UnimplementedError();
  }

  @override
  List<DiagnosticsNode> describeMissingAncestor({required Type expectedAncestorType}) {
    throw UnimplementedError();
  }

  @override
  DiagnosticsNode describeOwnershipChain(String name) {
    throw UnimplementedError();
  }

  @override
  DiagnosticsNode describeWidget(String name, {Object? style}) {
    throw UnimplementedError();
  }

  @override
  void dispatchNotification(Notification notification) {}

  @override
  T? findAncestorRenderObjectOfType<T extends RenderObject>() {
    throw UnimplementedError();
  }

  @override
  T? findAncestorStateOfType<T extends State<StatefulWidget>>() {
    throw UnimplementedError();
  }

  @override
  T? findAncestorWidgetOfExactType<T extends Widget>() {
    throw UnimplementedError();
  }

  @override
  RenderObject? findRenderObject() {
    throw UnimplementedError();
  }

  @override
  T? findRootAncestorStateOfType<T extends State<StatefulWidget>>() {
    throw UnimplementedError();
  }

  @override
  InheritedElement? getElementForInheritedWidgetOfExactType<T extends InheritedWidget>() {
    throw UnimplementedError();
  }

  @override
  BuildOwner? get owner => throw UnimplementedError();

  @override
  Size? get size => throw UnimplementedError();

  @override
  void visitAncestorElements(bool Function(Element element) visitor) {}

  @override
  void visitChildElements(ElementVisitor visitor) {}

  @override
  Widget get widget => throw UnimplementedError();

  @override
  bool get mounted => throw UnimplementedError();
}
