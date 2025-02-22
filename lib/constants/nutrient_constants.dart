import '../generated/l10n.dart';

class NutrientConstants {
  static const List<String> trackedNutrients = [
    'dryMatter',
    'organicCarbon',
    'nitrogen',
    'phosphorus',
    'potassium',
    'calcium',
    'magnesium',
  ];

  static String getNutrientLabel(String nutrient) {
    switch (nutrient) {
      case 'organicCarbon':
        return S.current.organicCarbon;
      case 'nitrogen':
        return S.current.nitrogen;
      case 'phosphorus':
        return S.current.phosphorus;
      case 'potassium':
        return S.current.potassium;
      case 'calcium':
        return S.current.calcium;
      case 'magnesium':
        return S.current.magnesium;
      case 'dryMatter':
        return S.current.dryMatter;
      default:
        return nutrient;
    }
  }
}
