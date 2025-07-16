import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import './home_screen.dart';
import './compost_guidelines_page.dart';
import './sample_recipes_page.dart';
import '../generated/l10n.dart';
import '../constants/app_colors.dart';

class AppHomePage extends StatelessWidget {
  const AppHomePage({super.key});

  void _sendHelpEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'learning@timeforsense.com',
      query: 'subject=Compost Calculator App - Help Request',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        if (context.mounted) _showHelpDialog(context);
      }
    } catch (e) {
      // If email app is not available, show help dialog
      if (context.mounted) _showHelpDialog(context);
    }
  }

  void _showHelpDialog(BuildContext context) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          S.of(context).compostCalculator,
          style: const TextStyle(color: AppColors.onPrimary, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () => _sendHelpEmail(context),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 8,
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
        elevation: 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 60,
              color: AppColors.secondary,
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
