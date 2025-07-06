// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(ingredientName) =>
      "Added custom ingredient: ${ingredientName}";

  static String m1(ingredientName) =>
      "Are you sure you want to delete \"${ingredientName}\"?";

  static String m2(ingredientName) => "Deleted ingredient: ${ingredientName}";

  static String m3(componentName) => "Edit Availability for ${componentName}";

  static String m4(selector) =>
      "${Intl.select(selector, {'componentMangoWaste': 'Mango waste with seeds', 'componentCashewShells': 'Cashew shells', 'componentRiceHulls': 'Rice hulls/Rice bran', 'componentRiceStraw': 'Rice straw - wet season', 'componentSugarcaneBagasse': 'Sugarcane bagasse', 'componentChickenManure': 'Dried chicken manure', 'componentCowDung': 'Cow dung', 'componentCottonStraw': 'Cotton straw', 'componentRiceHuskAsh': 'Rice Husk Ash', 'componentLime': 'Lime', 'componentCompostPlus': 'Compost +', 'componentDolomites': 'Dolomites', 'componentCornStraw': 'Corn straw', 'componentCassavaPeels': 'Cassava peels', 'componentRiceChickenLitter': 'Litter (rice bran + chicken manure)', 'componentRiceStrawCounter': 'Rice straw - counter-season', 'other': 'Unknown component'})}";

  static String m5(ingredientName) =>
      "Ingredient \"${ingredientName}\" no longer exists";

  static String m6(nutrientName, min, max) =>
      "Great! ${nutrientName} is within the optimal range (${min} - ${max})";

  static String m7(value) => "${value} (%)";

  static String m8(price, amount, unit) =>
      "Price: ${price} FCFA per ${amount} ${unit}";

  static String m9(count) => "Removed ${count} deleted ingredients from recipe";

  static String m10(ingredientName) => "Updated ingredient: ${ingredientName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aHealthyCompostPileShouldBeWarmSlightlyDampAnd":
        MessageLookupByLibrary.simpleMessage(
          "A healthy compost pile should be warm, slightly damp, and have an earthy smell. If yours doesn\'t match this description, check the troubleshooting tips above!",
        ),
    "aSimpleBalancedRecipeForGeneralGardenUse":
        MessageLookupByLibrary.simpleMessage(
          "A simple, balanced recipe for general garden use.",
        ),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addCarbonrichMaterialsDryLeavesStraw":
        MessageLookupByLibrary.simpleMessage(
          "Add carbon-rich materials (dry leaves, straw)",
        ),
    "addComponent": MessageLookupByLibrary.simpleMessage("Add Component"),
    "addCustomIngredient": MessageLookupByLibrary.simpleMessage(
      "Add Custom Ingredient",
    ),
    "addIngredient": MessageLookupByLibrary.simpleMessage("Add Ingredient"),
    "addMoreNitrogenrichMaterials": MessageLookupByLibrary.simpleMessage(
      "Add more nitrogen-rich materials",
    ),
    "addedCustomIngredient": m0,
    "aerobicCompostingProcess": MessageLookupByLibrary.simpleMessage(
      "Aerobic Composting Process",
    ),
    "allAvailableComponentsHaveBeenAdded": MessageLookupByLibrary.simpleMessage(
      "All available components have been added",
    ),
    "allComponents": MessageLookupByLibrary.simpleMessage("All Components"),
    "allIngredients": MessageLookupByLibrary.simpleMessage("All Ingredients"),
    "ammoniaSmellTooMuchNitrogen": MessageLookupByLibrary.simpleMessage(
      "Ammonia smell: Too much nitrogen",
    ),
    "april": MessageLookupByLibrary.simpleMessage("April"),
    "areYouSureDeleteIngredient": m1,
    "august": MessageLookupByLibrary.simpleMessage("August"),
    "availabilityJanToDec": MessageLookupByLibrary.simpleMessage(
      "Available: January to December",
    ),
    "availabilityMarToAug": MessageLookupByLibrary.simpleMessage(
      "Available: March to August",
    ),
    "availabilityMayToJul": MessageLookupByLibrary.simpleMessage(
      "Available: May to July",
    ),
    "availabilityOctToDec": MessageLookupByLibrary.simpleMessage(
      "Available: October to December",
    ),
    "availabilityOctToJan": MessageLookupByLibrary.simpleMessage(
      "Available: October to January",
    ),
    "availabilitySepToDec": MessageLookupByLibrary.simpleMessage(
      "Available: September to December",
    ),
    "available": MessageLookupByLibrary.simpleMessage("Available:"),
    "avoidAddingMeatDairyOilsOrPetWaste": MessageLookupByLibrary.simpleMessage(
      "Avoid adding meat, dairy, oils, or pet waste",
    ),
    "avoidAddingMeatDairyOrOils": MessageLookupByLibrary.simpleMessage(
      "Avoid adding meat, dairy, or oils",
    ),
    "badOdors": MessageLookupByLibrary.simpleMessage("Bad Odors"),
    "balanceCarbonDryBrownsAndNitrogenGreens":
        MessageLookupByLibrary.simpleMessage(
          "Balance carbon (dry browns) and nitrogen (greens).",
        ),
    "basicGardenCompost": MessageLookupByLibrary.simpleMessage(
      "Basic Garden Compost",
    ),
    "breaksDownFastdecomposingMaterialsKillsPathogensWeedSeeds":
        MessageLookupByLibrary.simpleMessage(
          "Breaks down fast-decomposing materials, kills pathogens & weed seeds.",
        ),
    "browns": MessageLookupByLibrary.simpleMessage("Browns"),
    "bucketNitrogenrichMaterialsGreens": MessageLookupByLibrary.simpleMessage(
      "1 bucket nitrogen-rich materials (greens)",
    ),
    "bucketsDryCarbonMaterialsBrowns": MessageLookupByLibrary.simpleMessage(
      "2 buckets dry carbon materials (browns)",
    ),
    "buryFoodScrapsInTheCenterOfThePile": MessageLookupByLibrary.simpleMessage(
      "Bury food scraps in the center of the pile",
    ),
    "calcium": MessageLookupByLibrary.simpleMessage("CaO"),
    "calciumPercent": MessageLookupByLibrary.simpleMessage("Calcium %"),
    "canBeStoredFor6to12MonthsKeepDryToAvoid":
        MessageLookupByLibrary.simpleMessage(
          "Can be stored for 6–12 months (keep dry to avoid nutrient loss).",
        ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "carbonNitrogenRatio": MessageLookupByLibrary.simpleMessage("C:N Ratio"),
    "cashewShells": MessageLookupByLibrary.simpleMessage("Cashew shells"),
    "checkMoistureAndAddWaterIfNeeded": MessageLookupByLibrary.simpleMessage(
      "Check moisture and add water if needed",
    ),
    "checkReadiness": MessageLookupByLibrary.simpleMessage("Check readiness"),
    "chickenManure": MessageLookupByLibrary.simpleMessage("Chicken manure"),
    "chooseASite": MessageLookupByLibrary.simpleMessage("Choose a site"),
    "chooseComponent": MessageLookupByLibrary.simpleMessage("Choose Component"),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "cn": MessageLookupByLibrary.simpleMessage("C/N"),
    "cnRatioExplained": MessageLookupByLibrary.simpleMessage(
      "C:N Ratio Explained:",
    ),
    "cnRatioOptimumCompostConditions": MessageLookupByLibrary.simpleMessage(
      "C:N Ratio & Optimum Compost Conditions",
    ),
    "coldWeatherInsulateOrWaitForWarmerConditions":
        MessageLookupByLibrary.simpleMessage(
          "Cold weather (insulate or wait for warmer conditions)",
        ),
    "commonCompostProblemsSolutions": MessageLookupByLibrary.simpleMessage(
      "Common Compost Problems & Solutions",
    ),
    "component": MessageLookupByLibrary.simpleMessage("Component"),
    "componentCashewShells": MessageLookupByLibrary.simpleMessage(
      "Cashew shells",
    ),
    "componentCassavaPeels": MessageLookupByLibrary.simpleMessage(
      "Cassava peels",
    ),
    "componentChickenManure": MessageLookupByLibrary.simpleMessage(
      "Dried chicken manure",
    ),
    "componentCompostPlus": MessageLookupByLibrary.simpleMessage("Compost +"),
    "componentCornStraw": MessageLookupByLibrary.simpleMessage("Corn straw"),
    "componentCottonStraw": MessageLookupByLibrary.simpleMessage(
      "Cotton straw",
    ),
    "componentCowDung": MessageLookupByLibrary.simpleMessage("Cow dung"),
    "componentDolomites": MessageLookupByLibrary.simpleMessage("Dolomites"),
    "componentLime": MessageLookupByLibrary.simpleMessage("Lime"),
    "componentMangoWaste": MessageLookupByLibrary.simpleMessage(
      "Mango waste with seeds",
    ),
    "componentRiceChickenLitter": MessageLookupByLibrary.simpleMessage(
      "Litter (rice bran + chicken manure)",
    ),
    "componentRiceHulls": MessageLookupByLibrary.simpleMessage(
      "Rice hulls/Rice bran",
    ),
    "componentRiceHuskAsh": MessageLookupByLibrary.simpleMessage(
      "Rice Husk Ash",
    ),
    "componentRiceStraw": MessageLookupByLibrary.simpleMessage(
      "Rice straw - wet season",
    ),
    "componentRiceStrawCounter": MessageLookupByLibrary.simpleMessage(
      "Rice straw - counter-season",
    ),
    "componentSugarcaneBagasse": MessageLookupByLibrary.simpleMessage(
      "Sugarcane bagasse",
    ),
    "components": MessageLookupByLibrary.simpleMessage("Components"),
    "compostCalculator": MessageLookupByLibrary.simpleMessage(
      "Compost Calculator",
    ),
    "compostGuidelines": MessageLookupByLibrary.simpleMessage(
      "Compost Guidelines",
    ),
    "compostRecipeBuilder": MessageLookupByLibrary.simpleMessage(
      "Compost Recipe Builder",
    ),
    "compostingHappensInFourStages": MessageLookupByLibrary.simpleMessage(
      "Composting happens in four stages:",
    ),
    "compostingTimelineProcess": MessageLookupByLibrary.simpleMessage(
      "Composting Timeline Process",
    ),
    "contactOurSupportTeam": MessageLookupByLibrary.simpleMessage(
      "Contact our support team:",
    ),
    "contentNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Content not available",
    ),
    "cooling": MessageLookupByLibrary.simpleMessage("Cooling"),
    "coolingPhaseDays25to35": MessageLookupByLibrary.simpleMessage(
      "3. Cooling Phase (Days 25-35)",
    ),
    "costPerTon": MessageLookupByLibrary.simpleMessage("Cost/Ton"),
    "costTotal": MessageLookupByLibrary.simpleMessage("Total Cost"),
    "coverFoodScrapsWithBrowns": MessageLookupByLibrary.simpleMessage(
      "Cover food scraps with browns",
    ),
    "cowDung": MessageLookupByLibrary.simpleMessage("Cow dung"),
    "currency": MessageLookupByLibrary.simpleMessage("Currency"),
    "currencyFCFA": MessageLookupByLibrary.simpleMessage("FCFA"),
    "day1": MessageLookupByLibrary.simpleMessage("Day 1"),
    "day25": MessageLookupByLibrary.simpleMessage("Day 25"),
    "day35": MessageLookupByLibrary.simpleMessage("Day 35"),
    "day5": MessageLookupByLibrary.simpleMessage("Day 5"),
    "day60": MessageLookupByLibrary.simpleMessage("Day 60+"),
    "days25to35": MessageLookupByLibrary.simpleMessage("Days 25-35"),
    "days2to5": MessageLookupByLibrary.simpleMessage("Days 2-5"),
    "days35to60": MessageLookupByLibrary.simpleMessage("Days 35-60+"),
    "days5to25": MessageLookupByLibrary.simpleMessage("Days 5-25"),
    "december": MessageLookupByLibrary.simpleMessage("December"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteCustomIngredient": MessageLookupByLibrary.simpleMessage(
      "Delete Custom Ingredient",
    ),
    "deletedIngredient": m2,
    "dryLeaves": MessageLookupByLibrary.simpleMessage("Dry leaves"),
    "dryMatter": MessageLookupByLibrary.simpleMessage("Dry Matter"),
    "dryMatterPercent": MessageLookupByLibrary.simpleMessage("Dry Matter %"),
    "editAvailability": MessageLookupByLibrary.simpleMessage(
      "Edit availability",
    ),
    "editAvailabilityFor": m3,
    "editComponent": MessageLookupByLibrary.simpleMessage("Edit Component"),
    "editCustomIngredient": MessageLookupByLibrary.simpleMessage(
      "Edit Custom Ingredient",
    ),
    "endMonth": MessageLookupByLibrary.simpleMessage("End Month"),
    "exposedFoodScraps": MessageLookupByLibrary.simpleMessage(
      "Exposed food scraps",
    ),
    "fastHotCompost": MessageLookupByLibrary.simpleMessage("Fast Hot Compost"),
    "february": MessageLookupByLibrary.simpleMessage("February"),
    "forWhenYouNeedCompostQuickly": MessageLookupByLibrary.simpleMessage(
      "For when you need compost quickly.",
    ),
    "freshPlant": MessageLookupByLibrary.simpleMessage("Fresh plant"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Get Help"),
    "getTranslation": m4,
    "greens": MessageLookupByLibrary.simpleMessage("Greens"),
    "heating": MessageLookupByLibrary.simpleMessage("Heating"),
    "heatingPhaseDays5to25": MessageLookupByLibrary.simpleMessage(
      "2. Heating Phase (Days 5-25)",
    ),
    "helpEmailSubjectInstruction": MessageLookupByLibrary.simpleMessage(
      "Please include \"Compost Calculator App - Help Request\" in your subject line.",
    ),
    "highCarbon": MessageLookupByLibrary.simpleMessage("High Carbon"),
    "highNitrogen": MessageLookupByLibrary.simpleMessage("High Nitrogen"),
    "howToMakeCompost": MessageLookupByLibrary.simpleMessage(
      "How to Make Compost",
    ),
    "idealCarbonnitrogenRatio30to1": MessageLookupByLibrary.simpleMessage(
      "Ideal Carbon:Nitrogen ratio = 30:1",
    ),
    "increasePileSize": MessageLookupByLibrary.simpleMessage(
      "Increase pile size",
    ),
    "ingredient": MessageLookupByLibrary.simpleMessage("Ingredient"),
    "ingredientName": MessageLookupByLibrary.simpleMessage("Ingredient Name"),
    "ingredientNoLongerExists": m5,
    "ingredients": MessageLookupByLibrary.simpleMessage("Ingredients"),
    "instructions": MessageLookupByLibrary.simpleMessage("Instructions"),
    "january": MessageLookupByLibrary.simpleMessage("January"),
    "july": MessageLookupByLibrary.simpleMessage("July"),
    "june": MessageLookupByLibrary.simpleMessage("June"),
    "keepItLikeADampSpongeNotTooDry": MessageLookupByLibrary.simpleMessage(
      "Keep it like a damp sponge (not too dry or soggy).",
    ),
    "keyNeedsWaterOxygenSmallsizedOrganicMatter":
        MessageLookupByLibrary.simpleMessage(
          "Key Needs: Water, oxygen, small-sized organic matter.",
        ),
    "layerIngredientsMoistenAndTurnEvery12WeeksReadyIn":
        MessageLookupByLibrary.simpleMessage(
          "Layer ingredients, moisten, and turn every 1-2 weeks. Ready in 3-6 months.",
        ),
    "layerMaterials": MessageLookupByLibrary.simpleMessage("Layer materials"),
    "magnesium": MessageLookupByLibrary.simpleMessage("MgO"),
    "magnesiumPercent": MessageLookupByLibrary.simpleMessage("Magnesium %"),
    "maintainMoisture": MessageLookupByLibrary.simpleMessage(
      "Maintain moisture",
    ),
    "march": MessageLookupByLibrary.simpleMessage("March"),
    "maturationPhaseDays35to60": MessageLookupByLibrary.simpleMessage(
      "4. Maturation Phase (Days 35-60+)",
    ),
    "maturing": MessageLookupByLibrary.simpleMessage("Maturing"),
    "may": MessageLookupByLibrary.simpleMessage("May"),
    "meatDairyOrFattyFoodsInCompost": MessageLookupByLibrary.simpleMessage(
      "Meat, dairy or fatty foods in compost",
    ),
    "microorganismsBeginBreakingDownWaste":
        MessageLookupByLibrary.simpleMessage(
          "Microorganisms begin breaking down waste.",
        ),
    "mixEvery714DaysForAeration": MessageLookupByLibrary.simpleMessage(
      "Mix every 7–14 days for aeration.",
    ),
    "mixThoroughlyEnsureAdequateMoistureAndTurnEvery3Days":
        MessageLookupByLibrary.simpleMessage(
          "Mix thoroughly, ensure adequate moisture, and turn every 3 days. Can be ready in 3-4 weeks if conditions are ideal.",
        ),
    "needAssistanceWithCompostCalculator": MessageLookupByLibrary.simpleMessage(
      "Need assistance with the Compost Calculator?",
    ),
    "nitrogen": MessageLookupByLibrary.simpleMessage("N"),
    "nitrogenPercent": MessageLookupByLibrary.simpleMessage("Nitrogen %"),
    "noComponentsAddedYetClickTheButtonBelowToAdd":
        MessageLookupByLibrary.simpleMessage(
          "No components added yet. Click the button below to add components to your compost recipe.",
        ),
    "notEnoughNitrogenAddGreens": MessageLookupByLibrary.simpleMessage(
      "Not enough nitrogen (add \'greens\')",
    ),
    "november": MessageLookupByLibrary.simpleMessage("November"),
    "nutrientAnalysis": MessageLookupByLibrary.simpleMessage(
      "Nutrient Analysis",
    ),
    "nutrientContentPercent": MessageLookupByLibrary.simpleMessage(
      "Nutrient Content (%)",
    ),
    "nutrientInOptimalRange": m6,
    "october": MessageLookupByLibrary.simpleMessage("October"),
    "optimumMoisture": MessageLookupByLibrary.simpleMessage("Optimum Moisture"),
    "organicCarbon": MessageLookupByLibrary.simpleMessage("C Org"),
    "organicCarbonPercent": MessageLookupByLibrary.simpleMessage(
      "Organic Carbon %",
    ),
    "organismsChangeAsConditionsShift": MessageLookupByLibrary.simpleMessage(
      "Organisms change as conditions shift.",
    ),
    "otherMaterialsMeatDairyEtc": MessageLookupByLibrary.simpleMessage(
      "\'Other\' materials (meat, dairy, etc.)",
    ),
    "oxygenRequirements": MessageLookupByLibrary.simpleMessage(
      "Oxygen Requirements",
    ),
    "partChickenManure": MessageLookupByLibrary.simpleMessage(
      "1 part chicken manure",
    ),
    "partFreshGrassClippings": MessageLookupByLibrary.simpleMessage(
      "1 part fresh grass clippings",
    ),
    "partGreenGardenWasteChoppedSmall": MessageLookupByLibrary.simpleMessage(
      "1 part green garden waste (chopped small)",
    ),
    "partVegetableScraps": MessageLookupByLibrary.simpleMessage(
      "1 part vegetable scraps",
    ),
    "partsChoppedStrawOrWoodChips": MessageLookupByLibrary.simpleMessage(
      "2 parts chopped straw or wood chips",
    ),
    "partsDryLeaves": MessageLookupByLibrary.simpleMessage(
      "3 parts dry leaves",
    ),
    "percentage": m7,
    "pestsInTheCompost": MessageLookupByLibrary.simpleMessage(
      "Pests in the Compost",
    ),
    "phosphorus": MessageLookupByLibrary.simpleMessage("P₂O₅"),
    "phosphorusPercent": MessageLookupByLibrary.simpleMessage("Phosphorus %"),
    "pileIsFinishedComposting": MessageLookupByLibrary.simpleMessage(
      "Pile is finished composting",
    ),
    "pileIsTooWetdry": MessageLookupByLibrary.simpleMessage(
      "Pile Is Too Wet/Dry",
    ),
    "pileIsntHeatingUp": MessageLookupByLibrary.simpleMessage(
      "Pile Isn\'t Heating Up",
    ),
    "pileNotHotEnough": MessageLookupByLibrary.simpleMessage(
      "Pile not hot enough",
    ),
    "pileTooSmallShouldBeAtLeast3x3x3Feet":
        MessageLookupByLibrary.simpleMessage(
          "Pile too small (should be at least 3×3×3 feet)",
        ),
    "pleaseEnterIngredientName": MessageLookupByLibrary.simpleMessage(
      "Please enter an ingredient name",
    ),
    "pleaseEnterValidWeight": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid weight",
    ),
    "pleaseFillAllFields": MessageLookupByLibrary.simpleMessage(
      "Please fill all fields",
    ),
    "possibleCauses": MessageLookupByLibrary.simpleMessage("Possible Causes:"),
    "potassium": MessageLookupByLibrary.simpleMessage("K₂O"),
    "potassiumPercent": MessageLookupByLibrary.simpleMessage("Potassium %"),
    "price": m8,
    "pricePageTitle": MessageLookupByLibrary.simpleMessage("Ingredient Prices"),
    "pricePerTonCFA": MessageLookupByLibrary.simpleMessage(
      "Price per Ton (CFA)",
    ),
    "prices": MessageLookupByLibrary.simpleMessage("Prices"),
    "quickCheck": MessageLookupByLibrary.simpleMessage("Quick Check"),
    "readyWhenDarkEarthySmellNoHeatInTheCenter":
        MessageLookupByLibrary.simpleMessage(
          "Ready when: Dark, earthy smell, no heat in the center.",
        ),
    "recipeBuilder": MessageLookupByLibrary.simpleMessage("Recipe Builder"),
    "recipeQualityGuide": MessageLookupByLibrary.simpleMessage(
      "Recipe Quality Guide",
    ),
    "recipeQualityInfo": MessageLookupByLibrary.simpleMessage(
      "Green checkmark: Nutrient level within recommended range\nRed up arrow: Nutrient level below recommended range\nOrange down arrow: Nutrient level above recommended range\n\nRecommended ranges are based on municipal compost standards.",
    ),
    "regularTurningEvery12WeeksEnsuresProperOxygenFlowFor":
        MessageLookupByLibrary.simpleMessage(
          "Regular turning (every 1-2 weeks) ensures proper oxygen flow for aerobic decomposition.",
        ),
    "removedDeletedIngredientSingle": MessageLookupByLibrary.simpleMessage(
      "Removed 1 deleted ingredient from recipe",
    ),
    "removedDeletedIngredientsMultiple": m9,
    "riceHusks": MessageLookupByLibrary.simpleMessage("Rice husks"),
    "rottenEggSmellAnaerobicConditionsNotEnoughOxygen":
        MessageLookupByLibrary.simpleMessage(
          "Rotten egg smell: Anaerobic conditions (not enough oxygen)",
        ),
    "sampleCompostRecipes": MessageLookupByLibrary.simpleMessage(
      "Sample Compost Recipes",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "september": MessageLookupByLibrary.simpleMessage("September"),
    "simpleRule": MessageLookupByLibrary.simpleMessage("Simple rule:"),
    "slowerDecompositionFungiBreakDownTougherMaterialsStrawWood":
        MessageLookupByLibrary.simpleMessage(
          "Slower decomposition, fungi break down tougher materials (straw, wood).",
        ),
    "soilOrganismsReturnNutrientsStabilizeHumusForms":
        MessageLookupByLibrary.simpleMessage(
          "Soil organisms return, nutrients stabilize, humus forms.",
        ),
    "solutions": MessageLookupByLibrary.simpleMessage("Solutions:"),
    "startMonth": MessageLookupByLibrary.simpleMessage("Start Month"),
    "startup": MessageLookupByLibrary.simpleMessage("Start-up"),
    "startupDays2to5": MessageLookupByLibrary.simpleMessage(
      "1. Start-up (Days 2-5)",
    ),
    "temperature20to40c": MessageLookupByLibrary.simpleMessage(
      "Temperature: 20–40°C",
    ),
    "temperature20to45c": MessageLookupByLibrary.simpleMessage(
      "Temperature: 20–45°C",
    ),
    "temperature25to45c": MessageLookupByLibrary.simpleMessage(
      "Temperature: 25–45°C",
    ),
    "temperature45to65c": MessageLookupByLibrary.simpleMessage(
      "Temperature: 45–65°C",
    ),
    "thePileShrinksAsMaterialDecomposes": MessageLookupByLibrary.simpleMessage(
      "The pile shrinks as material decomposes.",
    ),
    "thisAppIsDesignedToHelpYouCreateAndManage":
        MessageLookupByLibrary.simpleMessage(
          "This app is designed to help you create and manage open-pile aerobic composting. Use the tools below to learn about composting, explore recipes, or create your own!",
        ),
    "to": MessageLookupByLibrary.simpleMessage("to"),
    "tooDryAddFreshGreenMaterials": MessageLookupByLibrary.simpleMessage(
      "Too dry: Add fresh \'green\' materials",
    ),
    "tooDryAddWater": MessageLookupByLibrary.simpleMessage(
      "Too dry (add water)",
    ),
    "tooDryAddWaterWhileTurningThePile": MessageLookupByLibrary.simpleMessage(
      "Too dry: Add water while turning the pile",
    ),
    "tooDryNotEnoughWaterTooMuchSunExposure":
        MessageLookupByLibrary.simpleMessage(
          "Too dry: Not enough water, too much sun exposure",
        ),
    "tooMuchCarbonDecompositionSlowsDown": MessageLookupByLibrary.simpleMessage(
      "Too much carbon? Decomposition slows down.",
    ),
    "tooMuchNitrogenSmellySoggyPile": MessageLookupByLibrary.simpleMessage(
      "Too much nitrogen? Smelly, soggy pile.",
    ),
    "tooWetAddDryCarbonrichMaterials": MessageLookupByLibrary.simpleMessage(
      "Too wet: Add dry, carbon-rich materials",
    ),
    "tooWetCoverDuringHeavyRains": MessageLookupByLibrary.simpleMessage(
      "Too wet: Cover during heavy rains",
    ),
    "tooWetSoggyMaterialsPoorDrainage": MessageLookupByLibrary.simpleMessage(
      "Too wet: Soggy materials, poor drainage",
    ),
    "tooWetTurnThePileToHelpItDryOut": MessageLookupByLibrary.simpleMessage(
      "Too wet: Turn the pile to help it dry out",
    ),
    "totalCostFCFA": MessageLookupByLibrary.simpleMessage("Total Cost (FCFA)"),
    "totalWeightKg": MessageLookupByLibrary.simpleMessage("Total Weight (kg)"),
    "troubleshootingCompostProblems": MessageLookupByLibrary.simpleMessage(
      "Troubleshooting Compost Problems",
    ),
    "turnPileRegularlyToMaintainHeat": MessageLookupByLibrary.simpleMessage(
      "Turn pile regularly to maintain heat",
    ),
    "turnThePileRegularly": MessageLookupByLibrary.simpleMessage(
      "Turn the pile regularly",
    ),
    "turnThePileToAddOxygen": MessageLookupByLibrary.simpleMessage(
      "Turn the pile to add oxygen",
    ),
    "turnThePileToIncreaseOxygen": MessageLookupByLibrary.simpleMessage(
      "Turn the pile to increase oxygen",
    ),
    "unitKgs": MessageLookupByLibrary.simpleMessage("kgs"),
    "unitTons": MessageLookupByLibrary.simpleMessage("tons"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "updatedIngredient": m10,
    "useARodentresistantBinIfNecessary": MessageLookupByLibrary.simpleMessage(
      "Use a rodent-resistant bin if necessary",
    ),
    "visualTip": MessageLookupByLibrary.simpleMessage("Visual Tip"),
    "water": MessageLookupByLibrary.simpleMessage("Water"),
    "weight": MessageLookupByLibrary.simpleMessage("Weight (kg)"),
    "welcomeToCompostCalculator": MessageLookupByLibrary.simpleMessage(
      "Welcome to Compost Calculator",
    ),
    "welldrainedShadyNearAWaterSource": MessageLookupByLibrary.simpleMessage(
      "Well-drained, shady, near a water source.",
    ),
    "whenDarkCrumblyAndSmellsEarthyItsDone":
        MessageLookupByLibrary.simpleMessage(
          "When dark, crumbly, and smells earthy, it\'s done!",
        ),
    "yourCompostPileShouldBeLargeEnoughToMaintainHeat":
        MessageLookupByLibrary.simpleMessage(
          "Your compost pile should be large enough to maintain heat (at least 3×3×3 feet), but small enough to easily turn and manage.",
        ),
    "yourCompostShouldHaveTheMoistureLevelOfAWrungout":
        MessageLookupByLibrary.simpleMessage(
          "Your compost should have the moisture level of a wrung-out sponge - damp but not soggy.",
        ),
  };
}
