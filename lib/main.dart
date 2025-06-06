import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import './screens/app_home_page.dart';
import './compost_state.dart';
import './services/persistence_manager.dart';
import './services/locale_state.dart';
import './generated/l10n.dart';

// coverage:ignore-start
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PersistenceManager.init();
  final persistenceManager = PersistenceManager();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CompostState(persistenceManager)),
        ChangeNotifierProvider(
            create: (context) => LocaleState()),
        Provider.value(value: persistenceManager),
      ],
      child: const CompostCalculatorApp(),
    ),
  );
}
// coverage:ignore-end

class CompostCalculatorApp extends StatelessWidget {
  const CompostCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleState>(
      builder: (context, localeState, child) {
        return MaterialApp(
          title: 'Compost Calculator',
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          locale: localeState.currentLocale,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
          ),
          home: const AppHomePage(),
        );
      },
    );
  }
}
