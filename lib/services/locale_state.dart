import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleState extends ChangeNotifier {
  static const String _localeKey = 'selected_locale';
  
  // Default to English
  Locale _currentLocale = const Locale('en');
  
  // Supported locales
  static const List<Locale> supportedLocales = [
    Locale('en'), // English
    Locale('fr'), // French
    Locale('ar'), // Arabic
  ];
  
  Locale get currentLocale => _currentLocale;
  
  LocaleState() {
    _loadSavedLocale();
  }
  
  /// Load the saved locale from SharedPreferences
  Future<void> _loadSavedLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLocaleCode = prefs.getString(_localeKey);
      
      if (savedLocaleCode != null) {
        final savedLocale = Locale(savedLocaleCode);
        // Verify the saved locale is supported
        if (supportedLocales.contains(savedLocale)) {
          _currentLocale = savedLocale;
          notifyListeners();
        }
      }
    } catch (e) {
      // If there's an error loading the locale, keep the default
      debugPrint('Error loading saved locale: $e');
    }
  }
  
  /// Change the current locale and save it to SharedPreferences
  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) {
      debugPrint('Unsupported locale: ${locale.languageCode}');
      return;
    }
    
    if (_currentLocale == locale) {
      return; // No change needed
    }
    
    _currentLocale = locale;
    notifyListeners();
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localeKey, locale.languageCode);
    } catch (e) {
      debugPrint('Error saving locale: $e');
    }
  }
  
  /// Get the display name for a locale in the current language context
  String getLanguageDisplayName(Locale locale, BuildContext context) {
    // Import the generated localization class
    // This will be used in the UI to get localized language names
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'fr':
        return 'Français';
      case 'ar':
        return 'العربية';
      default:
        return locale.languageCode.toUpperCase();
    }
  }
  
  /// Get all supported locales with their display names
  List<MapEntry<Locale, String>> getSupportedLocalesWithNames(BuildContext context) {
    return supportedLocales
        .map((locale) => MapEntry(locale, getLanguageDisplayName(locale, context)))
        .toList();
  }
}
