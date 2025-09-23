import 'package:flutter/material.dart';
import '../generated/l10n.dart';
import '../constants/app_colors.dart';

class SampleRecipesPage extends StatelessWidget {
  const SampleRecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
              width: 60,
              child: Image.asset(
                'assets/images/sense_logo.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              S.of(context).sampleCompostRecipes,
              style: const TextStyle(color: AppColors.onPrimary, fontSize: 16),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildRecipeCard(
            context,
            S.of(context).basicGardenCompost,
            S.of(context).aSimpleBalancedRecipeForGeneralGardenUse,
            [
              S.of(context).partsDryLeaves,
              S.of(context).partFreshGrassClippings,
              S.of(context).partVegetableScraps
            ],
            S.of(context).layerIngredientsMoistenAndTurnEvery12WeeksReadyIn,
          ),
          _buildRecipeCard(
            context,
            S.of(context).fastHotCompost,
            S.of(context).forWhenYouNeedCompostQuickly,
            [
              S.of(context).partsChoppedStrawOrWoodChips,
              S.of(context).partChickenManure,
              S.of(context).partGreenGardenWasteChoppedSmall
            ],
            S.of(context).mixThoroughlyEnsureAdequateMoistureAndTurnEvery3Days,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Center(
          child: Container(
            height: 20,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
            ),
            child: Image.asset(
              'assets/images/sense_logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeCard(
    BuildContext context,
    String title,
    String description,
    List<String> ingredients,
    String instructions,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).ingredients,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...ingredients.map((ingredient) => Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                  child: Text(
                    '• $ingredient',
                    style: const TextStyle(fontSize: 14),
                  ),
                )),
            const SizedBox(height: 16),
            Text(
              S.of(context).instructions,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              instructions,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
