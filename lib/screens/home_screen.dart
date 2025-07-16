import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/persistence_manager.dart';
import '../models/destination_model.dart';
import './recipe_builder_page.dart';
import './price_page.dart';
import "../generated/l10n.dart";
import './app_home_page.dart';
import '../constants/app_colors.dart';

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

  void _sendHelpEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'learning@timeforsense.com',
      query: 'subject=Compost Calculator App - Help Request',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        if (context.mounted) _showHelpDialog();
      }
    } catch (e) {
      // If email app is not available, show help dialog
      if (context.mounted) _showHelpDialog();
    }
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.help_outline, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(S.of(context).getHelp),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).needAssistanceWithCompostCalculator,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(S.of(context).contactOurSupportTeam),
              const SizedBox(height: 8),
              const SelectableText(
                'learning@timeforsense.com',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                S.of(context).helpEmailSubjectInstruction,
                style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                S.of(context).close,
                style: const TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        );
      },
    );
  }

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
          // Return to the main home page instead of exiting
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AppHomePage(),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: Text(
            _destinations[_selectedIndex].label,
            style: const TextStyle(color: AppColors.onPrimary, fontSize: 20),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.home, color: AppColors.onPrimary),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () => _sendHelpEmail(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.help_outline, color: AppColors.onPrimary, size: 20),
                    Text(
                      S.of(context).getHelp,
                      style: const TextStyle(color: AppColors.onPrimary, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(gradient: AppColors.backgroundGradient),
          child: Stack(
            children: List.generate(_destinations.length,
                (index) => _buildOffstageNavigator(index)),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(gradient: AppColors.navBarGradient),
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            backgroundColor:
                Colors.transparent, // Make nav bar transparent to show gradient
            indicatorColor:
                AppColors.primary, // Orange background for selected item
            surfaceTintColor: AppColors.primary,
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
                      selectedIcon: Icon(d.icon,
                          color:
                              AppColors.onPrimary), // White icon when selected
                      label: d.label,
                    ))
                .toList(),
          ),
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
