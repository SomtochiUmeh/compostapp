import 'package:flutter/material.dart';
import '../generated/l10n.dart';

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
    if (title == S.current.aerobicCompostingProcess) {
      return _buildAerobicCompostingContent();
    } else if (title == S.current.howToMakeCompost) {
      return _buildHowToMakeCompostContent();
    } else if (title == S.current.cnRatioOptimumCompostConditions) {
      return _buildCnRatioContent();
    } else if (title == S.current.troubleshootingCompostProblems) {
      return _buildTroubleshootingContent();
    } else {
      return Text(S.current.contentNotAvailable);
    }
  }

  Widget _buildAerobicCompostingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.compostingHappensInFourStages,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  _buildDayLabel(S.current.day1),
                  _buildDayLabel(S.current.day5),
                  _buildDayLabel(S.current.day25),
                  _buildDayLabel(S.current.day35),
                  _buildDayLabel(S.current.day60),
                ],
              ),
            ),
            // Phase markers
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimelineMarker(S.current.startup, Icons.play_arrow,
                    Colors.green.shade300, S.current.days2to5),
                _buildTimelineMarker(S.current.heating, Icons.whatshot,
                    Colors.orange.shade300, S.current.days5to25),
                _buildTimelineMarker(S.current.cooling, Icons.ac_unit,
                    Colors.blue.shade300, S.current.days25to35),
                _buildTimelineMarker(S.current.maturing, Icons.eco,
                    Colors.brown.shade300, S.current.days35to60),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            S.current.compostingTimelineProcess,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const Divider(),
        const SizedBox(height: 16),
        _buildCompostStage(
          S.current.startupDays2to5,
          Icons.play_arrow,
          [
            S.current.microorganismsBeginBreakingDownWaste,
            S.current.temperature20to45c,
            S.current.keyNeedsWaterOxygenSmallsizedOrganicMatter,
          ],
          Colors.green.shade300,
        ),
        _buildCompostStage(
          S.current.heatingPhaseDays5to25,
          Icons.whatshot,
          [
            S.current.temperature45to65c,
            S.current.breaksDownFastdecomposingMaterialsKillsPathogensWeedSeeds,
            S.current.organismsChangeAsConditionsShift,
          ],
          Colors.orange.shade300,
        ),
        _buildCompostStage(
          S.current.coolingPhaseDays25to35,
          Icons.ac_unit,
          [
            S.current.temperature25to45c,
            S.current
                .slowerDecompositionFungiBreakDownTougherMaterialsStrawWood,
            S.current.thePileShrinksAsMaterialDecomposes,
          ],
          Colors.blue.shade300,
        ),
        _buildCompostStage(
          S.current.maturationPhaseDays35to60,
          Icons.eco,
          [
            S.current.temperature20to40c,
            S.current.soilOrganismsReturnNutrientsStabilizeHumusForms,
            S.current.readyWhenDarkEarthySmellNoHeatInTheCenter,
            S.current.canBeStoredFor6to12MonthsKeepDryToAvoid,
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
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.visualTip,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.current
                          .yourCompostPileShouldBeLargeEnoughToMaintainHeat,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Divider(),
        const SizedBox(height: 16),
        _buildCompostStep(
          "1",
          S.current.chooseASite,
          S.current.welldrainedShadyNearAWaterSource,
          Icons.place,
          Colors.green,
        ),
        _buildCompostStep(
          "2",
          S.current.layerMaterials,
          S.current.balanceCarbonDryBrownsAndNitrogenGreens,
          Icons.layers,
          Colors.brown,
        ),
        _buildCompostStep(
          "3",
          S.current.maintainMoisture,
          S.current.keepItLikeADampSpongeNotTooDry,
          Icons.water_drop,
          Colors.blue,
        ),
        _buildCompostStep(
          "4",
          S.current.turnThePileRegularly,
          S.current.mixEvery714DaysForAeration,
          Icons.rotate_left,
          Colors.orange,
        ),
        _buildCompostStep(
          "5",
          S.current.checkReadiness,
          S.current.whenDarkCrumblyAndSmellsEarthyItsDone,
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
                Text(
                  S.current.cnRatioExplained,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _buildCNItem(S.current.idealCarbonnitrogenRatio30to1),
                _buildCNItem(S.current.tooMuchCarbonDecompositionSlowsDown),
                _buildCNItem(S.current.tooMuchNitrogenSmellySoggyPile),
                const SizedBox(height: 8),
                Text(
                  S.current.simpleRule,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCNItem(S.current.bucketNitrogenrichMaterialsGreens),
                      _buildCNItem(S.current.bucketsDryCarbonMaterialsBrowns),
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
                S.current.highCarbon,
                S.current.browns,
                [
                  S.current.cashewShells,
                  S.current.riceHusks,
                  S.current.dryLeaves
                ],
                Colors.brown.shade700,
                Colors.brown.shade100,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMaterialCard(
                S.current.highNitrogen,
                S.current.greens,
                [
                  S.current.chickenManure,
                  S.current.cowDung,
                  S.current.freshPlant
                ],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.water_drop, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      S.current.optimumMoisture,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  S.current.yourCompostShouldHaveTheMoistureLevelOfAWrungout,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.air, color: Colors.lightBlue),
                    const SizedBox(width: 8),
                    Text(
                      S.current.oxygenRequirements,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  S.current
                      .regularTurningEvery12WeeksEnsuresProperOxygenFlowFor,
                  style: const TextStyle(fontSize: 16),
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
        Text(
          S.current.commonCompostProblemsSolutions,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.quickCheck,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      S.current.aHealthyCompostPileShouldBeWarmSlightlyDampAnd,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildProblemSolutionCard(
          S.current.pileIsntHeatingUp,
          Icons.whatshot,
          Colors.orange,
          [
            S.current.pileTooSmallShouldBeAtLeast3x3x3Feet,
            S.current.tooDryAddWater,
            S.current.notEnoughNitrogenAddGreens,
            S.current.coldWeatherInsulateOrWaitForWarmerConditions,
            S.current.pileIsFinishedComposting,
          ],
          [
            S.current.addMoreNitrogenrichMaterials,
            S.current.checkMoistureAndAddWaterIfNeeded,
            S.current.turnThePileToIncreaseOxygen,
            S.current.increasePileSize,
          ],
        ),
        _buildProblemSolutionCard(
          S.current.badOdors,
          Icons.sentiment_very_dissatisfied,
          Colors.red,
          [
            S.current.ammoniaSmellTooMuchNitrogen,
            S.current.rottenEggSmellAnaerobicConditionsNotEnoughOxygen,
            S.current.otherMaterialsMeatDairyEtc,
          ],
          [
            S.current.addCarbonrichMaterialsDryLeavesStraw,
            S.current.turnThePileToAddOxygen,
            S.current.coverFoodScrapsWithBrowns,
            S.current.avoidAddingMeatDairyOrOils,
          ],
        ),
        _buildProblemSolutionCard(
          S.current.pestsInTheCompost,
          Icons.bug_report,
          Colors.purple,
          [
            S.current.exposedFoodScraps,
            S.current.meatDairyOrFattyFoodsInCompost,
            S.current.pileNotHotEnough,
          ],
          [
            S.current.buryFoodScrapsInTheCenterOfThePile,
            S.current.avoidAddingMeatDairyOilsOrPetWaste,
            S.current.turnPileRegularlyToMaintainHeat,
            S.current.useARodentresistantBinIfNecessary,
          ],
        ),
        _buildProblemSolutionCard(
          S.current.pileIsTooWetdry,
          Icons.water_drop,
          Colors.blue,
          [
            S.current.tooWetSoggyMaterialsPoorDrainage,
            S.current.tooDryNotEnoughWaterTooMuchSunExposure,
          ],
          [
            S.current.tooWetAddDryCarbonrichMaterials,
            S.current.tooWetTurnThePileToHelpItDryOut,
            S.current.tooWetCoverDuringHeavyRains,
            S.current.tooDryAddWaterWhileTurningThePile,
            S.current.tooDryAddFreshGreenMaterials,
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
                Text(
                  S.current.solutions,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
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
