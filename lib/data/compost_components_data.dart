import '../models/compost_component_model.dart';
import '../models/availability_model.dart';
import '../models/nutrient_content_model.dart';
import '../models/price_model.dart';

class CompostComponentsData {
  static final List<CompostComponent> components = [
    const CompostComponent(
      id: 'MangoWaste',
      name: 'Mango waste with seeds',
      availability: AvailabilityPeriod.marToAug,
      nutrients: NutrientContent(
        dryMatterPercent: 28.37 / 100,
        organicCarbonPercent: 21.00 / 100,
        nitrogenPercent: 0.78 / 100,
        phosphorusPercent: 0.24 / 100,
        potassiumPercent: 0.53 / 100,
        calciumPercent: 0.55 / 100,
        magnesiumPercent: 0.37 / 100,
        carbonNitrogenRatio: 26.92,
      ),
    ),
    const CompostComponent(
      id: 'CashewShells',
      name: 'Cashew shells',
      availability: AvailabilityPeriod.janToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 80.00 / 100,
        organicCarbonPercent: 51.00 / 100,
        nitrogenPercent: 0.74 / 100,
        phosphorusPercent: 0.21 / 100,
        potassiumPercent: 0.70 / 100,
        calciumPercent: 0.24 / 100,
        magnesiumPercent: 0.19 / 100,
        carbonNitrogenRatio: 68.92,
      ),
    ),
    CompostComponent(
      id: 'RiceHulls',
      name: 'Rice hulls/Rice bran',
      availability: AvailabilityPeriod.janToDec,
      nutrients: const NutrientContent(
        dryMatterPercent: 92.80 / 100,
        organicCarbonPercent: 34.90 / 100,
        nitrogenPercent: 0.27 / 100,
        phosphorusPercent: 0.09 / 100,
        potassiumPercent: 1.80 / 100,
        calciumPercent: 0.29 / 100,
        magnesiumPercent: 0.19 / 100,
        carbonNitrogenRatio: 129.26,
      ),
      price: Price(
        priceInFCFA: 70000,
        unit: 'tons',
        unitAmount: 1,
        pricePerUnit: 70000,
      ),
    ),
    const CompostComponent(
      id: 'RiceStraw',
      name: 'Rice straw - wet season',
      availability: AvailabilityPeriod.octToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 85.00 / 100,
        organicCarbonPercent: 51.76 / 100,
        nitrogenPercent: 0.65 / 100,
        phosphorusPercent: 0.20 / 100,
        potassiumPercent: 0.30 / 100,
        calciumPercent: 0.29 / 100,
        magnesiumPercent: 0.15 / 100,
        carbonNitrogenRatio: 79.63,
      ),
    ),
    const CompostComponent(
      id: 'SugarcaneBagasse',
      name: 'Sugarcane bagasse',
      availability: AvailabilityPeriod.octToJan,
      nutrients: NutrientContent(
        dryMatterPercent: 30.20 / 100,
        organicCarbonPercent: 5.70 / 100,
        nitrogenPercent: 0.58 / 100,
        phosphorusPercent: 0.11 / 100,
        potassiumPercent: 2.79 / 100,
        calciumPercent: 0.16 / 100,
        magnesiumPercent: 0.15 / 100,
        carbonNitrogenRatio: 9.83,
      ),
    ),
    CompostComponent(
      id: 'ChickenManure',
      name: 'Dried chicken manure',
      availability: AvailabilityPeriod.janToDec,
      nutrients: const NutrientContent(
        dryMatterPercent: 87.60 / 100,
        organicCarbonPercent: 51.64 / 100,
        nitrogenPercent: 5.35 / 100,
        phosphorusPercent: 2.60 / 100,
        potassiumPercent: 2.20 / 100,
        calciumPercent: 5.04 / 100,
        magnesiumPercent: 0.63 / 100,
        carbonNitrogenRatio: 9.65,
      ),
      price: Price(
        priceInFCFA: 20000,
        unit: 'kgs',
        unitAmount: 100,
        pricePerUnit: 2000,
      ),
    ),
    const CompostComponent(
      id: 'CowDung',
      name: 'Cow dung',
      availability: AvailabilityPeriod.janToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 16.70 / 100,
        organicCarbonPercent: 37.93 / 100,
        nitrogenPercent: 3.00 / 100,
        phosphorusPercent: 2.00 / 100,
        potassiumPercent: 1.00 / 100,
        calciumPercent: 5.04 / 100,
        magnesiumPercent: 0.63 / 100,
        carbonNitrogenRatio: 12.64,
      ),
    ),
    const CompostComponent(
      id: 'CottonStraw',
      name: 'Cotton straw',
      availability: AvailabilityPeriod.octToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 75.70 / 100,
        organicCarbonPercent: 51.00 / 100,
        nitrogenPercent: 1.00 / 100,
        phosphorusPercent: 0.08 / 100,
        potassiumPercent: 0.61 / 100,
        calciumPercent: 0.48 / 100,
        magnesiumPercent: 0.12 / 100,
        carbonNitrogenRatio: 25.00,
      ),
    ),
    CompostComponent(
      id: 'RiceHuskAsh',
      name: 'Rice Husk Ash',
      availability: AvailabilityPeriod.janToDec,
      nutrients: const NutrientContent(
        dryMatterPercent: 100.00 / 100,
        organicCarbonPercent: 0.22 / 100,
        nitrogenPercent: 0.09 / 100,
        phosphorusPercent: 0.01 / 100,
        potassiumPercent: 0.08 / 100,
        calciumPercent: 0.90 / 100,
        magnesiumPercent: 0.00 / 100,
        carbonNitrogenRatio: 2.44,
      ),
      price: Price(
        priceInFCFA: 100000,
        unit: 'kgs',
        unitAmount: 50,
        pricePerUnit: 5000,
      ),
    ),
    CompostComponent(
      id: 'Lime',
      name: 'Lime',
      availability: AvailabilityPeriod.janToDec,
      nutrients: const NutrientContent(
        dryMatterPercent: 100.00 / 100,
        organicCarbonPercent: 0.00 / 100,
        nitrogenPercent: 0.00 / 100,
        phosphorusPercent: 0.00 / 100,
        potassiumPercent: 0.00 / 100,
        calciumPercent: 38.00 / 100,
        magnesiumPercent: 0.00 / 100,
        carbonNitrogenRatio: 0.00,
      ),
      price: Price(
        priceInFCFA: 20000,
        unit: 'kgs',
        unitAmount: 25,
        pricePerUnit: 5000,
      ),
    ),
    CompostComponent(
      id: 'CompostPlus',
      name: 'Compost +',
      availability: AvailabilityPeriod.janToDec,
      nutrients: const NutrientContent(
        dryMatterPercent: 100.00 / 100,
        organicCarbonPercent: 0.00 / 100,
        nitrogenPercent: 0.00 / 100,
        phosphorusPercent: 0.00 / 100,
        potassiumPercent: 0.00 / 100,
        calciumPercent: 0.00 / 100,
        magnesiumPercent: 0.00 / 100,
        carbonNitrogenRatio: 0.00,
      ),
      price: Price(
        priceInFCFA: 10000,
        unit: 'kgs',
        unitAmount: 2.5,
        pricePerUnit: 2500,
      ),
    ),
    CompostComponent(
      id: 'Dolomites',
      name: 'Dolomites',
      availability: AvailabilityPeriod.janToDec,
      nutrients: const NutrientContent(
        dryMatterPercent: 100.00 / 100,
        organicCarbonPercent: 0.00 / 100,
        nitrogenPercent: 0.00 / 100,
        phosphorusPercent: 0.00 / 100,
        potassiumPercent: 0.00 / 100,
        calciumPercent: 38.00 / 100,
        magnesiumPercent: 5.00 / 100,
        carbonNitrogenRatio: 0.00,
      ),
      price: Price(
        priceInFCFA: 35000,
        unit: 'kgs',
        unitAmount: 25,
        pricePerUnit: 1750,
      ),
    ),
    const CompostComponent(
      id: 'CornStraw',
      name: 'Corn straw',
      availability: AvailabilityPeriod.octToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 80.45 / 100,
        organicCarbonPercent: 46.66 / 100,
        nitrogenPercent: 1.80 / 100,
        phosphorusPercent: 0.41 / 100,
        potassiumPercent: 0.81 / 100,
        calciumPercent: 0.27 / 100,
        magnesiumPercent: 0.02 / 100,
        carbonNitrogenRatio: 25.90,
      ),
    ),
    const CompostComponent(
      id: 'CassavaPeels',
      name: 'Cassava peels',
      availability: AvailabilityPeriod.octToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 27.20 / 100,
        organicCarbonPercent: 43.60 / 100,
        nitrogenPercent: 0.90 / 100,
        phosphorusPercent: 0.21 / 100,
        potassiumPercent: 0.64 / 100,
        calciumPercent: 0.17 / 100,
        magnesiumPercent: 0.06 / 100,
        carbonNitrogenRatio: 48.40,
      ),
    ),
    CompostComponent(
      id: 'RiceChickenLitter',
      name: 'Litter (rice bran + chicken manure)',
      availability: AvailabilityPeriod.sepToDec,
      nutrients: const NutrientContent(
        dryMatterPercent: 90.20 / 100,
        organicCarbonPercent: 43.27 / 100,
        nitrogenPercent: 2.81 / 100,
        phosphorusPercent: 1.35 / 100,
        potassiumPercent: 2.00 / 100,
        calciumPercent: 2.67 / 100,
        magnesiumPercent: 0.41 / 100,
        carbonNitrogenRatio: 15.40,
      ),
      price: Price(
        priceInFCFA: 10000,
        unit: 'kgs',
        unitAmount: 100,
        pricePerUnit: 1000,
      ),
    ),
    const CompostComponent(
      id: 'RiceStrawCounter',
      name: 'Rice straw - counter-season',
      availability: AvailabilityPeriod.mayToJul,
      nutrients: NutrientContent(
        dryMatterPercent: 85.00 / 100,
        organicCarbonPercent: 51.76 / 100,
        nitrogenPercent: 0.65 / 100,
        phosphorusPercent: 0.20 / 100,
        potassiumPercent: 0.30 / 100,
        calciumPercent: 0.29 / 100,
        magnesiumPercent: 0.15 / 100,
        carbonNitrogenRatio: 79.63,
      ),
    ),
  ];

  /// Get available components for a specific date
  static List<CompostComponent> getAvailableComponents(DateTime date) {
    return components
        .where((component) => component.isAvailableOn(date))
        .toList();
  }

  /// Get components with prices
  static List<CompostComponent> getPricedComponents() {
    return components.where((component) => component.price != null).toList();
  }

  /// Get components by nutrient threshold
  static List<CompostComponent> getComponentsByNutrientThreshold({
    required String nutrient,
    required double threshold,
    bool above = true,
  }) {
    return components.where((component) {
      final nutrientContent = component.nutrients.toMap()[nutrient] ?? 0.0;
      return above
          ? nutrientContent >= threshold
          : nutrientContent <= threshold;
    }).toList();
  }
}
