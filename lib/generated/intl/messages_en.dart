// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(selector) => "${Intl.select(selector, {'componentMangoWaste': 'Mango waste with seeds', 'componentCashewShells': 'Cashew shells', 'componentRiceHulls': 'Rice hulls/Rice bran', 'componentRiceStraw': 'Rice straw - wet season', 'componentSugarcaneBagasse': 'Sugarcane bagasse', 'componentChickenManure': 'Dried chicken manure', 'componentCowDung': 'Cow dung', 'componentCottonStraw': 'Cotton straw', 'componentRiceHuskAsh': 'Rice Husk Ash', 'componentLime': 'Lime', 'componentCompostPlus': 'Compost +', 'componentDolomites': 'Dolomites', 'componentCornStraw': 'Corn straw', 'componentCassavaPeels': 'Cassava peels', 'componentRiceChickenLitter': 'Litter (rice bran + chicken manure)', 'componentRiceStrawCounter': 'Rice straw - counter-season', 'other': 'Unknown component', })}";

  static m1(value) => "${value} (%)";

  static m2(price, amount, unit) => "Price: ${price} FCFA per ${amount} ${unit}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "add" : MessageLookupByLibrary.simpleMessage("Add"),
    "addComponent" : MessageLookupByLibrary.simpleMessage("Add Component"),
    "allAvailableComponentsHaveBeenAdded" : MessageLookupByLibrary.simpleMessage("All available components have been added"),
    "allComponents" : MessageLookupByLibrary.simpleMessage("All Components"),
    "availabilityJanToDec" : MessageLookupByLibrary.simpleMessage("Available: January to December"),
    "availabilityMarToAug" : MessageLookupByLibrary.simpleMessage("Available: March to August"),
    "availabilityMayToJul" : MessageLookupByLibrary.simpleMessage("Available: May to July"),
    "availabilityOctToDec" : MessageLookupByLibrary.simpleMessage("Available: October to December"),
    "availabilityOctToJan" : MessageLookupByLibrary.simpleMessage("Available: October to January"),
    "availabilitySepToDec" : MessageLookupByLibrary.simpleMessage("Available: September to December"),
    "calcium" : MessageLookupByLibrary.simpleMessage("calcium"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "chooseComponent" : MessageLookupByLibrary.simpleMessage("Choose Component"),
    "close" : MessageLookupByLibrary.simpleMessage("Close"),
    "component" : MessageLookupByLibrary.simpleMessage("Component"),
    "componentCashewShells" : MessageLookupByLibrary.simpleMessage("Cashew shells"),
    "componentCassavaPeels" : MessageLookupByLibrary.simpleMessage("Cassava peels"),
    "componentChickenManure" : MessageLookupByLibrary.simpleMessage("Dried chicken manure"),
    "componentCompostPlus" : MessageLookupByLibrary.simpleMessage("Compost +"),
    "componentCornStraw" : MessageLookupByLibrary.simpleMessage("Corn straw"),
    "componentCottonStraw" : MessageLookupByLibrary.simpleMessage("Cotton straw"),
    "componentCowDung" : MessageLookupByLibrary.simpleMessage("Cow dung"),
    "componentDolomites" : MessageLookupByLibrary.simpleMessage("Dolomites"),
    "componentLime" : MessageLookupByLibrary.simpleMessage("Lime"),
    "componentMangoWaste" : MessageLookupByLibrary.simpleMessage("Mango waste with seeds"),
    "componentRiceChickenLitter" : MessageLookupByLibrary.simpleMessage("Litter (rice bran + chicken manure)"),
    "componentRiceHulls" : MessageLookupByLibrary.simpleMessage("Rice hulls/Rice bran"),
    "componentRiceHuskAsh" : MessageLookupByLibrary.simpleMessage("Rice Husk Ash"),
    "componentRiceStraw" : MessageLookupByLibrary.simpleMessage("Rice straw - wet season"),
    "componentRiceStrawCounter" : MessageLookupByLibrary.simpleMessage("Rice straw - counter-season"),
    "componentSugarcaneBagasse" : MessageLookupByLibrary.simpleMessage("Sugarcane bagasse"),
    "components" : MessageLookupByLibrary.simpleMessage("Components"),
    "compostRecipeBuilder" : MessageLookupByLibrary.simpleMessage("Compost Recipe Builder"),
    "costFCFA" : MessageLookupByLibrary.simpleMessage("Cost (FCFA)"),
    "costPerUnit" : MessageLookupByLibrary.simpleMessage("Cost/Unit"),
    "currencyFCFA" : MessageLookupByLibrary.simpleMessage("FCFA"),
    "dryMatter" : MessageLookupByLibrary.simpleMessage("dry matter"),
    "editComponent" : MessageLookupByLibrary.simpleMessage("Edit Component"),
    "getTranslation" : m0,
    "magnesium" : MessageLookupByLibrary.simpleMessage("magnesium"),
    "nitrogen" : MessageLookupByLibrary.simpleMessage("nitrogen"),
    "noComponentsAddedYetClickTheButtonBelowToAdd" : MessageLookupByLibrary.simpleMessage("No components added yet. Click the button below to add components to your compost recipe."),
    "nutrientAnalysis" : MessageLookupByLibrary.simpleMessage("Nutrient Analysis"),
    "organicCarbon" : MessageLookupByLibrary.simpleMessage("organic carbon"),
    "percentage" : m1,
    "phosphorus" : MessageLookupByLibrary.simpleMessage("phosphorus"),
    "pleaseEnterValidWeight" : MessageLookupByLibrary.simpleMessage("Please enter a valid weight"),
    "pleaseFillAllFields" : MessageLookupByLibrary.simpleMessage("Please fill all fields"),
    "potassium" : MessageLookupByLibrary.simpleMessage("potassium"),
    "price" : m2,
    "pricePageTitle" : MessageLookupByLibrary.simpleMessage("Component Prices"),
    "prices" : MessageLookupByLibrary.simpleMessage("Prices"),
    "recipeBuilder" : MessageLookupByLibrary.simpleMessage("Recipe Builder"),
    "recipeQualityGuide" : MessageLookupByLibrary.simpleMessage("Recipe Quality Guide"),
    "recipeQualityInfo" : MessageLookupByLibrary.simpleMessage("Green checkmark: Nutrient level within recommended range\nRed up arrow: Nutrient level below recommended range\nOrange down arrow: Nutrient level above recommended range\n\nRecommended ranges are based on municipal compost standards."),
    "totalCostFCFA" : MessageLookupByLibrary.simpleMessage("Total Cost (FCFA)"),
    "totalWeightKg" : MessageLookupByLibrary.simpleMessage("Total Weight (kg)"),
    "unitKgs" : MessageLookupByLibrary.simpleMessage("kgs"),
    "unitTons" : MessageLookupByLibrary.simpleMessage("tons"),
    "update" : MessageLookupByLibrary.simpleMessage("Update"),
    "weight" : MessageLookupByLibrary.simpleMessage("Weight (kg)")
  };
}
