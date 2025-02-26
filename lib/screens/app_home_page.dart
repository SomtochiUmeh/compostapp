import 'package:flutter/material.dart';
import './home_screen.dart';
import './compost_guidelines_page.dart';
import './sample_recipes_page.dart';

class AppHomePage extends StatelessWidget {
  const AppHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        elevation: 0,
        title: const Text(
          'Compost Calculator',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Welcome to Compost Calculator',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This app is designed to help you create and manage open-pile aerobic composting. Use the tools below to learn about composting, explore recipes, or create your own!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: 2.0,
                      mainAxisSpacing: 20,
                      children: [
                        _buildNavigationButton(
                          context,
                          'Compost Guidelines',
                          Icons.menu_book,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const CompostGuidelinesPage(),
                            ),
                          ),
                        ),
                        _buildNavigationButton(
                          context,
                          'Sample Compost Recipes',
                          Icons.receipt_long,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SampleRecipesPage(),
                            ),
                          ),
                        ),
                        _buildNavigationButton(
                          context,
                          'Recipe Builder',
                          Icons.compost,
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: Colors.brown.shade300,
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
