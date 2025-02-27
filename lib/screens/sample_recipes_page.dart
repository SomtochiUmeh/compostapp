import 'package:flutter/material.dart';

class SampleRecipesPage extends StatelessWidget {
  const SampleRecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        elevation: 0,
        title: const Text(
          'Sample Compost Recipes',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildRecipeCard(
            context,
            'Basic Garden Compost',
            'A simple, balanced recipe for general garden use.',
            [
              '3 parts dry leaves',
              '1 part fresh grass clippings',
              '1 part vegetable scraps'
            ],
            'Layer ingredients, moisten, and turn every 1-2 weeks. Ready in 3-6 months.',
          ),
          _buildRecipeCard(
            context,
            'Fast Hot Compost',
            'For when you need compost quickly.',
            [
              '2 parts chopped straw or wood chips',
              '1 part chicken manure',
              '1 part green garden waste (chopped small)'
            ],
            'Mix thoroughly, ensure adequate moisture, and turn every 3 days. Can be ready in 3-4 weeks if conditions are ideal.',
          ),
          _buildRecipeCard(
            context,
            'Leaf Mold Compost',
            'Great way to use fallen leaves.',
            [
              '4 parts fallen leaves',
              '1 part grass clippings or other nitrogen source'
            ],
            'Shred leaves if possible, mix with grass, moisten, and pile up. Turn occasionally. Takes 6-12 months but creates excellent soil amendment.',
          ),
          _buildRecipeCard(
            context,
            'Vegetable Garden Booster',
            'Nutrient-rich compost for vegetable gardens.',
            [
              '2 parts straw or dried leaves',
              '1 part vegetable scraps',
              '1 part coffee grounds',
              '1/2 part crushed eggshells'
            ],
            'Layer ingredients, turn weekly. The coffee grounds accelerate heating, while eggshells add calcium. Ready in about 2-4 months.',
          ),
        ],
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
            const Text(
              'Ingredients:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            const Text(
              'Instructions:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
