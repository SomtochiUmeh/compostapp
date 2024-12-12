import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/home_screen.dart';
import './compost_state.dart';
import './services/persistence_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PersistenceManager.init();
  final persistenceManager = PersistenceManager();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => CompostState(persistenceManager)),
        Provider.value(value: persistenceManager),
      ],
      child: const CompostCalculatorApp(),
    ),
  );
}

class CompostCalculatorApp extends StatelessWidget {
  const CompostCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const HomeScreen(),
    );
  }
}
