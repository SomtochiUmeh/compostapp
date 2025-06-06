import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/locale_state.dart';
import '../generated/l10n.dart';

class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleState>(
      builder: (context, localeState, child) {
        return PopupMenuButton<Locale>(
          icon: const Icon(Icons.language),
          tooltip: S.of(context).language,
          onSelected: (Locale locale) {
            localeState.setLocale(locale);
          },
          itemBuilder: (BuildContext context) {
            return LocaleState.supportedLocales.map((Locale locale) {
              return PopupMenuItem<Locale>(
                value: locale,
                child: Row(
                  children: [
                    // Add a check mark for the current locale
                    Icon(
                      localeState.currentLocale == locale
                          ? Icons.check
                          : Icons.check_box_outline_blank,
                      size: 20,
                      color: localeState.currentLocale == locale
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                    ),
                    const SizedBox(width: 8),
                    Text(_getLocalizedLanguageName(locale, context)),
                  ],
                ),
              );
            }).toList();
          },
        );
      },
    );
  }

  /// Get the localized name for a language
  String _getLocalizedLanguageName(Locale locale, BuildContext context) {
    switch (locale.languageCode) {
      case 'en':
        return S.of(context).english;
      case 'fr':
        return S.of(context).french;
      case 'ar':
        return S.of(context).arabic;
      case 'af':
        return S.of(context).afrikaans;
      default:
        return locale.languageCode.toUpperCase();
    }
  }
}
