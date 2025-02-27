// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Recipe Builder`
  String get recipeBuilder {
    return Intl.message(
      'Recipe Builder',
      name: 'recipeBuilder',
      desc: 'Recipe Builder Navbar label',
      args: [],
    );
  }

  /// `Prices`
  String get prices {
    return Intl.message(
      'Prices',
      name: 'prices',
      desc: 'Prices Navbar label',
      args: [],
    );
  }

  /// `All available components have been added`
  String get allAvailableComponentsHaveBeenAdded {
    return Intl.message(
      'All available components have been added',
      name: 'allAvailableComponentsHaveBeenAdded',
      desc: 'Message shown when no more components can be added to the recipe',
      args: [],
    );
  }

  /// `Compost Recipe Builder`
  String get compostRecipeBuilder {
    return Intl.message(
      'Compost Recipe Builder',
      name: 'compostRecipeBuilder',
      desc: 'Main title of the compost recipe builder page',
      args: [],
    );
  }

  /// `Recipe Quality Guide`
  String get recipeQualityGuide {
    return Intl.message(
      'Recipe Quality Guide',
      name: 'recipeQualityGuide',
      desc: 'Title for the recipe quality information dialog',
      args: [],
    );
  }

  /// `Green checkmark: Nutrient level within recommended range\nRed up arrow: Nutrient level below recommended range\nOrange down arrow: Nutrient level above recommended range\n\nRecommended ranges are based on municipal compost standards.`
  String get recipeQualityInfo {
    return Intl.message(
      'Green checkmark: Nutrient level within recommended range\nRed up arrow: Nutrient level below recommended range\nOrange down arrow: Nutrient level above recommended range\n\nRecommended ranges are based on municipal compost standards.',
      name: 'recipeQualityInfo',
      desc:
          'Detailed explanation of the nutrient level indicators in the recipe quality guide',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: 'Button label for closing dialogs or screens',
      args: [],
    );
  }

  /// `Components`
  String get components {
    return Intl.message(
      'Components',
      name: 'components',
      desc: 'Section header for the list of compost components',
      args: [],
    );
  }

  /// `No components added yet. Click the button below to add components to your compost recipe.`
  String get noComponentsAddedYetClickTheButtonBelowToAdd {
    return Intl.message(
      'No components added yet. Click the button below to add components to your compost recipe.',
      name: 'noComponentsAddedYetClickTheButtonBelowToAdd',
      desc: 'Message shown when the recipe has no components',
      args: [],
    );
  }

  /// `Add Component`
  String get addComponent {
    return Intl.message(
      'Add Component',
      name: 'addComponent',
      desc: 'Button label for adding a new component to the recipe',
      args: [],
    );
  }

  /// `Nutrient Analysis`
  String get nutrientAnalysis {
    return Intl.message(
      'Nutrient Analysis',
      name: 'nutrientAnalysis',
      desc: 'Section header for the nutrient analysis table',
      args: [],
    );
  }

  /// `Edit Component`
  String get editComponent {
    return Intl.message(
      'Edit Component',
      name: 'editComponent',
      desc: 'Title for the dialog when editing an existing component',
      args: [],
    );
  }

  /// `Choose Component`
  String get chooseComponent {
    return Intl.message(
      'Choose Component',
      name: 'chooseComponent',
      desc: 'Label for the component selection dropdown',
      args: [],
    );
  }

  /// `Weight (kg)`
  String get weight {
    return Intl.message(
      'Weight (kg)',
      name: 'weight',
      desc: 'Label for the weight input field',
      args: [],
    );
  }

  /// `kgs`
  String get unitKgs {
    return Intl.message('kgs', name: 'unitKgs', desc: 'Unit kgs', args: []);
  }

  /// `tons`
  String get unitTons {
    return Intl.message('tons', name: 'unitTons', desc: 'Unit tons', args: []);
  }

  /// `Price: {price} FCFA per {amount} {unit}`
  String price(int price, double amount, String unit) {
    return Intl.message(
      'Price: $price FCFA per $amount $unit',
      name: 'price',
      desc: 'Price information display format',
      args: [price, amount, unit],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: 'Label for cancel button',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: 'Label for update button when editing a component',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: 'Label for add button when adding a new component',
      args: [],
    );
  }

  /// `Please enter a valid weight`
  String get pleaseEnterValidWeight {
    return Intl.message(
      'Please enter a valid weight',
      name: 'pleaseEnterValidWeight',
      desc: 'Error message when weight input is invalid',
      args: [],
    );
  }

  /// `Please fill all fields`
  String get pleaseFillAllFields {
    return Intl.message(
      'Please fill all fields',
      name: 'pleaseFillAllFields',
      desc: 'Error message when required fields are empty',
      args: [],
    );
  }

  /// `Component`
  String get component {
    return Intl.message(
      'Component',
      name: 'component',
      desc: 'Single component label for table header',
      args: [],
    );
  }

  /// `Cost (FCFA)`
  String get costFCFA {
    return Intl.message(
      'Cost (FCFA)',
      name: 'costFCFA',
      desc: 'Column header for cost in FCFA currency',
      args: [],
    );
  }

  /// `{value} (%)`
  String percentage(String value) {
    return Intl.message(
      '$value (%)',
      name: 'percentage',
      desc: 'Format for percentage values',
      args: [value],
    );
  }

  /// `C Org`
  String get organicCarbon {
    return Intl.message(
      'C Org',
      name: 'organicCarbon',
      desc: 'Nutrient name for organic carbon (lowercase)',
      args: [],
    );
  }

  /// `N`
  String get nitrogen {
    return Intl.message(
      'N',
      name: 'nitrogen',
      desc: 'Nutrient name for nitrogen (lowercase)',
      args: [],
    );
  }

  /// `P₂O₅`
  String get phosphorus {
    return Intl.message(
      'P₂O₅',
      name: 'phosphorus',
      desc: 'Nutrient name for phosphorus (lowercase)',
      args: [],
    );
  }

  /// `K₂O`
  String get potassium {
    return Intl.message(
      'K₂O',
      name: 'potassium',
      desc: 'Nutrient name for potassium (lowercase)',
      args: [],
    );
  }

  /// `CaO`
  String get calcium {
    return Intl.message(
      'CaO',
      name: 'calcium',
      desc: 'Nutrient name for calcium (lowercase)',
      args: [],
    );
  }

  /// `MgO`
  String get magnesium {
    return Intl.message(
      'MgO',
      name: 'magnesium',
      desc: 'Nutrient name for magnesium (lowercase)',
      args: [],
    );
  }

  /// `Dry Matter`
  String get dryMatter {
    return Intl.message(
      'Dry Matter',
      name: 'dryMatter',
      desc: 'Nutrient name for dry matter content',
      args: [],
    );
  }

  /// `Total Weight (kg)`
  String get totalWeightKg {
    return Intl.message(
      'Total Weight (kg)',
      name: 'totalWeightKg',
      desc: 'Column header for total weight in kilograms',
      args: [],
    );
  }

  /// `Total Cost (FCFA)`
  String get totalCostFCFA {
    return Intl.message(
      'Total Cost (FCFA)',
      name: 'totalCostFCFA',
      desc: 'Column header for total cost in FCFA currency',
      args: [],
    );
  }

  /// `Mango waste with seeds`
  String get componentMangoWaste {
    return Intl.message(
      'Mango waste with seeds',
      name: 'componentMangoWaste',
      desc: 'Name of mango waste component',
      args: [],
    );
  }

  /// `Cashew shells`
  String get componentCashewShells {
    return Intl.message(
      'Cashew shells',
      name: 'componentCashewShells',
      desc: 'Name of cashew shells component',
      args: [],
    );
  }

  /// `Rice hulls/Rice bran`
  String get componentRiceHulls {
    return Intl.message(
      'Rice hulls/Rice bran',
      name: 'componentRiceHulls',
      desc: 'Name of rice hulls/bran component',
      args: [],
    );
  }

  /// `Rice straw - wet season`
  String get componentRiceStraw {
    return Intl.message(
      'Rice straw - wet season',
      name: 'componentRiceStraw',
      desc: 'Name of rice straw component',
      args: [],
    );
  }

  /// `Sugarcane bagasse`
  String get componentSugarcaneBagasse {
    return Intl.message(
      'Sugarcane bagasse',
      name: 'componentSugarcaneBagasse',
      desc: 'Name of sugarcane bagasse component',
      args: [],
    );
  }

  /// `Dried chicken manure`
  String get componentChickenManure {
    return Intl.message(
      'Dried chicken manure',
      name: 'componentChickenManure',
      desc: 'Name of dried chicken manure component',
      args: [],
    );
  }

  /// `Cow dung`
  String get componentCowDung {
    return Intl.message(
      'Cow dung',
      name: 'componentCowDung',
      desc: 'Name of cow dung component',
      args: [],
    );
  }

  /// `Cotton straw`
  String get componentCottonStraw {
    return Intl.message(
      'Cotton straw',
      name: 'componentCottonStraw',
      desc: 'Name of cotton straw component',
      args: [],
    );
  }

  /// `Rice Husk Ash`
  String get componentRiceHuskAsh {
    return Intl.message(
      'Rice Husk Ash',
      name: 'componentRiceHuskAsh',
      desc: 'Name of rice husk ash component',
      args: [],
    );
  }

  /// `Lime`
  String get componentLime {
    return Intl.message(
      'Lime',
      name: 'componentLime',
      desc: 'Name of lime component',
      args: [],
    );
  }

  /// `Compost +`
  String get componentCompostPlus {
    return Intl.message(
      'Compost +',
      name: 'componentCompostPlus',
      desc: 'Name of compost plus component',
      args: [],
    );
  }

  /// `Dolomites`
  String get componentDolomites {
    return Intl.message(
      'Dolomites',
      name: 'componentDolomites',
      desc: 'Name of dolomites component',
      args: [],
    );
  }

  /// `Corn straw`
  String get componentCornStraw {
    return Intl.message(
      'Corn straw',
      name: 'componentCornStraw',
      desc: 'Name of corn straw component',
      args: [],
    );
  }

  /// `Cassava peels`
  String get componentCassavaPeels {
    return Intl.message(
      'Cassava peels',
      name: 'componentCassavaPeels',
      desc: 'Name of cassava peels component',
      args: [],
    );
  }

  /// `Litter (rice bran + chicken manure)`
  String get componentRiceChickenLitter {
    return Intl.message(
      'Litter (rice bran + chicken manure)',
      name: 'componentRiceChickenLitter',
      desc: 'Name of rice bran and chicken manure litter component',
      args: [],
    );
  }

  /// `Rice straw - counter-season`
  String get componentRiceStrawCounter {
    return Intl.message(
      'Rice straw - counter-season',
      name: 'componentRiceStrawCounter',
      desc: 'Name of counter-season rice straw component',
      args: [],
    );
  }

  /// `{selector, select, componentMangoWaste {Mango waste with seeds} componentCashewShells {Cashew shells} componentRiceHulls {Rice hulls/Rice bran} componentRiceStraw {Rice straw - wet season} componentSugarcaneBagasse {Sugarcane bagasse} componentChickenManure {Dried chicken manure} componentCowDung {Cow dung} componentCottonStraw {Cotton straw} componentRiceHuskAsh {Rice Husk Ash} componentLime {Lime} componentCompostPlus {Compost +} componentDolomites {Dolomites} componentCornStraw {Corn straw} componentCassavaPeels {Cassava peels} componentRiceChickenLitter {Litter (rice bran + chicken manure)} componentRiceStrawCounter {Rice straw - counter-season} other {Unknown component}}`
  String getTranslation(String selector) {
    return Intl.select(
      selector,
      {
        'componentMangoWaste': 'Mango waste with seeds',
        'componentCashewShells': 'Cashew shells',
        'componentRiceHulls': 'Rice hulls/Rice bran',
        'componentRiceStraw': 'Rice straw - wet season',
        'componentSugarcaneBagasse': 'Sugarcane bagasse',
        'componentChickenManure': 'Dried chicken manure',
        'componentCowDung': 'Cow dung',
        'componentCottonStraw': 'Cotton straw',
        'componentRiceHuskAsh': 'Rice Husk Ash',
        'componentLime': 'Lime',
        'componentCompostPlus': 'Compost +',
        'componentDolomites': 'Dolomites',
        'componentCornStraw': 'Corn straw',
        'componentCassavaPeels': 'Cassava peels',
        'componentRiceChickenLitter': 'Litter (rice bran + chicken manure)',
        'componentRiceStrawCounter': 'Rice straw - counter-season',
        'other': 'Unknown component',
      },
      name: 'getTranslation',
      desc: 'Translation selector for component names',
      args: [selector],
    );
  }

  /// `Ingredient Prices`
  String get pricePageTitle {
    return Intl.message(
      'Ingredient Prices',
      name: 'pricePageTitle',
      desc: 'Title of the prices page',
      args: [],
    );
  }

  /// `All Components`
  String get allComponents {
    return Intl.message(
      'All Components',
      name: 'allComponents',
      desc: 'Section title for all components list',
      args: [],
    );
  }

  /// `Cost/Unit`
  String get costPerUnit {
    return Intl.message(
      'Cost/Unit',
      name: 'costPerUnit',
      desc: 'Label for cost per unit input field',
      args: [],
    );
  }

  /// `FCFA`
  String get currencyFCFA {
    return Intl.message(
      'FCFA',
      name: 'currencyFCFA',
      desc: 'Currency label for FCFA',
      args: [],
    );
  }

  /// `Available: January to December`
  String get availabilityJanToDec {
    return Intl.message(
      'Available: January to December',
      name: 'availabilityJanToDec',
      desc: 'Availability period January to December',
      args: [],
    );
  }

  /// `Available: March to August`
  String get availabilityMarToAug {
    return Intl.message(
      'Available: March to August',
      name: 'availabilityMarToAug',
      desc: 'Availability period March to August',
      args: [],
    );
  }

  /// `Available: October to December`
  String get availabilityOctToDec {
    return Intl.message(
      'Available: October to December',
      name: 'availabilityOctToDec',
      desc: 'Availability period October to December',
      args: [],
    );
  }

  /// `Available: October to January`
  String get availabilityOctToJan {
    return Intl.message(
      'Available: October to January',
      name: 'availabilityOctToJan',
      desc: 'Availability period October to January',
      args: [],
    );
  }

  /// `Available: May to July`
  String get availabilityMayToJul {
    return Intl.message(
      'Available: May to July',
      name: 'availabilityMayToJul',
      desc: 'Availability period May to July',
      args: [],
    );
  }

  /// `Available: September to December`
  String get availabilitySepToDec {
    return Intl.message(
      'Available: September to December',
      name: 'availabilitySepToDec',
      desc: 'Availability period September to December',
      args: [],
    );
  }

  /// `Water`
  String get water {
    return Intl.message(
      'Water',
      name: 'water',
      desc: 'Nutrient name for water',
      args: [],
    );
  }

  /// `Great! {nutrientName} is within the optimal range ({min} - {max})`
  String nutrientInOptimalRange(String nutrientName, String min, String max) {
    return Intl.message(
      'Great! $nutrientName is within the optimal range ($min - $max)',
      name: 'nutrientInOptimalRange',
      desc: 'Message shown when a nutrient value is within the optimal range',
      args: [nutrientName, min, max],
    );
  }

  /// `Ingredients`
  String get ingredients {
    return Intl.message(
      'Ingredients',
      name: 'ingredients',
      desc: 'Section header for the list of compost ingredients',
      args: [],
    );
  }

  /// `Ingredient`
  String get ingredient {
    return Intl.message(
      'Ingredient',
      name: 'ingredient',
      desc: 'Single ingredient label for table header',
      args: [],
    );
  }

  /// `Add Ingredient`
  String get addIngredient {
    return Intl.message(
      'Add Ingredient',
      name: 'addIngredient',
      desc: 'Button label for adding a new compost ingredient to the recipe',
      args: [],
    );
  }

  /// `All Ingredients`
  String get allIngredients {
    return Intl.message(
      'All Ingredients',
      name: 'allIngredients',
      desc: 'Section title for all ingredients list',
      args: [],
    );
  }

  /// `Compost Calculator`
  String get compostCalculator {
    return Intl.message(
      'Compost Calculator',
      name: 'compostCalculator',
      desc: 'Main title of the compost calculator page',
      args: [],
    );
  }

  /// `Welcome to Compost Calculator`
  String get welcomeToCompostCalculator {
    return Intl.message(
      'Welcome to Compost Calculator',
      name: 'welcomeToCompostCalculator',
      desc: 'Welcome message for the compost calculator page',
      args: [],
    );
  }

  /// `This app is designed to help you create and manage open-pile aerobic composting. Use the tools below to learn about composting, explore recipes, or create your own!`
  String get thisAppIsDesignedToHelpYouCreateAndManage {
    return Intl.message(
      'This app is designed to help you create and manage open-pile aerobic composting. Use the tools below to learn about composting, explore recipes, or create your own!',
      name: 'thisAppIsDesignedToHelpYouCreateAndManage',
      desc: 'Description of the app\'s purpose and features',
      args: [],
    );
  }

  /// `Compost Guidelines`
  String get compostGuidelines {
    return Intl.message(
      'Compost Guidelines',
      name: 'compostGuidelines',
      desc: 'Title for the compost guidelines section',
      args: [],
    );
  }

  /// `Sample Compost Recipes`
  String get sampleCompostRecipes {
    return Intl.message(
      'Sample Compost Recipes',
      name: 'sampleCompostRecipes',
      desc: 'Title for the sample compost recipes section',
      args: [],
    );
  }

  /// `Aerobic Composting Process`
  String get aerobicCompostingProcess {
    return Intl.message(
      'Aerobic Composting Process',
      name: 'aerobicCompostingProcess',
      desc: 'Title for the aerobic composting process section',
      args: [],
    );
  }

  /// `How to Make Compost`
  String get howToMakeCompost {
    return Intl.message(
      'How to Make Compost',
      name: 'howToMakeCompost',
      desc: 'Title for the how-to guide on making compost',
      args: [],
    );
  }

  /// `C:N Ratio & Optimum Compost Conditions`
  String get cnRatioOptimumCompostConditions {
    return Intl.message(
      'C:N Ratio & Optimum Compost Conditions',
      name: 'cnRatioOptimumCompostConditions',
      desc: 'Title for the C:N ratio and optimum compost conditions section',
      args: [],
    );
  }

  /// `Troubleshooting Compost Problems`
  String get troubleshootingCompostProblems {
    return Intl.message(
      'Troubleshooting Compost Problems',
      name: 'troubleshootingCompostProblems',
      desc: 'Title for the troubleshooting compost problems section',
      args: [],
    );
  }

  /// `Content not available`
  String get contentNotAvailable {
    return Intl.message(
      'Content not available',
      name: 'contentNotAvailable',
      desc: 'Message shown when content is not available',
      args: [],
    );
  }

  /// `Composting happens in four stages:`
  String get compostingHappensInFourStages {
    return Intl.message(
      'Composting happens in four stages:',
      name: 'compostingHappensInFourStages',
      desc: 'Description of the four stages of composting',
      args: [],
    );
  }

  /// `Day 1`
  String get day1 {
    return Intl.message(
      'Day 1',
      name: 'day1',
      desc: 'Label for Day 1 in the composting timeline',
      args: [],
    );
  }

  /// `Day 5`
  String get day5 {
    return Intl.message(
      'Day 5',
      name: 'day5',
      desc: 'Label for Day 5 in the composting timeline',
      args: [],
    );
  }

  /// `Day 25`
  String get day25 {
    return Intl.message(
      'Day 25',
      name: 'day25',
      desc: 'Label for Day 25 in the composting timeline',
      args: [],
    );
  }

  /// `Day 35`
  String get day35 {
    return Intl.message(
      'Day 35',
      name: 'day35',
      desc: 'Label for Day 35 in the composting timeline',
      args: [],
    );
  }

  /// `Day 60+`
  String get day60 {
    return Intl.message(
      'Day 60+',
      name: 'day60',
      desc: 'Label for Day 60 and beyond in the composting timeline',
      args: [],
    );
  }

  /// `Start-up`
  String get startup {
    return Intl.message(
      'Start-up',
      name: 'startup',
      desc: 'Label for the start-up phase in the composting timeline',
      args: [],
    );
  }

  /// `Days 2-5`
  String get days2to5 {
    return Intl.message(
      'Days 2-5',
      name: 'days2to5',
      desc: 'Label for Days 2 to 5 in the composting timeline',
      args: [],
    );
  }

  /// `Heating`
  String get heating {
    return Intl.message(
      'Heating',
      name: 'heating',
      desc: 'Label for the heating phase in the composting timeline',
      args: [],
    );
  }

  /// `Days 5-25`
  String get days5to25 {
    return Intl.message(
      'Days 5-25',
      name: 'days5to25',
      desc: 'Label for Days 5 to 25 in the composting timeline',
      args: [],
    );
  }

  /// `Cooling`
  String get cooling {
    return Intl.message(
      'Cooling',
      name: 'cooling',
      desc: 'Label for the cooling phase in the composting timeline',
      args: [],
    );
  }

  /// `Days 25-35`
  String get days25to35 {
    return Intl.message(
      'Days 25-35',
      name: 'days25to35',
      desc: 'Label for Days 25 to 35 in the composting timeline',
      args: [],
    );
  }

  /// `Maturing`
  String get maturing {
    return Intl.message(
      'Maturing',
      name: 'maturing',
      desc: 'Label for the maturing phase in the composting timeline',
      args: [],
    );
  }

  /// `Days 35-60+`
  String get days35to60 {
    return Intl.message(
      'Days 35-60+',
      name: 'days35to60',
      desc: 'Label for Days 35 and beyond in the composting timeline',
      args: [],
    );
  }

  /// `Composting Timeline Process`
  String get compostingTimelineProcess {
    return Intl.message(
      'Composting Timeline Process',
      name: 'compostingTimelineProcess',
      desc: 'Title for the composting timeline process section',
      args: [],
    );
  }

  /// `1. Start-up (Days 2-5)`
  String get startupDays2to5 {
    return Intl.message(
      '1. Start-up (Days 2-5)',
      name: 'startupDays2to5',
      desc: 'Label for the start-up phase in the composting timeline',
      args: [],
    );
  }

  /// `Microorganisms begin breaking down waste.`
  String get microorganismsBeginBreakingDownWaste {
    return Intl.message(
      'Microorganisms begin breaking down waste.',
      name: 'microorganismsBeginBreakingDownWaste',
      desc: 'Description of the start-up phase in the composting timeline',
      args: [],
    );
  }

  /// `Temperature: 20–45°C`
  String get temperature20to45c {
    return Intl.message(
      'Temperature: 20–45°C',
      name: 'temperature20to45c',
      desc:
          'Temperature range for the start-up phase in the composting timeline',
      args: [],
    );
  }

  /// `Key Needs: Water, oxygen, small-sized organic matter.`
  String get keyNeedsWaterOxygenSmallsizedOrganicMatter {
    return Intl.message(
      'Key Needs: Water, oxygen, small-sized organic matter.',
      name: 'keyNeedsWaterOxygenSmallsizedOrganicMatter',
      desc: 'Key needs for the start-up phase in the composting timeline',
      args: [],
    );
  }

  /// `2. Heating Phase (Days 5-25)`
  String get heatingPhaseDays5to25 {
    return Intl.message(
      '2. Heating Phase (Days 5-25)',
      name: 'heatingPhaseDays5to25',
      desc: 'Label for the heating phase in the composting timeline',
      args: [],
    );
  }

  /// `Temperature: 45–65°C`
  String get temperature45to65c {
    return Intl.message(
      'Temperature: 45–65°C',
      name: 'temperature45to65c',
      desc:
          'Temperature range for the heating phase in the composting timeline',
      args: [],
    );
  }

  /// `Breaks down fast-decomposing materials, kills pathogens & weed seeds.`
  String get breaksDownFastdecomposingMaterialsKillsPathogensWeedSeeds {
    return Intl.message(
      'Breaks down fast-decomposing materials, kills pathogens & weed seeds.',
      name: 'breaksDownFastdecomposingMaterialsKillsPathogensWeedSeeds',
      desc: 'Description of the heating phase in the composting timeline',
      args: [],
    );
  }

  /// `Organisms change as conditions shift.`
  String get organismsChangeAsConditionsShift {
    return Intl.message(
      'Organisms change as conditions shift.',
      name: 'organismsChangeAsConditionsShift',
      desc:
          'Description of the organism changes during the heating phase in the composting timeline',
      args: [],
    );
  }

  /// `3. Cooling Phase (Days 25-35)`
  String get coolingPhaseDays25to35 {
    return Intl.message(
      '3. Cooling Phase (Days 25-35)',
      name: 'coolingPhaseDays25to35',
      desc: 'Label for the cooling phase in the composting timeline',
      args: [],
    );
  }

  /// `Temperature: 25–45°C`
  String get temperature25to45c {
    return Intl.message(
      'Temperature: 25–45°C',
      name: 'temperature25to45c',
      desc:
          'Temperature range for the cooling phase in the composting timeline',
      args: [],
    );
  }

  /// `Slower decomposition, fungi break down tougher materials (straw, wood).`
  String get slowerDecompositionFungiBreakDownTougherMaterialsStrawWood {
    return Intl.message(
      'Slower decomposition, fungi break down tougher materials (straw, wood).',
      name: 'slowerDecompositionFungiBreakDownTougherMaterialsStrawWood',
      desc: 'Description of the cooling phase in the composting timeline',
      args: [],
    );
  }

  /// `The pile shrinks as material decomposes.`
  String get thePileShrinksAsMaterialDecomposes {
    return Intl.message(
      'The pile shrinks as material decomposes.',
      name: 'thePileShrinksAsMaterialDecomposes',
      desc:
          'Description of the pile shrinkage during the cooling phase in the composting timeline',
      args: [],
    );
  }

  /// `4. Maturation Phase (Days 35-60+)`
  String get maturationPhaseDays35to60 {
    return Intl.message(
      '4. Maturation Phase (Days 35-60+)',
      name: 'maturationPhaseDays35to60',
      desc: 'Label for the maturation phase in the composting timeline',
      args: [],
    );
  }

  /// `Temperature: 20–40°C`
  String get temperature20to40c {
    return Intl.message(
      'Temperature: 20–40°C',
      name: 'temperature20to40c',
      desc:
          'Temperature range for the maturation phase in the composting timeline',
      args: [],
    );
  }

  /// `Soil organisms return, nutrients stabilize, humus forms.`
  String get soilOrganismsReturnNutrientsStabilizeHumusForms {
    return Intl.message(
      'Soil organisms return, nutrients stabilize, humus forms.',
      name: 'soilOrganismsReturnNutrientsStabilizeHumusForms',
      desc: 'Description of the maturation phase in the composting timeline',
      args: [],
    );
  }

  /// `Ready when: Dark, earthy smell, no heat in the center.`
  String get readyWhenDarkEarthySmellNoHeatInTheCenter {
    return Intl.message(
      'Ready when: Dark, earthy smell, no heat in the center.',
      name: 'readyWhenDarkEarthySmellNoHeatInTheCenter',
      desc:
          'Description of the readiness indicators during the maturation phase in the composting timeline',
      args: [],
    );
  }

  /// `Can be stored for 6–12 months (keep dry to avoid nutrient loss).`
  String get canBeStoredFor6to12MonthsKeepDryToAvoid {
    return Intl.message(
      'Can be stored for 6–12 months (keep dry to avoid nutrient loss).',
      name: 'canBeStoredFor6to12MonthsKeepDryToAvoid',
      desc: 'Description of the storage conditions for mature compost',
      args: [],
    );
  }

  /// `Visual Tip`
  String get visualTip {
    return Intl.message(
      'Visual Tip',
      name: 'visualTip',
      desc: 'Title for the visual tip section',
      args: [],
    );
  }

  /// `Your compost pile should be large enough to maintain heat (at least 3×3×3 feet), but small enough to easily turn and manage.`
  String get yourCompostPileShouldBeLargeEnoughToMaintainHeat {
    return Intl.message(
      'Your compost pile should be large enough to maintain heat (at least 3×3×3 feet), but small enough to easily turn and manage.',
      name: 'yourCompostPileShouldBeLargeEnoughToMaintainHeat',
      desc: 'Description of the ideal size for a compost pile',
      args: [],
    );
  }

  /// `Choose a site`
  String get chooseASite {
    return Intl.message(
      'Choose a site',
      name: 'chooseASite',
      desc: 'Title for the choose a site section',
      args: [],
    );
  }

  /// `Well-drained, shady, near a water source.`
  String get welldrainedShadyNearAWaterSource {
    return Intl.message(
      'Well-drained, shady, near a water source.',
      name: 'welldrainedShadyNearAWaterSource',
      desc: 'Description of the ideal site conditions for composting',
      args: [],
    );
  }

  /// `Layer materials`
  String get layerMaterials {
    return Intl.message(
      'Layer materials',
      name: 'layerMaterials',
      desc: 'Title for the layer materials section',
      args: [],
    );
  }

  /// `Balance carbon (dry browns) and nitrogen (greens).`
  String get balanceCarbonDryBrownsAndNitrogenGreens {
    return Intl.message(
      'Balance carbon (dry browns) and nitrogen (greens).',
      name: 'balanceCarbonDryBrownsAndNitrogenGreens',
      desc: 'Description of the material layering process in composting',
      args: [],
    );
  }

  /// `Maintain moisture`
  String get maintainMoisture {
    return Intl.message(
      'Maintain moisture',
      name: 'maintainMoisture',
      desc: 'Title for the maintain moisture section',
      args: [],
    );
  }

  /// `Keep it like a damp sponge (not too dry or soggy).`
  String get keepItLikeADampSpongeNotTooDry {
    return Intl.message(
      'Keep it like a damp sponge (not too dry or soggy).',
      name: 'keepItLikeADampSpongeNotTooDry',
      desc: 'Description of the ideal moisture level for composting',
      args: [],
    );
  }

  /// `Turn the pile regularly`
  String get turnThePileRegularly {
    return Intl.message(
      'Turn the pile regularly',
      name: 'turnThePileRegularly',
      desc: 'Title for the turn the pile regularly section',
      args: [],
    );
  }

  /// `Mix every 7–14 days for aeration.`
  String get mixEvery714DaysForAeration {
    return Intl.message(
      'Mix every 7–14 days for aeration.',
      name: 'mixEvery714DaysForAeration',
      desc: 'Description of the turning process in composting',
      args: [],
    );
  }

  /// `Check readiness`
  String get checkReadiness {
    return Intl.message(
      'Check readiness',
      name: 'checkReadiness',
      desc: 'Title for the check readiness section',
      args: [],
    );
  }

  /// `When dark, crumbly, and smells earthy, it's done!`
  String get whenDarkCrumblyAndSmellsEarthyItsDone {
    return Intl.message(
      'When dark, crumbly, and smells earthy, it\'s done!',
      name: 'whenDarkCrumblyAndSmellsEarthyItsDone',
      desc: 'Description of the indicators for compost readiness',
      args: [],
    );
  }

  /// `C:N Ratio Explained:`
  String get cnRatioExplained {
    return Intl.message(
      'C:N Ratio Explained:',
      name: 'cnRatioExplained',
      desc: 'Title for the C:N ratio explanation section',
      args: [],
    );
  }

  /// `Ideal Carbon:Nitrogen ratio = 30:1`
  String get idealCarbonnitrogenRatio30to1 {
    return Intl.message(
      'Ideal Carbon:Nitrogen ratio = 30:1',
      name: 'idealCarbonnitrogenRatio30to1',
      desc: 'Description of the ideal C:N ratio for composting',
      args: [],
    );
  }

  /// `Too much carbon? Decomposition slows down.`
  String get tooMuchCarbonDecompositionSlowsDown {
    return Intl.message(
      'Too much carbon? Decomposition slows down.',
      name: 'tooMuchCarbonDecompositionSlowsDown',
      desc: 'Description of the effect of too much carbon in composting',
      args: [],
    );
  }

  /// `Too much nitrogen? Smelly, soggy pile.`
  String get tooMuchNitrogenSmellySoggyPile {
    return Intl.message(
      'Too much nitrogen? Smelly, soggy pile.',
      name: 'tooMuchNitrogenSmellySoggyPile',
      desc: 'Description of the effect of too much nitrogen in composting',
      args: [],
    );
  }

  /// `Simple rule:`
  String get simpleRule {
    return Intl.message(
      'Simple rule:',
      name: 'simpleRule',
      desc: 'Title for the simple rule section',
      args: [],
    );
  }

  /// `1 bucket nitrogen-rich materials (greens)`
  String get bucketNitrogenrichMaterialsGreens {
    return Intl.message(
      '1 bucket nitrogen-rich materials (greens)',
      name: 'bucketNitrogenrichMaterialsGreens',
      desc: 'Description of the nitrogen-rich materials (greens) in composting',
      args: [],
    );
  }

  /// `2 buckets dry carbon materials (browns)`
  String get bucketsDryCarbonMaterialsBrowns {
    return Intl.message(
      '2 buckets dry carbon materials (browns)',
      name: 'bucketsDryCarbonMaterialsBrowns',
      desc: 'Description of the dry carbon materials (browns) in composting',
      args: [],
    );
  }

  /// `High Carbon`
  String get highCarbon {
    return Intl.message(
      'High Carbon',
      name: 'highCarbon',
      desc: 'Label for high carbon materials',
      args: [],
    );
  }

  /// `Browns`
  String get browns {
    return Intl.message(
      'Browns',
      name: 'browns',
      desc: 'Label for brown materials',
      args: [],
    );
  }

  /// `Cashew shells`
  String get cashewShells {
    return Intl.message(
      'Cashew shells',
      name: 'cashewShells',
      desc: 'Name of cashew shells component',
      args: [],
    );
  }

  /// `Rice husks`
  String get riceHusks {
    return Intl.message(
      'Rice husks',
      name: 'riceHusks',
      desc: 'Name of rice husks component',
      args: [],
    );
  }

  /// `Dry leaves`
  String get dryLeaves {
    return Intl.message(
      'Dry leaves',
      name: 'dryLeaves',
      desc: 'Name of dry leaves component',
      args: [],
    );
  }

  /// `High Nitrogen`
  String get highNitrogen {
    return Intl.message(
      'High Nitrogen',
      name: 'highNitrogen',
      desc: 'Label for high nitrogen materials',
      args: [],
    );
  }

  /// `Greens`
  String get greens {
    return Intl.message(
      'Greens',
      name: 'greens',
      desc: 'Label for green materials',
      args: [],
    );
  }

  /// `Chicken manure`
  String get chickenManure {
    return Intl.message(
      'Chicken manure',
      name: 'chickenManure',
      desc: 'Name of chicken manure component',
      args: [],
    );
  }

  /// `Cow dung`
  String get cowDung {
    return Intl.message(
      'Cow dung',
      name: 'cowDung',
      desc: 'Name of cow dung component',
      args: [],
    );
  }

  /// `Fresh plant`
  String get freshPlant {
    return Intl.message(
      'Fresh plant',
      name: 'freshPlant',
      desc: 'Name of fresh plant component',
      args: [],
    );
  }

  /// `Optimum Moisture`
  String get optimumMoisture {
    return Intl.message(
      'Optimum Moisture',
      name: 'optimumMoisture',
      desc: 'Title for the optimum moisture section',
      args: [],
    );
  }

  /// `Your compost should have the moisture level of a wrung-out sponge - damp but not soggy.`
  String get yourCompostShouldHaveTheMoistureLevelOfAWrungout {
    return Intl.message(
      'Your compost should have the moisture level of a wrung-out sponge - damp but not soggy.',
      name: 'yourCompostShouldHaveTheMoistureLevelOfAWrungout',
      desc: 'Description of the ideal moisture level for composting',
      args: [],
    );
  }

  /// `Oxygen Requirements`
  String get oxygenRequirements {
    return Intl.message(
      'Oxygen Requirements',
      name: 'oxygenRequirements',
      desc: 'Title for the oxygen requirements section',
      args: [],
    );
  }

  /// `Regular turning (every 1-2 weeks) ensures proper oxygen flow for aerobic decomposition.`
  String get regularTurningEvery12WeeksEnsuresProperOxygenFlowFor {
    return Intl.message(
      'Regular turning (every 1-2 weeks) ensures proper oxygen flow for aerobic decomposition.',
      name: 'regularTurningEvery12WeeksEnsuresProperOxygenFlowFor',
      desc:
          'Description of the importance of regular turning for oxygen flow in composting',
      args: [],
    );
  }

  /// `Common Compost Problems & Solutions`
  String get commonCompostProblemsSolutions {
    return Intl.message(
      'Common Compost Problems & Solutions',
      name: 'commonCompostProblemsSolutions',
      desc: 'Title for the common compost problems and solutions section',
      args: [],
    );
  }

  /// `Quick Check`
  String get quickCheck {
    return Intl.message(
      'Quick Check',
      name: 'quickCheck',
      desc: 'Title for the quick check section',
      args: [],
    );
  }

  /// `A healthy compost pile should be warm, slightly damp, and have an earthy smell. If yours doesn't match this description, check the troubleshooting tips above!`
  String get aHealthyCompostPileShouldBeWarmSlightlyDampAnd {
    return Intl.message(
      'A healthy compost pile should be warm, slightly damp, and have an earthy smell. If yours doesn\'t match this description, check the troubleshooting tips above!',
      name: 'aHealthyCompostPileShouldBeWarmSlightlyDampAnd',
      desc: 'Description of the characteristics of a healthy compost pile',
      args: [],
    );
  }

  /// `Pile Isn't Heating Up`
  String get pileIsntHeatingUp {
    return Intl.message(
      'Pile Isn\'t Heating Up',
      name: 'pileIsntHeatingUp',
      desc: 'Title for the pile isn\'t heating up section',
      args: [],
    );
  }

  /// `Pile too small (should be at least 3×3×3 feet)`
  String get pileTooSmallShouldBeAtLeast3x3x3Feet {
    return Intl.message(
      'Pile too small (should be at least 3×3×3 feet)',
      name: 'pileTooSmallShouldBeAtLeast3x3x3Feet',
      desc: 'Description of the issue when the compost pile is too small',
      args: [],
    );
  }

  /// `Too dry (add water)`
  String get tooDryAddWater {
    return Intl.message(
      'Too dry (add water)',
      name: 'tooDryAddWater',
      desc: 'Description of the issue when the compost pile is too dry',
      args: [],
    );
  }

  /// `Not enough nitrogen (add 'greens')`
  String get notEnoughNitrogenAddGreens {
    return Intl.message(
      'Not enough nitrogen (add \'greens\')',
      name: 'notEnoughNitrogenAddGreens',
      desc:
          'Description of the issue when there is not enough nitrogen in the compost pile',
      args: [],
    );
  }

  /// `Cold weather (insulate or wait for warmer conditions)`
  String get coldWeatherInsulateOrWaitForWarmerConditions {
    return Intl.message(
      'Cold weather (insulate or wait for warmer conditions)',
      name: 'coldWeatherInsulateOrWaitForWarmerConditions',
      desc:
          'Description of the issue when the compost pile is affected by cold weather',
      args: [],
    );
  }

  /// `Pile is finished composting`
  String get pileIsFinishedComposting {
    return Intl.message(
      'Pile is finished composting',
      name: 'pileIsFinishedComposting',
      desc:
          'Description of the issue when the compost pile is finished composting',
      args: [],
    );
  }

  /// `Add more nitrogen-rich materials`
  String get addMoreNitrogenrichMaterials {
    return Intl.message(
      'Add more nitrogen-rich materials',
      name: 'addMoreNitrogenrichMaterials',
      desc:
          'Description of the solution when the compost pile needs more nitrogen-rich materials',
      args: [],
    );
  }

  /// `Check moisture and add water if needed`
  String get checkMoistureAndAddWaterIfNeeded {
    return Intl.message(
      'Check moisture and add water if needed',
      name: 'checkMoistureAndAddWaterIfNeeded',
      desc:
          'Description of the solution when the compost pile needs moisture adjustment',
      args: [],
    );
  }

  /// `Turn the pile to increase oxygen`
  String get turnThePileToIncreaseOxygen {
    return Intl.message(
      'Turn the pile to increase oxygen',
      name: 'turnThePileToIncreaseOxygen',
      desc:
          'Description of the solution when the compost pile needs more oxygen',
      args: [],
    );
  }

  /// `Increase pile size`
  String get increasePileSize {
    return Intl.message(
      'Increase pile size',
      name: 'increasePileSize',
      desc:
          'Description of the solution when the compost pile needs to be larger',
      args: [],
    );
  }

  /// `Bad Odors`
  String get badOdors {
    return Intl.message(
      'Bad Odors',
      name: 'badOdors',
      desc: 'Title for the bad odors section',
      args: [],
    );
  }

  /// `Ammonia smell: Too much nitrogen`
  String get ammoniaSmellTooMuchNitrogen {
    return Intl.message(
      'Ammonia smell: Too much nitrogen',
      name: 'ammoniaSmellTooMuchNitrogen',
      desc:
          'Description of the issue when there is too much nitrogen in the compost pile',
      args: [],
    );
  }

  /// `Rotten egg smell: Anaerobic conditions (not enough oxygen)`
  String get rottenEggSmellAnaerobicConditionsNotEnoughOxygen {
    return Intl.message(
      'Rotten egg smell: Anaerobic conditions (not enough oxygen)',
      name: 'rottenEggSmellAnaerobicConditionsNotEnoughOxygen',
      desc:
          'Description of the issue when there are anaerobic conditions in the compost pile',
      args: [],
    );
  }

  /// `'Other' materials (meat, dairy, etc.)`
  String get otherMaterialsMeatDairyEtc {
    return Intl.message(
      '\'Other\' materials (meat, dairy, etc.)',
      name: 'otherMaterialsMeatDairyEtc',
      desc:
          'Description of the issue when there are \'other\' materials like meat or dairy in the compost pile',
      args: [],
    );
  }

  /// `Add carbon-rich materials (dry leaves, straw)`
  String get addCarbonrichMaterialsDryLeavesStraw {
    return Intl.message(
      'Add carbon-rich materials (dry leaves, straw)',
      name: 'addCarbonrichMaterialsDryLeavesStraw',
      desc:
          'Description of the solution when the compost pile needs more carbon-rich materials',
      args: [],
    );
  }

  /// `Turn the pile to add oxygen`
  String get turnThePileToAddOxygen {
    return Intl.message(
      'Turn the pile to add oxygen',
      name: 'turnThePileToAddOxygen',
      desc:
          'Description of the solution when the compost pile needs more oxygen',
      args: [],
    );
  }

  /// `Cover food scraps with browns`
  String get coverFoodScrapsWithBrowns {
    return Intl.message(
      'Cover food scraps with browns',
      name: 'coverFoodScrapsWithBrowns',
      desc:
          'Description of the solution when the compost pile needs to cover food scraps with browns',
      args: [],
    );
  }

  /// `Avoid adding meat, dairy, or oils`
  String get avoidAddingMeatDairyOrOils {
    return Intl.message(
      'Avoid adding meat, dairy, or oils',
      name: 'avoidAddingMeatDairyOrOils',
      desc:
          'Description of the solution when the compost pile needs to avoid adding meat, dairy, or oils',
      args: [],
    );
  }

  /// `Pests in the Compost`
  String get pestsInTheCompost {
    return Intl.message(
      'Pests in the Compost',
      name: 'pestsInTheCompost',
      desc: 'Title for the pests in the compost section',
      args: [],
    );
  }

  /// `Exposed food scraps`
  String get exposedFoodScraps {
    return Intl.message(
      'Exposed food scraps',
      name: 'exposedFoodScraps',
      desc:
          'Description of the issue when there are exposed food scraps in the compost pile',
      args: [],
    );
  }

  /// `Meat, dairy or fatty foods in compost`
  String get meatDairyOrFattyFoodsInCompost {
    return Intl.message(
      'Meat, dairy or fatty foods in compost',
      name: 'meatDairyOrFattyFoodsInCompost',
      desc:
          'Description of the issue when there are meat, dairy, or fatty foods in the compost pile',
      args: [],
    );
  }

  /// `Pile not hot enough`
  String get pileNotHotEnough {
    return Intl.message(
      'Pile not hot enough',
      name: 'pileNotHotEnough',
      desc: 'Description of the issue when the compost pile is not hot enough',
      args: [],
    );
  }

  /// `Bury food scraps in the center of the pile`
  String get buryFoodScrapsInTheCenterOfThePile {
    return Intl.message(
      'Bury food scraps in the center of the pile',
      name: 'buryFoodScrapsInTheCenterOfThePile',
      desc:
          'Description of the solution when the compost pile needs to bury food scraps in the center',
      args: [],
    );
  }

  /// `Avoid adding meat, dairy, oils, or pet waste`
  String get avoidAddingMeatDairyOilsOrPetWaste {
    return Intl.message(
      'Avoid adding meat, dairy, oils, or pet waste',
      name: 'avoidAddingMeatDairyOilsOrPetWaste',
      desc:
          'Description of the solution when the compost pile needs to avoid adding meat, dairy, oils, or pet waste',
      args: [],
    );
  }

  /// `Turn pile regularly to maintain heat`
  String get turnPileRegularlyToMaintainHeat {
    return Intl.message(
      'Turn pile regularly to maintain heat',
      name: 'turnPileRegularlyToMaintainHeat',
      desc:
          'Description of the solution when the compost pile needs to turn regularly to maintain heat',
      args: [],
    );
  }

  /// `Use a rodent-resistant bin if necessary`
  String get useARodentresistantBinIfNecessary {
    return Intl.message(
      'Use a rodent-resistant bin if necessary',
      name: 'useARodentresistantBinIfNecessary',
      desc:
          'Description of the solution when the compost pile needs to use a rodent-resistant bin if necessary',
      args: [],
    );
  }

  /// `Pile Is Too Wet/Dry`
  String get pileIsTooWetdry {
    return Intl.message(
      'Pile Is Too Wet/Dry',
      name: 'pileIsTooWetdry',
      desc: 'Title for the pile is too wet/dry section',
      args: [],
    );
  }

  /// `Too wet: Soggy materials, poor drainage`
  String get tooWetSoggyMaterialsPoorDrainage {
    return Intl.message(
      'Too wet: Soggy materials, poor drainage',
      name: 'tooWetSoggyMaterialsPoorDrainage',
      desc:
          'Description of the issue when the compost pile is too wet due to soggy materials or poor drainage',
      args: [],
    );
  }

  /// `Too dry: Not enough water, too much sun exposure`
  String get tooDryNotEnoughWaterTooMuchSunExposure {
    return Intl.message(
      'Too dry: Not enough water, too much sun exposure',
      name: 'tooDryNotEnoughWaterTooMuchSunExposure',
      desc:
          'Description of the issue when the compost pile is too dry due to not enough water or too much sun exposure',
      args: [],
    );
  }

  /// `Too wet: Add dry, carbon-rich materials`
  String get tooWetAddDryCarbonrichMaterials {
    return Intl.message(
      'Too wet: Add dry, carbon-rich materials',
      name: 'tooWetAddDryCarbonrichMaterials',
      desc:
          'Description of the solution when the compost pile is too wet and needs to add dry, carbon-rich materials',
      args: [],
    );
  }

  /// `Too wet: Turn the pile to help it dry out`
  String get tooWetTurnThePileToHelpItDryOut {
    return Intl.message(
      'Too wet: Turn the pile to help it dry out',
      name: 'tooWetTurnThePileToHelpItDryOut',
      desc:
          'Description of the solution when the compost pile is too wet and needs to turn the pile to help it dry out',
      args: [],
    );
  }

  /// `Too wet: Cover during heavy rains`
  String get tooWetCoverDuringHeavyRains {
    return Intl.message(
      'Too wet: Cover during heavy rains',
      name: 'tooWetCoverDuringHeavyRains',
      desc:
          'Description of the solution when the compost pile is too wet and needs to cover during heavy rains',
      args: [],
    );
  }

  /// `Too dry: Add water while turning the pile`
  String get tooDryAddWaterWhileTurningThePile {
    return Intl.message(
      'Too dry: Add water while turning the pile',
      name: 'tooDryAddWaterWhileTurningThePile',
      desc:
          'Description of the solution when the compost pile is too dry and needs to add water while turning the pile',
      args: [],
    );
  }

  /// `Too dry: Add fresh 'green' materials`
  String get tooDryAddFreshGreenMaterials {
    return Intl.message(
      'Too dry: Add fresh \'green\' materials',
      name: 'tooDryAddFreshGreenMaterials',
      desc:
          'Description of the solution when the compost pile is too dry and needs to add fresh \'green\' materials',
      args: [],
    );
  }

  /// `Solutions:`
  String get solutions {
    return Intl.message(
      'Solutions:',
      name: 'solutions',
      desc: 'Label for the solutions section',
      args: [],
    );
  }

  /// `Basic Garden Compost`
  String get basicGardenCompost {
    return Intl.message(
      'Basic Garden Compost',
      name: 'basicGardenCompost',
      desc: 'Title for the basic garden compost recipe',
      args: [],
    );
  }

  /// `A simple, balanced recipe for general garden use.`
  String get aSimpleBalancedRecipeForGeneralGardenUse {
    return Intl.message(
      'A simple, balanced recipe for general garden use.',
      name: 'aSimpleBalancedRecipeForGeneralGardenUse',
      desc: 'Description of the basic garden compost recipe',
      args: [],
    );
  }

  /// `3 parts dry leaves`
  String get partsDryLeaves {
    return Intl.message(
      '3 parts dry leaves',
      name: 'partsDryLeaves',
      desc:
          'Description of the dry leaves component in the basic garden compost recipe',
      args: [],
    );
  }

  /// `1 part fresh grass clippings`
  String get partFreshGrassClippings {
    return Intl.message(
      '1 part fresh grass clippings',
      name: 'partFreshGrassClippings',
      desc:
          'Description of the fresh grass clippings component in the basic garden compost recipe',
      args: [],
    );
  }

  /// `1 part vegetable scraps`
  String get partVegetableScraps {
    return Intl.message(
      '1 part vegetable scraps',
      name: 'partVegetableScraps',
      desc:
          'Description of the vegetable scraps component in the basic garden compost recipe',
      args: [],
    );
  }

  /// `Layer ingredients, moisten, and turn every 1-2 weeks. Ready in 3-6 months.`
  String get layerIngredientsMoistenAndTurnEvery12WeeksReadyIn {
    return Intl.message(
      'Layer ingredients, moisten, and turn every 1-2 weeks. Ready in 3-6 months.',
      name: 'layerIngredientsMoistenAndTurnEvery12WeeksReadyIn',
      desc:
          'Description of the preparation and readiness time for the basic garden compost recipe',
      args: [],
    );
  }

  /// `Fast Hot Compost`
  String get fastHotCompost {
    return Intl.message(
      'Fast Hot Compost',
      name: 'fastHotCompost',
      desc: 'Title for the fast hot compost recipe',
      args: [],
    );
  }

  /// `For when you need compost quickly.`
  String get forWhenYouNeedCompostQuickly {
    return Intl.message(
      'For when you need compost quickly.',
      name: 'forWhenYouNeedCompostQuickly',
      desc: 'Description of the fast hot compost recipe',
      args: [],
    );
  }

  /// `2 parts chopped straw or wood chips`
  String get partsChoppedStrawOrWoodChips {
    return Intl.message(
      '2 parts chopped straw or wood chips',
      name: 'partsChoppedStrawOrWoodChips',
      desc:
          'Description of the chopped straw or wood chips component in the fast hot compost recipe',
      args: [],
    );
  }

  /// `1 part chicken manure`
  String get partChickenManure {
    return Intl.message(
      '1 part chicken manure',
      name: 'partChickenManure',
      desc:
          'Description of the chicken manure component in the fast hot compost recipe',
      args: [],
    );
  }

  /// `1 part green garden waste (chopped small)`
  String get partGreenGardenWasteChoppedSmall {
    return Intl.message(
      '1 part green garden waste (chopped small)',
      name: 'partGreenGardenWasteChoppedSmall',
      desc:
          'Description of the green garden waste component in the fast hot compost recipe',
      args: [],
    );
  }

  /// `Mix thoroughly, ensure adequate moisture, and turn every 3 days. Can be ready in 3-4 weeks if conditions are ideal.`
  String get mixThoroughlyEnsureAdequateMoistureAndTurnEvery3Days {
    return Intl.message(
      'Mix thoroughly, ensure adequate moisture, and turn every 3 days. Can be ready in 3-4 weeks if conditions are ideal.',
      name: 'mixThoroughlyEnsureAdequateMoistureAndTurnEvery3Days',
      desc:
          'Description of the preparation and readiness time for the fast hot compost recipe',
      args: [],
    );
  }

  /// `Instructions`
  String get instructions {
    return Intl.message(
      'Instructions',
      name: 'instructions',
      desc: 'Label for the instructions section',
      args: [],
    );
  }

  /// `Possible Causes:`
  String get possibleCauses {
    return Intl.message(
      'Possible Causes:',
      name: 'possibleCauses',
      desc: 'Label for the possible causes section',
      args: [],
    );
  }

  /// `C/N`
  String get cn {
    return Intl.message(
      'C/N',
      name: 'cn',
      desc: 'Label for the carbon to nitrogen ratio',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
