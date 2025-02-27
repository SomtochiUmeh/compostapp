import 'package:flutter/material.dart';
import './home_screen.dart';
import './compost_guidelines_page.dart';
import './sample_recipes_page.dart';
import '../generated/l10n.dart';

class AppHomePage extends StatelessWidget {
  const AppHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        elevation: 0,
        title: Text(
          S.of(context).compostCalculator,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      S.of(context).welcomeToCompostCalculator,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.of(context).thisAppIsDesignedToHelpYouCreateAndManage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
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
                          S.of(context).compostGuidelines,
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
                          S.of(context).sampleCompostRecipes,
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
                          S.of(context).recipeBuilder,
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
