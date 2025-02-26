import 'package:flutter/material.dart';

class GuidelineDetailPage extends StatelessWidget {
  final String title;

  const GuidelineDetailPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade200,
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: _getGuidelineContent(title),
      ),
    );
  }

  Widget _getGuidelineContent(String title) {
    // Return different content based on the title
    switch (title) {
      case 'Aerobic Composting Process':
        return _buildAerobicCompostingContent();
      case 'How to Make Compost (5 Easy Steps)':
        return _buildHowToMakeCompostContent();
      case 'C:N Ratio & Optimum Compost Conditions':
        return _buildCnRatioContent();
      case 'Troubleshooting Compost Problems':
        return _buildTroubleshootingContent();
      default:
        return const Text('Content not available');
    }
  }

  Widget _buildAerobicCompostingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Composting happens in four stages:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Stack(
          alignment: Alignment.center,
          children: [
            // Timeline line
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            // Day labels above timeline
            Positioned(
              top: -25,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDayLabel("Day 1"),
                  _buildDayLabel("Day 5"),
                  _buildDayLabel("Day 25"),
                  _buildDayLabel("Day 35"),
                  _buildDayLabel("Day 60+"),
                ],
              ),
            ),
            // Phase markers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimelineMarker("Start-up", Icons.play_arrow,
                    Colors.green.shade300, "Days 2-5"),
                _buildTimelineMarker("Heating", Icons.whatshot,
                    Colors.orange.shade300, "Days 5-25"),
                _buildTimelineMarker("Cooling", Icons.ac_unit,
                    Colors.blue.shade300, "Days 25-35"),
                _buildTimelineMarker("Maturing", Icons.eco,
                    Colors.brown.shade300, "Days 35-60+"),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            "Composting Timeline Process",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        const SizedBox(height: 16),
        _buildCompostStage(
          "1. Start-up (Days 2-5)",
          Icons.play_arrow,
          [
            "Microorganisms begin breaking down waste.",
            "Temperature: 20–45°C",
            "Key Needs: Water, oxygen, small-sized organic matter.",
          ],
          Colors.green.shade300,
        ),
        _buildCompostStage(
          "2. Heating Phase (Days 5-25)",
          Icons.whatshot,
          [
            "Temperature: 45–65°C",
            "Breaks down fast-decomposing materials, kills pathogens & weed seeds.",
            "Organisms change as conditions shift.",
          ],
          Colors.orange.shade300,
        ),
        _buildCompostStage(
          "3. Cooling Phase (Days 25-35)",
          Icons.ac_unit,
          [
            "Temperature: 25–45°C",
            "Slower decomposition, fungi break down tougher materials (straw, wood).",
            "The pile shrinks as material decomposes.",
          ],
          Colors.blue.shade300,
        ),
        _buildCompostStage(
          "4. Maturation Phase (Days 35-60+)",
          Icons.eco,
          [
            "Temperature: 20–40°C",
            "Soil organisms return, nutrients stabilize, humus forms.",
            "Ready when: Dark, earthy smell, no heat in the center.",
            "Can be stored for 6–12 months (keep dry to avoid nutrient loss).",
          ],
          Colors.brown.shade300,
        ),
      ],
    );
  }

  Widget _buildTimelineMarker(
      String label, IconData icon, Color color, String days) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        Text(
          days,
          style: const TextStyle(fontSize: 11, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _buildDayLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.brown.shade50,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.brown.shade200, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 10,
            color: Colors.brown.shade800,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCompostStage(
      String title, IconData icon, List<String> points, Color color) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: color, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...points.map((point) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("• ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Expanded(
                        child:
                            Text(point, style: const TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildHowToMakeCompostContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.brown.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.brown.shade200),
          ),
          child: const Column(
            children: [
              Text(
                "Visual Tip",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Your compost pile should be large enough to maintain heat (at least 3×3×3 feet), but small enough to easily turn and manage.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        _buildCompostStep(
          "1",
          "Choose a site",
          "Well-drained, shady, near a water source.",
          Icons.place,
          Colors.green,
        ),
        _buildCompostStep(
          "2",
          "Layer materials",
          "Balance carbon (dry browns) and nitrogen (greens).",
          Icons.layers,
          Colors.brown,
        ),
        _buildCompostStep(
          "3",
          "Maintain moisture",
          "Keep it like a damp sponge (not too dry or soggy).",
          Icons.water_drop,
          Colors.blue,
        ),
        _buildCompostStep(
          "4",
          "Turn the pile regularly",
          "Mix every 7–14 days for aeration.",
          Icons.rotate_left,
          Colors.orange,
        ),
        _buildCompostStep(
          "5",
          "Check readiness",
          "When dark, crumbly, and smells earthy, it's done!",
          Icons.check_circle,
          Colors.teal,
        ),
      ],
    );
  }

  Widget _buildCompostStep(String number, String title, String description,
      IconData icon, Color color) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  number,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: color),
                      const SizedBox(width: 8),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCnRatioContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "C:N Ratio Explained:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildCNItem("Ideal Carbon:Nitrogen ratio = 30:1"),
                _buildCNItem("Too much carbon? Decomposition slows down."),
                _buildCNItem("Too much nitrogen? Smelly, soggy pile."),
                const SizedBox(height: 8),
                const Text(
                  "Simple rule:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCNItem("1 bucket nitrogen-rich materials (greens)"),
                      _buildCNItem("2 buckets dry carbon materials (browns)"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildMaterialCard(
                "High Carbon",
                "Browns",
                ["Cashew shells", "Rice husks", "Dry leaves"],
                Colors.brown.shade700,
                Colors.brown.shade100,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMaterialCard(
                "High Nitrogen",
                "Greens",
                ["Chicken manure", "Cow dung", "Fresh plant"],
                Colors.green.shade700,
                Colors.green.shade100,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.water_drop, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      "Optimum Moisture",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  "Your compost should have the moisture level of a wrung-out sponge - damp but not soggy.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Icon(Icons.air, color: Colors.lightBlue),
                    SizedBox(width: 8),
                    Text(
                      "Oxygen Requirements",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  "Regular turning (every 1-2 weeks) ensures proper oxygen flow for aerobic decomposition.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialCard(String title, String subtitle, List<String> items,
      Color headerColor, Color bgColor) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor,
            ),
            child: Text(
              subtitle,
              style: TextStyle(
                color: headerColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.circle, size: 8, color: headerColor),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 16),
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCNItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildTroubleshootingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Common Compost Problems & Solutions",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 245, 232, 191),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade800, size: 40),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Quick Check",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "A healthy compost pile should be warm, slightly damp, and have an earthy smell. If yours doesn't match this description, check the troubleshooting tips above!",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildProblemSolutionCard(
          "Pile Isn't Heating Up",
          Icons.whatshot,
          Colors.orange,
          [
            "Pile too small (should be at least 3×3×3 feet)",
            "Too dry (add water)",
            "Not enough nitrogen (add 'greens')",
            "Cold weather (insulate or wait for warmer conditions)",
            "Pile is finished composting",
          ],
          [
            "Add more nitrogen-rich materials",
            "Check moisture and add water if needed",
            "Turn the pile to increase oxygen",
            "Increase pile size",
          ],
        ),
        _buildProblemSolutionCard(
          "Bad Odors",
          Icons.sentiment_very_dissatisfied,
          Colors.red,
          [
            "Ammonia smell: Too much nitrogen",
            "Rotten egg smell: Anaerobic conditions (not enough oxygen)",
            "'Other' materials (meat, dairy, etc.)",
          ],
          [
            "Add carbon-rich materials (dry leaves, straw)",
            "Turn the pile to add oxygen",
            "Cover food scraps with browns",
            "Avoid adding meat, dairy, or oils",
          ],
        ),
        _buildProblemSolutionCard(
          "Pests in the Compost",
          Icons.bug_report,
          Colors.purple,
          [
            "Exposed food scraps",
            "Meat, dairy or fatty foods in compost",
            "Pile not hot enough",
          ],
          [
            "Bury food scraps in the center of the pile",
            "Avoid adding meat, dairy, oils, or pet waste",
            "Turn pile regularly to maintain heat",
            "Use a rodent-resistant bin if necessary",
          ],
        ),
        _buildProblemSolutionCard(
          "Pile Is Too Wet/Dry",
          Icons.water_drop,
          Colors.blue,
          [
            "Too wet: Soggy materials, poor drainage",
            "Too dry: Not enough water, too much sun exposure",
          ],
          [
            "Too wet: Add dry, carbon-rich materials",
            "Too wet: Turn the pile to help it dry out",
            "Too wet: Cover during heavy rains",
            "Too dry: Add water while turning the pile",
            "Too dry: Add fresh 'green' materials",
          ],
        ),
      ],
    );
  }

  Widget _buildProblemSolutionCard(String title, IconData icon, Color color,
      List<String> problems, List<String> solutions) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Possible Causes:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...problems.map((problem) => Padding(
                      padding: const EdgeInsets.only(bottom: 8, left: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("• ", style: TextStyle(fontSize: 16)),
                          Expanded(
                            child: Text(problem,
                                style: const TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 16),
                const Text(
                  "Solutions:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...solutions.map((solution) => Padding(
                      padding: const EdgeInsets.only(bottom: 8, left: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.check_circle,
                              size: 16, color: Colors.green),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(solution,
                                style: const TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
