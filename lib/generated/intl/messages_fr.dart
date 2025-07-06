// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(ingredientName) =>
      "Ingrédient personnalisé ajouté: ${ingredientName}";

  static String m1(ingredientName) =>
      "Êtes-vous sûr de vouloir supprimer \"${ingredientName}\"?";

  static String m2(ingredientName) => "Ingrédient supprimé: ${ingredientName}";

  static String m3(componentName) =>
      "Modifier la disponibilité pour ${componentName}";

  static String m4(selector) =>
      "${Intl.select(selector, {'componentMangoWaste': 'Déchets de mangue avec graines', 'componentCashewShells': 'Coques de cajou', 'componentRiceHulls': 'Balles de riz/Son de riz', 'componentRiceStraw': 'Paille de riz - saison humide', 'componentSugarcaneBagasse': 'Bagasse de canne à sucre', 'componentChickenManure': 'Fumier de poulet séché', 'componentCowDung': 'Bouse de vache', 'componentCottonStraw': 'Paille de coton', 'componentRiceHuskAsh': 'Cendre de balle de riz', 'componentLime': 'Chaux', 'componentCompostPlus': 'Compost +', 'componentDolomites': 'Dolomites', 'componentCornStraw': 'Paille de maïs', 'componentCassavaPeels': 'Épluchures de manioc', 'componentRiceChickenLitter': 'Litière (son de riz + fumier de poulet)', 'componentRiceStrawCounter': 'Paille de riz - contre-saison', 'other': 'Composant inconnu'})}";

  static String m5(ingredientName) =>
      "L\'ingrédient \"${ingredientName}\" n\'existe plus";

  static String m6(nutrientName, min, max) =>
      "Excellent! ${nutrientName} est dans la plage optimale (${min} - ${max})";

  static String m7(value) => "${value} (%)";

  static String m8(price, amount, unit) =>
      "Prix: ${price} FCFA par ${amount} ${unit}";

  static String m9(count) =>
      "${count} ingrédients supprimés retirés de la recette";

  static String m10(ingredientName) =>
      "Ingrédient mis à jour: ${ingredientName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aHealthyCompostPileShouldBeWarmSlightlyDampAnd":
        MessageLookupByLibrary.simpleMessage(
          "Un tas de compost sain doit être chaud, légèrement humide et avoir une odeur de terre. Si le vôtre ne correspond pas à cette description, consultez les conseils de dépannage ci-dessus!",
        ),
    "aSimpleBalancedRecipeForGeneralGardenUse":
        MessageLookupByLibrary.simpleMessage(
          "Une recette simple et équilibrée pour un usage général au jardin.",
        ),
    "add": MessageLookupByLibrary.simpleMessage("Ajouter"),
    "addCarbonrichMaterialsDryLeavesStraw":
        MessageLookupByLibrary.simpleMessage(
          "Ajouter des matières riches en carbone (feuilles sèches, paille)",
        ),
    "addComponent": MessageLookupByLibrary.simpleMessage(
      "Ajouter un Composant",
    ),
    "addCustomIngredient": MessageLookupByLibrary.simpleMessage(
      "Ajouter un Ingrédient Personnalisé",
    ),
    "addIngredient": MessageLookupByLibrary.simpleMessage(
      "Ajouter un Ingrédient",
    ),
    "addMoreNitrogenrichMaterials": MessageLookupByLibrary.simpleMessage(
      "Ajouter plus de matières riches en azote",
    ),
    "addedCustomIngredient": m0,
    "aerobicCompostingProcess": MessageLookupByLibrary.simpleMessage(
      "Processus de Compostage Aérobie",
    ),
    "allAvailableComponentsHaveBeenAdded": MessageLookupByLibrary.simpleMessage(
      "Tous les composants disponibles ont été ajoutés",
    ),
    "allComponents": MessageLookupByLibrary.simpleMessage(
      "Tous les Composants",
    ),
    "allIngredients": MessageLookupByLibrary.simpleMessage(
      "Tous les Ingrédients",
    ),
    "ammoniaSmellTooMuchNitrogen": MessageLookupByLibrary.simpleMessage(
      "Odeur d\'ammoniac: Trop d\'azote",
    ),
    "april": MessageLookupByLibrary.simpleMessage("Avril"),
    "areYouSureDeleteIngredient": m1,
    "august": MessageLookupByLibrary.simpleMessage("Août"),
    "availabilityJanToDec": MessageLookupByLibrary.simpleMessage(
      "Disponible: Janvier à Décembre",
    ),
    "availabilityMarToAug": MessageLookupByLibrary.simpleMessage(
      "Disponible: Mars à Août",
    ),
    "availabilityMayToJul": MessageLookupByLibrary.simpleMessage(
      "Disponible: Mai à Juillet",
    ),
    "availabilityOctToDec": MessageLookupByLibrary.simpleMessage(
      "Disponible: Octobre à Décembre",
    ),
    "availabilityOctToJan": MessageLookupByLibrary.simpleMessage(
      "Disponible: Octobre à Janvier",
    ),
    "availabilitySepToDec": MessageLookupByLibrary.simpleMessage(
      "Disponible: Septembre à Décembre",
    ),
    "available": MessageLookupByLibrary.simpleMessage("Disponible:"),
    "avoidAddingMeatDairyOilsOrPetWaste": MessageLookupByLibrary.simpleMessage(
      "Éviter d\'ajouter de la viande, des produits laitiers, des huiles ou des déchets d\'animaux",
    ),
    "avoidAddingMeatDairyOrOils": MessageLookupByLibrary.simpleMessage(
      "Éviter d\'ajouter de la viande, des produits laitiers ou des huiles",
    ),
    "badOdors": MessageLookupByLibrary.simpleMessage("Mauvaises Odeurs"),
    "balanceCarbonDryBrownsAndNitrogenGreens": MessageLookupByLibrary.simpleMessage(
      "Équilibrer le carbone (matières brunes sèches) et l\'azote (matières vertes).",
    ),
    "basicGardenCompost": MessageLookupByLibrary.simpleMessage(
      "Compost de Jardin Basique",
    ),
    "breaksDownFastdecomposingMaterialsKillsPathogensWeedSeeds":
        MessageLookupByLibrary.simpleMessage(
          "Décompose les matières à décomposition rapide, tue les agents pathogènes et les graines de mauvaises herbes.",
        ),
    "browns": MessageLookupByLibrary.simpleMessage("Bruns"),
    "bucketNitrogenrichMaterialsGreens": MessageLookupByLibrary.simpleMessage(
      "1 seau de matières riches en azote (vertes)",
    ),
    "bucketsDryCarbonMaterialsBrowns": MessageLookupByLibrary.simpleMessage(
      "2 seaux de matières carbonées sèches (brunes)",
    ),
    "buryFoodScrapsInTheCenterOfThePile": MessageLookupByLibrary.simpleMessage(
      "Enterrer les restes alimentaires au centre du tas",
    ),
    "calcium": MessageLookupByLibrary.simpleMessage("CaO"),
    "calciumPercent": MessageLookupByLibrary.simpleMessage("Calcium %"),
    "canBeStoredFor6to12MonthsKeepDryToAvoid": MessageLookupByLibrary.simpleMessage(
      "Peut être stocké pendant 6 à 12 mois (garder au sec pour éviter la perte de nutriments).",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "carbonNitrogenRatio": MessageLookupByLibrary.simpleMessage("Ratio C:N"),
    "cashewShells": MessageLookupByLibrary.simpleMessage("Coques de cajou"),
    "checkMoistureAndAddWaterIfNeeded": MessageLookupByLibrary.simpleMessage(
      "Vérifier l\'humidité et ajouter de l\'eau si nécessaire",
    ),
    "checkReadiness": MessageLookupByLibrary.simpleMessage(
      "Vérifier la maturité",
    ),
    "chickenManure": MessageLookupByLibrary.simpleMessage("Fumier de poulet"),
    "chooseASite": MessageLookupByLibrary.simpleMessage("Choisir un site"),
    "chooseComponent": MessageLookupByLibrary.simpleMessage(
      "Choisir un Composant",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Fermer"),
    "cn": MessageLookupByLibrary.simpleMessage("C/N"),
    "cnRatioExplained": MessageLookupByLibrary.simpleMessage(
      "Explication du Ratio C:N:",
    ),
    "cnRatioOptimumCompostConditions": MessageLookupByLibrary.simpleMessage(
      "Ratio C:N & Conditions Optimales de Compost",
    ),
    "coldWeatherInsulateOrWaitForWarmerConditions":
        MessageLookupByLibrary.simpleMessage(
          "Temps froid (isoler ou attendre des conditions plus chaudes)",
        ),
    "commonCompostProblemsSolutions": MessageLookupByLibrary.simpleMessage(
      "Problèmes Courants de Compost & Solutions",
    ),
    "component": MessageLookupByLibrary.simpleMessage("Composant"),
    "componentCashewShells": MessageLookupByLibrary.simpleMessage(
      "Coques de cajou",
    ),
    "componentCassavaPeels": MessageLookupByLibrary.simpleMessage(
      "Épluchures de manioc",
    ),
    "componentChickenManure": MessageLookupByLibrary.simpleMessage(
      "Fumier de poulet séché",
    ),
    "componentCompostPlus": MessageLookupByLibrary.simpleMessage("Compost +"),
    "componentCornStraw": MessageLookupByLibrary.simpleMessage(
      "Paille de maïs",
    ),
    "componentCottonStraw": MessageLookupByLibrary.simpleMessage(
      "Paille de coton",
    ),
    "componentCowDung": MessageLookupByLibrary.simpleMessage("Bouse de vache"),
    "componentDolomites": MessageLookupByLibrary.simpleMessage("Dolomites"),
    "componentLime": MessageLookupByLibrary.simpleMessage("Chaux"),
    "componentMangoWaste": MessageLookupByLibrary.simpleMessage(
      "Déchets de mangue avec graines",
    ),
    "componentRiceChickenLitter": MessageLookupByLibrary.simpleMessage(
      "Litière (son de riz + fumier de poulet)",
    ),
    "componentRiceHulls": MessageLookupByLibrary.simpleMessage(
      "Balles de riz/Son de riz",
    ),
    "componentRiceHuskAsh": MessageLookupByLibrary.simpleMessage(
      "Cendre de balle de riz",
    ),
    "componentRiceStraw": MessageLookupByLibrary.simpleMessage(
      "Paille de riz - saison humide",
    ),
    "componentRiceStrawCounter": MessageLookupByLibrary.simpleMessage(
      "Paille de riz - contre-saison",
    ),
    "componentSugarcaneBagasse": MessageLookupByLibrary.simpleMessage(
      "Bagasse de canne à sucre",
    ),
    "components": MessageLookupByLibrary.simpleMessage("Composants"),
    "compostCalculator": MessageLookupByLibrary.simpleMessage(
      "Calculateur de Compost",
    ),
    "compostGuidelines": MessageLookupByLibrary.simpleMessage(
      "Directives de Compostage",
    ),
    "compostRecipeBuilder": MessageLookupByLibrary.simpleMessage(
      "Créateur de Recettes de Compost",
    ),
    "compostingHappensInFourStages": MessageLookupByLibrary.simpleMessage(
      "Le compostage se déroule en quatre étapes:",
    ),
    "compostingTimelineProcess": MessageLookupByLibrary.simpleMessage(
      "Processus Chronologique du Compostage",
    ),
    "contactOurSupportTeam": MessageLookupByLibrary.simpleMessage(
      "Contactez notre équipe de support:",
    ),
    "contentNotAvailable": MessageLookupByLibrary.simpleMessage(
      "Contenu non disponible",
    ),
    "cooling": MessageLookupByLibrary.simpleMessage("Refroidissement"),
    "coolingPhaseDays25to35": MessageLookupByLibrary.simpleMessage(
      "3. Phase de Refroidissement (Jours 25-35)",
    ),
    "costPerTon": MessageLookupByLibrary.simpleMessage("Coût/tonne"),
    "costTotal": MessageLookupByLibrary.simpleMessage("Coût Total"),
    "coverFoodScrapsWithBrowns": MessageLookupByLibrary.simpleMessage(
      "Couvrir les restes alimentaires avec des matières brunes",
    ),
    "cowDung": MessageLookupByLibrary.simpleMessage("Bouse de vache"),
    "currency": MessageLookupByLibrary.simpleMessage("Devise"),
    "currencyFCFA": MessageLookupByLibrary.simpleMessage("FCFA"),
    "day1": MessageLookupByLibrary.simpleMessage("Jour 1"),
    "day25": MessageLookupByLibrary.simpleMessage("Jour 25"),
    "day35": MessageLookupByLibrary.simpleMessage("Jour 35"),
    "day5": MessageLookupByLibrary.simpleMessage("Jour 5"),
    "day60": MessageLookupByLibrary.simpleMessage("Jour 60+"),
    "days25to35": MessageLookupByLibrary.simpleMessage("Jours 25-35"),
    "days2to5": MessageLookupByLibrary.simpleMessage("Jours 2-5"),
    "days35to60": MessageLookupByLibrary.simpleMessage("Jours 35-60+"),
    "days5to25": MessageLookupByLibrary.simpleMessage("Jours 5-25"),
    "december": MessageLookupByLibrary.simpleMessage("Décembre"),
    "delete": MessageLookupByLibrary.simpleMessage("Supprimer"),
    "deleteCustomIngredient": MessageLookupByLibrary.simpleMessage(
      "Supprimer l\'Ingrédient Personnalisé",
    ),
    "deletedIngredient": m2,
    "dryLeaves": MessageLookupByLibrary.simpleMessage("Feuilles sèches"),
    "dryMatter": MessageLookupByLibrary.simpleMessage("Matière Sèche"),
    "dryMatterPercent": MessageLookupByLibrary.simpleMessage("Matière Sèche %"),
    "editAvailability": MessageLookupByLibrary.simpleMessage(
      "Modifier la disponibilité",
    ),
    "editAvailabilityFor": m3,
    "editComponent": MessageLookupByLibrary.simpleMessage(
      "Modifier le Composant",
    ),
    "editCustomIngredient": MessageLookupByLibrary.simpleMessage(
      "Modifier l\'Ingrédient Personnalisé",
    ),
    "endMonth": MessageLookupByLibrary.simpleMessage("Mois de fin"),
    "exposedFoodScraps": MessageLookupByLibrary.simpleMessage(
      "Restes alimentaires exposés",
    ),
    "fastHotCompost": MessageLookupByLibrary.simpleMessage(
      "Compost Chaud Rapide",
    ),
    "february": MessageLookupByLibrary.simpleMessage("Février"),
    "forWhenYouNeedCompostQuickly": MessageLookupByLibrary.simpleMessage(
      "Pour quand vous avez besoin de compost rapidement.",
    ),
    "freshPlant": MessageLookupByLibrary.simpleMessage("Plantes fraîches"),
    "getHelp": MessageLookupByLibrary.simpleMessage("Obtenir de l\'aide"),
    "getTranslation": m4,
    "greens": MessageLookupByLibrary.simpleMessage("Verts"),
    "heating": MessageLookupByLibrary.simpleMessage("Chauffage"),
    "heatingPhaseDays5to25": MessageLookupByLibrary.simpleMessage(
      "2. Phase de Chauffage (Jours 5-25)",
    ),
    "helpEmailSubjectInstruction": MessageLookupByLibrary.simpleMessage(
      "Veuillez inclure \"Compost Calculator App - Help Request\" dans l\'objet de votre email.",
    ),
    "highCarbon": MessageLookupByLibrary.simpleMessage("Riche en Carbone"),
    "highNitrogen": MessageLookupByLibrary.simpleMessage("Riche en Azote"),
    "howToMakeCompost": MessageLookupByLibrary.simpleMessage(
      "Comment Faire du Compost",
    ),
    "idealCarbonnitrogenRatio30to1": MessageLookupByLibrary.simpleMessage(
      "Ratio idéal Carbone:Azote = 30:1",
    ),
    "increasePileSize": MessageLookupByLibrary.simpleMessage(
      "Augmenter la taille du tas",
    ),
    "ingredient": MessageLookupByLibrary.simpleMessage("Ingrédient"),
    "ingredientName": MessageLookupByLibrary.simpleMessage(
      "Nom de l\'Ingrédient",
    ),
    "ingredientNoLongerExists": m5,
    "ingredients": MessageLookupByLibrary.simpleMessage("Ingrédients"),
    "instructions": MessageLookupByLibrary.simpleMessage("Instructions"),
    "january": MessageLookupByLibrary.simpleMessage("Janvier"),
    "july": MessageLookupByLibrary.simpleMessage("Juillet"),
    "june": MessageLookupByLibrary.simpleMessage("Juin"),
    "keepItLikeADampSpongeNotTooDry": MessageLookupByLibrary.simpleMessage(
      "Garder comme une éponge humide (ni trop sec ni détrempé).",
    ),
    "keyNeedsWaterOxygenSmallsizedOrganicMatter":
        MessageLookupByLibrary.simpleMessage(
          "Besoins essentiels: Eau, oxygène, matière organique de petite taille.",
        ),
    "layerIngredientsMoistenAndTurnEvery12WeeksReadyIn":
        MessageLookupByLibrary.simpleMessage(
          "Disposer les ingrédients en couches, humidifier et retourner toutes les 1-2 semaines. Prêt en 3-6 mois.",
        ),
    "layerMaterials": MessageLookupByLibrary.simpleMessage(
      "Disposer en couches",
    ),
    "magnesium": MessageLookupByLibrary.simpleMessage("MgO"),
    "magnesiumPercent": MessageLookupByLibrary.simpleMessage("Magnésium %"),
    "maintainMoisture": MessageLookupByLibrary.simpleMessage(
      "Maintenir l\'humidité",
    ),
    "march": MessageLookupByLibrary.simpleMessage("Mars"),
    "maturationPhaseDays35to60": MessageLookupByLibrary.simpleMessage(
      "4. Phase de Maturation (Jours 35-60+)",
    ),
    "maturing": MessageLookupByLibrary.simpleMessage("Maturation"),
    "may": MessageLookupByLibrary.simpleMessage("Mai"),
    "meatDairyOrFattyFoodsInCompost": MessageLookupByLibrary.simpleMessage(
      "Viande, produits laitiers ou aliments gras dans le compost",
    ),
    "microorganismsBeginBreakingDownWaste":
        MessageLookupByLibrary.simpleMessage(
          "Les micro-organismes commencent à décomposer les déchets.",
        ),
    "mixEvery714DaysForAeration": MessageLookupByLibrary.simpleMessage(
      "Mélanger tous les 7 à 14 jours pour l\'aération.",
    ),
    "mixThoroughlyEnsureAdequateMoistureAndTurnEvery3Days":
        MessageLookupByLibrary.simpleMessage(
          "Mélanger soigneusement, assurer une humidité adéquate et retourner tous les 3 jours. Peut être prêt en 3-4 semaines si les conditions sont idéales.",
        ),
    "needAssistanceWithCompostCalculator": MessageLookupByLibrary.simpleMessage(
      "Besoin d\'aide avec le Calculateur de Compost?",
    ),
    "nitrogen": MessageLookupByLibrary.simpleMessage("N"),
    "nitrogenPercent": MessageLookupByLibrary.simpleMessage("Azote %"),
    "noComponentsAddedYetClickTheButtonBelowToAdd":
        MessageLookupByLibrary.simpleMessage(
          "Aucun composant ajouté. Cliquez sur le bouton ci-dessous pour ajouter des composants à votre recette de compost.",
        ),
    "notEnoughNitrogenAddGreens": MessageLookupByLibrary.simpleMessage(
      "Pas assez d\'azote (ajouter des \'verts\')",
    ),
    "november": MessageLookupByLibrary.simpleMessage("Novembre"),
    "nutrientAnalysis": MessageLookupByLibrary.simpleMessage(
      "Analyse des Nutriments",
    ),
    "nutrientContentPercent": MessageLookupByLibrary.simpleMessage(
      "Contenu Nutritif (%)",
    ),
    "nutrientInOptimalRange": m6,
    "october": MessageLookupByLibrary.simpleMessage("Octobre"),
    "optimumMoisture": MessageLookupByLibrary.simpleMessage(
      "Humidité Optimale",
    ),
    "organicCarbon": MessageLookupByLibrary.simpleMessage("C Org"),
    "organicCarbonPercent": MessageLookupByLibrary.simpleMessage(
      "Carbone Organique %",
    ),
    "organismsChangeAsConditionsShift": MessageLookupByLibrary.simpleMessage(
      "Les organismes changent au fur et à mesure que les conditions évoluent.",
    ),
    "otherMaterialsMeatDairyEtc": MessageLookupByLibrary.simpleMessage(
      "Matières \'autres\' (viande, produits laitiers, etc.)",
    ),
    "oxygenRequirements": MessageLookupByLibrary.simpleMessage(
      "Besoins en Oxygène",
    ),
    "partChickenManure": MessageLookupByLibrary.simpleMessage(
      "1 part de fumier de poulet",
    ),
    "partFreshGrassClippings": MessageLookupByLibrary.simpleMessage(
      "1 part de tontes de gazon fraîches",
    ),
    "partGreenGardenWasteChoppedSmall": MessageLookupByLibrary.simpleMessage(
      "1 part de déchets verts de jardin (finement hachés)",
    ),
    "partVegetableScraps": MessageLookupByLibrary.simpleMessage(
      "1 part de restes de légumes",
    ),
    "partsChoppedStrawOrWoodChips": MessageLookupByLibrary.simpleMessage(
      "2 parts de paille hachée ou de copeaux de bois",
    ),
    "partsDryLeaves": MessageLookupByLibrary.simpleMessage(
      "3 parts de feuilles sèches",
    ),
    "percentage": m7,
    "pestsInTheCompost": MessageLookupByLibrary.simpleMessage(
      "Nuisibles dans le Compost",
    ),
    "phosphorus": MessageLookupByLibrary.simpleMessage("P₂O₅"),
    "phosphorusPercent": MessageLookupByLibrary.simpleMessage("Phosphore %"),
    "pileIsFinishedComposting": MessageLookupByLibrary.simpleMessage(
      "Le tas a fini de composter",
    ),
    "pileIsTooWetdry": MessageLookupByLibrary.simpleMessage(
      "Le Tas est Trop Humide/Sec",
    ),
    "pileIsntHeatingUp": MessageLookupByLibrary.simpleMessage(
      "Le Tas ne Chauffe Pas",
    ),
    "pileNotHotEnough": MessageLookupByLibrary.simpleMessage(
      "Tas pas assez chaud",
    ),
    "pileTooSmallShouldBeAtLeast3x3x3Feet":
        MessageLookupByLibrary.simpleMessage(
          "Tas trop petit (devrait être d\'au moins 1m×1m×1m)",
        ),
    "pleaseEnterIngredientName": MessageLookupByLibrary.simpleMessage(
      "Veuillez entrer un nom d\'ingrédient",
    ),
    "pleaseEnterValidWeight": MessageLookupByLibrary.simpleMessage(
      "Veuillez entrer un poids valide",
    ),
    "pleaseFillAllFields": MessageLookupByLibrary.simpleMessage(
      "Veuillez remplir tous les champs",
    ),
    "possibleCauses": MessageLookupByLibrary.simpleMessage("Causes Possibles"),
    "potassium": MessageLookupByLibrary.simpleMessage("K₂O"),
    "potassiumPercent": MessageLookupByLibrary.simpleMessage("Potassium %"),
    "price": m8,
    "pricePageTitle": MessageLookupByLibrary.simpleMessage(
      "Prix des Ingrédients",
    ),
    "pricePerTonCFA": MessageLookupByLibrary.simpleMessage(
      "Prix par Tonne (FCFA)",
    ),
    "prices": MessageLookupByLibrary.simpleMessage("Prix"),
    "quickCheck": MessageLookupByLibrary.simpleMessage("Vérification Rapide"),
    "readyWhenDarkEarthySmellNoHeatInTheCenter":
        MessageLookupByLibrary.simpleMessage(
          "Prêt quand: Sombre, odeur de terre, pas de chaleur au centre.",
        ),
    "recipeBuilder": MessageLookupByLibrary.simpleMessage(
      "Créateur de Recettes",
    ),
    "recipeQualityGuide": MessageLookupByLibrary.simpleMessage(
      "Guide de Qualité des Recettes",
    ),
    "recipeQualityInfo": MessageLookupByLibrary.simpleMessage(
      "Coche verte: Niveau de nutriment dans la plage recommandée\nFlèche rouge vers le haut: Niveau de nutriment en dessous de la plage recommandée\nFlèche orange vers le bas: Niveau de nutriment au-dessus de la plage recommandée\n\nLes plages recommandées sont basées sur les normes de compost municipal.",
    ),
    "regularTurningEvery12WeeksEnsuresProperOxygenFlowFor":
        MessageLookupByLibrary.simpleMessage(
          "Le retournement régulier (toutes les 1-2 semaines) assure un bon flux d\'oxygène pour la décomposition aérobie.",
        ),
    "removedDeletedIngredientSingle": MessageLookupByLibrary.simpleMessage(
      "1 ingrédient supprimé retiré de la recette",
    ),
    "removedDeletedIngredientsMultiple": m9,
    "riceHusks": MessageLookupByLibrary.simpleMessage("Balles de riz"),
    "rottenEggSmellAnaerobicConditionsNotEnoughOxygen":
        MessageLookupByLibrary.simpleMessage(
          "Odeur d\'œuf pourri: Conditions anaérobies (pas assez d\'oxygène)",
        ),
    "sampleCompostRecipes": MessageLookupByLibrary.simpleMessage(
      "Exemples de Recettes de Compost",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Sauvegarder"),
    "september": MessageLookupByLibrary.simpleMessage("Septembre"),
    "simpleRule": MessageLookupByLibrary.simpleMessage("Règle simple:"),
    "slowerDecompositionFungiBreakDownTougherMaterialsStrawWood":
        MessageLookupByLibrary.simpleMessage(
          "Décomposition plus lente, les champignons décomposent les matières plus résistantes (paille, bois).",
        ),
    "soilOrganismsReturnNutrientsStabilizeHumusForms":
        MessageLookupByLibrary.simpleMessage(
          "Les organismes du sol reviennent, les nutriments se stabilisent, l\'humus se forme.",
        ),
    "solutions": MessageLookupByLibrary.simpleMessage("Solutions:"),
    "startMonth": MessageLookupByLibrary.simpleMessage("Mois de début"),
    "startup": MessageLookupByLibrary.simpleMessage("Démarrage"),
    "startupDays2to5": MessageLookupByLibrary.simpleMessage(
      "1. Démarrage (Jours 2-5)",
    ),
    "temperature20to40c": MessageLookupByLibrary.simpleMessage(
      "Température: 20–40°C",
    ),
    "temperature20to45c": MessageLookupByLibrary.simpleMessage(
      "Température: 20–45°C",
    ),
    "temperature25to45c": MessageLookupByLibrary.simpleMessage(
      "Température: 25–45°C",
    ),
    "temperature45to65c": MessageLookupByLibrary.simpleMessage(
      "Température: 45–65°C",
    ),
    "thePileShrinksAsMaterialDecomposes": MessageLookupByLibrary.simpleMessage(
      "Le tas rétrécit à mesure que la matière se décompose.",
    ),
    "thisAppIsDesignedToHelpYouCreateAndManage":
        MessageLookupByLibrary.simpleMessage(
          "Cette application est conçue pour vous aider à créer et gérer le compostage aérobie en tas. Utilisez les outils ci-dessous pour en apprendre davantage sur le compostage, explorer des recettes ou créer les vôtres!",
        ),
    "to": MessageLookupByLibrary.simpleMessage("à"),
    "tooDryAddFreshGreenMaterials": MessageLookupByLibrary.simpleMessage(
      "Trop sec: Ajouter des matières \'vertes\' fraîches",
    ),
    "tooDryAddWater": MessageLookupByLibrary.simpleMessage(
      "Trop sec (ajouter de l\'eau)",
    ),
    "tooDryAddWaterWhileTurningThePile": MessageLookupByLibrary.simpleMessage(
      "Trop sec: Ajouter de l\'eau en retournant le tas",
    ),
    "tooDryNotEnoughWaterTooMuchSunExposure":
        MessageLookupByLibrary.simpleMessage(
          "Trop sec: Pas assez d\'eau, trop d\'exposition au soleil",
        ),
    "tooMuchCarbonDecompositionSlowsDown": MessageLookupByLibrary.simpleMessage(
      "Trop de carbone? La décomposition ralentit.",
    ),
    "tooMuchNitrogenSmellySoggyPile": MessageLookupByLibrary.simpleMessage(
      "Trop d\'azote? Tas malodorant et détrempé.",
    ),
    "tooWetAddDryCarbonrichMaterials": MessageLookupByLibrary.simpleMessage(
      "Trop humide: Ajouter des matières sèches riches en carbone",
    ),
    "tooWetCoverDuringHeavyRains": MessageLookupByLibrary.simpleMessage(
      "Trop humide: Couvrir pendant les fortes pluies",
    ),
    "tooWetSoggyMaterialsPoorDrainage": MessageLookupByLibrary.simpleMessage(
      "Trop humide: Matières détrempées, mauvais drainage",
    ),
    "tooWetTurnThePileToHelpItDryOut": MessageLookupByLibrary.simpleMessage(
      "Trop humide: Retourner le tas pour aider à le sécher",
    ),
    "totalCostFCFA": MessageLookupByLibrary.simpleMessage("Coût Total (FCFA)"),
    "totalWeightKg": MessageLookupByLibrary.simpleMessage("Poids Total (kg)"),
    "troubleshootingCompostProblems": MessageLookupByLibrary.simpleMessage(
      "Résolution des Problèmes de Compost",
    ),
    "turnPileRegularlyToMaintainHeat": MessageLookupByLibrary.simpleMessage(
      "Retourner le tas régulièrement pour maintenir la chaleur",
    ),
    "turnThePileRegularly": MessageLookupByLibrary.simpleMessage(
      "Retourner le tas régulièrement",
    ),
    "turnThePileToAddOxygen": MessageLookupByLibrary.simpleMessage(
      "Retourner le tas pour ajouter de l\'oxygène",
    ),
    "turnThePileToIncreaseOxygen": MessageLookupByLibrary.simpleMessage(
      "Retourner le tas pour augmenter l\'oxygène",
    ),
    "unitKgs": MessageLookupByLibrary.simpleMessage("kg"),
    "unitTons": MessageLookupByLibrary.simpleMessage("tonnes"),
    "update": MessageLookupByLibrary.simpleMessage("Mettre à jour"),
    "updatedIngredient": m10,
    "useARodentresistantBinIfNecessary": MessageLookupByLibrary.simpleMessage(
      "Utiliser un bac résistant aux rongeurs si nécessaire",
    ),
    "visualTip": MessageLookupByLibrary.simpleMessage("Conseil Visuel"),
    "water": MessageLookupByLibrary.simpleMessage("Eau"),
    "weight": MessageLookupByLibrary.simpleMessage("Poids (kg)"),
    "welcomeToCompostCalculator": MessageLookupByLibrary.simpleMessage(
      "Bienvenue au Calculateur de Compost",
    ),
    "welldrainedShadyNearAWaterSource": MessageLookupByLibrary.simpleMessage(
      "Bien drainé, ombragé, près d\'une source d\'eau.",
    ),
    "whenDarkCrumblyAndSmellsEarthyItsDone":
        MessageLookupByLibrary.simpleMessage(
          "Quand il est sombre, friable et sent la terre, c\'est prêt!",
        ),
    "yourCompostPileShouldBeLargeEnoughToMaintainHeat":
        MessageLookupByLibrary.simpleMessage(
          "Votre tas de compost doit être assez grand pour maintenir la chaleur (au moins 1m×1m×1m), mais assez petit pour être facilement retourné et géré.",
        ),
    "yourCompostShouldHaveTheMoistureLevelOfAWrungout":
        MessageLookupByLibrary.simpleMessage(
          "Votre compost doit avoir le niveau d\'humidité d\'une éponge essorée - humide mais pas détrempé.",
        ),
  };
}
