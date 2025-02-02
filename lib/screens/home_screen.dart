import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/persistence_manager.dart';
import '../models/destination_model.dart';
import './recipe_builder_page.dart';
import './price_page.dart';
import "../generated/l10n.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late List<GlobalKey<NavigatorState>> _navigatorKeys;
  late List<AnimationController> _faders;
  late List<Destination> _destinations;

  @override
  void initState() {
    super.initState();
    _navigatorKeys = List<GlobalKey<NavigatorState>>.generate(
      2,
      (index) => GlobalKey<NavigatorState>(),
    );
    _faders = List<AnimationController>.generate(
      2,
      (index) => AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
    );
    _faders[_selectedIndex].value = 1.0;
  }

  @override
  void dispose() {
    for (var controller in _faders) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _destinations = [
      Destination(
        label: S.of(context).recipeBuilder,
        icon: Icons.compost,
        builder: (context) => RecipeBuilderPage(
          persistenceManager:
              Provider.of<PersistenceManager>(context, listen: false),
        ),
      ),
      Destination(
        label: S.of(context).prices,
        icon: Icons.attach_money,
        builder: (context) => const PricesPage(),
      ),
    ];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final NavigatorState currentNavigator =
            _navigatorKeys[_selectedIndex].currentState!;
        if (currentNavigator.canPop()) {
          currentNavigator.pop();
        } else if (_selectedIndex != 0) {
          setState(() => _selectedIndex = 0);
        } else {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        body: Stack(
          children: List.generate(
              _destinations.length, (index) => _buildOffstageNavigator(index)),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
              for (int i = 0; i < _faders.length; i++) {
                if (i == index) {
                  _faders[i].forward();
                } else {
                  _faders[i].reverse();
                }
              }
            });
          },
          destinations: _destinations
              .map((d) => NavigationDestination(
                    icon: Icon(d.icon),
                    label: d.label,
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: FadeTransition(
        opacity: _faders[index],
        child: Navigator(
          key: _navigatorKeys[index],
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => _destinations[index].builder(context),
            );
          },
        ),
      ),
    );
  }
}
