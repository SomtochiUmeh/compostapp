import '../models/compost_component_model.dart';
import '../models/availability_model.dart';
import '../models/nutrient_content_model.dart';
import '../models/price_model.dart';

class CompostComponentsData {
  static final List<CompostComponent> components = [
    const CompostComponent(
      name: 'Mango waste with seeds',
      availability: AvailabilityPeriod.marToAug,
      nutrients: NutrientContent(
        dryMatterPercent: 28.37,
        organicCarbonPercent: 21.00,
        nitrogenPercent: 0.78,
        phosphorusPercent: 0.24,
        potassiumPercent: 0.53,
        calciumPercent: 0.55,
        magnesiumPercent: 0.37,
        carbonNitrogenRatio: 26.92,
      ),
      unit: 'tons',
    ),
    const CompostComponent(
      name: 'Cashew shells',
      availability: AvailabilityPeriod.janToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 80.00,
        organicCarbonPercent: 51.00,
        nitrogenPercent: 0.74,
        phosphorusPercent: 0.21,
        potassiumPercent: 0.70,
        calciumPercent: 0.24,
        magnesiumPercent: 0.19,
        carbonNitrogenRatio: 68.92,
      ),
      unit: 'tons',
    ),
    const CompostComponent(
      name: 'Rice hulls/Rice bran',
      availability: AvailabilityPeriod.janToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 92.80,
        organicCarbonPercent: 34.90,
        nitrogenPercent: 0.27,
        phosphorusPercent: 0.09,
        potassiumPercent: 1.80,
        calciumPercent: 0.29,
        magnesiumPercent: 0.19,
        carbonNitrogenRatio: 129.26,
      ),
      unit: 'tons',
      price: Price(
        priceInFCFA: 70000,
        unit: 'tons',
        unitAmount: 1,
        pricePerUnit: 70000,
      ),
    ),
    const CompostComponent(
      name: 'Rice straw - wet season',
      availability: AvailabilityPeriod.octToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 85.00,
        organicCarbonPercent: 51.76,
        nitrogenPercent: 0.65,
        phosphorusPercent: 0.20,
        potassiumPercent: 0.30,
        calciumPercent: 0.29,
        magnesiumPercent: 0.15,
        carbonNitrogenRatio: 79.63,
      ),
      unit: 'tons',
    ),
    const CompostComponent(
      name: 'Sugarcane bagasse',
      availability: AvailabilityPeriod.octToJan,
      nutrients: NutrientContent(
        dryMatterPercent: 30.20,
        organicCarbonPercent: 5.70,
        nitrogenPercent: 0.58,
        phosphorusPercent: 0.11,
        potassiumPercent: 2.79,
        calciumPercent: 0.16,
        magnesiumPercent: 0.15,
        carbonNitrogenRatio: 9.83,
      ),
      unit: 'tons',
    ),
    const CompostComponent(
      name: 'Dried chicken manure',
      availability: AvailabilityPeriod.janToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 87.60,
        organicCarbonPercent: 51.64,
        nitrogenPercent: 5.35,
        phosphorusPercent: 2.60,
        potassiumPercent: 2.20,
        calciumPercent: 5.04,
        magnesiumPercent: 0.63,
        carbonNitrogenRatio: 9.65,
      ),
      unit: 'tons',
      price: Price(
        priceInFCFA: 20000,
        unit: 'Kgs',
        unitAmount: 100,
        pricePerUnit: 2000,
      ),
    ),
    const CompostComponent(
      name: 'Cow dung',
      availability: AvailabilityPeriod.janToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 16.70,
        organicCarbonPercent: 37.93,
        nitrogenPercent: 3.00,
        phosphorusPercent: 2.00,
        potassiumPercent: 1.00,
        calciumPercent: 5.04,
        magnesiumPercent: 0.63,
        carbonNitrogenRatio: 12.64,
      ),
      unit: 'tons',
    ),
    const CompostComponent(
      name: 'Cotton straw',
      availability: AvailabilityPeriod.octToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 75.70,
        organicCarbonPercent: 51.00,
        nitrogenPercent: 1.00,
        phosphorusPercent: 0.08,
        potassiumPercent: 0.61,
        calciumPercent: 0.48,
        magnesiumPercent: 0.12,
        carbonNitrogenRatio: 25.00,
      ),
      unit: 'tons',
    ),
    const CompostComponent(
      name: 'Rice Husk Ash',
      availability: AvailabilityPeriod.janToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 100.00,
        organicCarbonPercent: 0.22,
        nitrogenPercent: 0.09,
        phosphorusPercent: 0.01,
        potassiumPercent: 0.08,
        calciumPercent: 0.90,
        magnesiumPercent: 0.00,
        carbonNitrogenRatio: 2.44,
      ),
      unit: 'tons',
      price: Price(
        priceInFCFA: 100000,
        unit: 'Kgs',
        unitAmount: 50,
        pricePerUnit: 5000,
      ),
    ),
    const CompostComponent(
      name: 'Lime',
      availability: AvailabilityPeriod.janToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 100.00,
        organicCarbonPercent: 0.00,
        nitrogenPercent: 0.00,
        phosphorusPercent: 0.00,
        potassiumPercent: 0.00,
        calciumPercent: 38.00,
        magnesiumPercent: 0.00,
        carbonNitrogenRatio: 0.00,
      ),
      unit: 'tons',
      price: Price(
        priceInFCFA: 20000,
        unit: 'kgs',
        unitAmount: 25,
        pricePerUnit: 5000,
      ),
    ),
    const CompostComponent(
      name: 'Compost +',
      availability: AvailabilityPeriod.janToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 100.00,
        organicCarbonPercent: 0.00,
        nitrogenPercent: 0.00,
        phosphorusPercent: 0.00,
        potassiumPercent: 0.00,
        calciumPercent: 0.00,
        magnesiumPercent: 0.00,
        carbonNitrogenRatio: 0.00,
      ),
      unit: 'tons',
      price: Price(
        priceInFCFA: 10000,
        unit: 'kgs',
        unitAmount: 2.5,
        pricePerUnit: 2500,
      ),
    ),
    const CompostComponent(
      name: 'Dolomites',
      availability: AvailabilityPeriod.janToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 100.00,
        organicCarbonPercent: 0.00,
        nitrogenPercent: 0.00,
        phosphorusPercent: 0.00,
        potassiumPercent: 0.00,
        calciumPercent: 38.00,
        magnesiumPercent: 5.00,
        carbonNitrogenRatio: 0.00,
      ),
      unit: 'tons',
      price: Price(
        priceInFCFA: 35000,
        unit: 'kgs',
        unitAmount: 25,
        pricePerUnit: 1750,
      ),
    ),
    const CompostComponent(
      name: 'Corn straw',
      availability: AvailabilityPeriod.octToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 80.45,
        organicCarbonPercent: 46.66,
        nitrogenPercent: 1.80,
        phosphorusPercent: 0.41,
        potassiumPercent: 0.81,
        calciumPercent: 0.27,
        magnesiumPercent: 0.02,
        carbonNitrogenRatio: 25.90,
      ),
      unit: 'tons',
    ),
    const CompostComponent(
      name: 'Cassava peels',
      availability: AvailabilityPeriod.octToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 27.20,
        organicCarbonPercent: 43.60,
        nitrogenPercent: 0.90,
        phosphorusPercent: 0.21,
        potassiumPercent: 0.64,
        calciumPercent: 0.17,
        magnesiumPercent: 0.06,
        carbonNitrogenRatio: 48.40,
      ),
      unit: 'tons',
    ),
    const CompostComponent(
      name: 'Litter (rice bran + chicken manure)',
      availability: AvailabilityPeriod.sepToDec,
      nutrients: NutrientContent(
        dryMatterPercent: 90.20,
        organicCarbonPercent: 43.27,
        nitrogenPercent: 2.81,
        phosphorusPercent: 1.35,
        potassiumPercent: 2.00,
        calciumPercent: 2.67,
        magnesiumPercent: 0.41,
        carbonNitrogenRatio: 15.40,
      ),
      unit: 'tons',
      price: Price(
        priceInFCFA: 10000,
        unit: 'Kgs',
        unitAmount: 100,
        pricePerUnit: 1000,
      ),
    ),
    const CompostComponent(
      name: 'Rice straw - counter-season',
      availability: AvailabilityPeriod.mayToJul,
      nutrients: NutrientContent(
        dryMatterPercent: 85.00,
        organicCarbonPercent: 51.76,
        nitrogenPercent: 0.65,
        phosphorusPercent: 0.20,
        potassiumPercent: 0.30,
        calciumPercent: 0.29,
        magnesiumPercent: 0.15,
        carbonNitrogenRatio: 79.63,
      ),
      unit: 'tons',
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
