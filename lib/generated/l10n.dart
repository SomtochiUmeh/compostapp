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

  /// `Component Prices`
  String get pricePageTitle {
    return Intl.message(
      'Component Prices',
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
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
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
