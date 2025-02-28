import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/models/nutrient_content_model.dart';

void main() {
  group('NutrientContent', () {
    test('constructor initializes all properties correctly', () {
      const nutrientContent = NutrientContent(
        dryMatterPercent: 0.75,
        organicCarbonPercent: 0.45,
        nitrogenPercent: 0.03,
        phosphorusPercent: 0.02,
        potassiumPercent: 0.04,
        calciumPercent: 0.03,
        magnesiumPercent: 0.01,
        carbonNitrogenRatio: 15.0,
      );

      expect(nutrientContent.dryMatterPercent, 0.75);
      expect(nutrientContent.organicCarbonPercent, 0.45);
      expect(nutrientContent.nitrogenPercent, 0.03);
      expect(nutrientContent.phosphorusPercent, 0.02);
      expect(nutrientContent.potassiumPercent, 0.04);
      expect(nutrientContent.calciumPercent, 0.03);
      expect(nutrientContent.magnesiumPercent, 0.01);
      expect(nutrientContent.carbonNitrogenRatio, 15.0);
    });

    test('toMap returns correct map representation', () {
      const nutrientContent = NutrientContent(
        dryMatterPercent: 0.75,
        organicCarbonPercent: 0.45,
        nitrogenPercent: 0.03,
        phosphorusPercent: 0.02,
        potassiumPercent: 0.04,
        calciumPercent: 0.03,
        magnesiumPercent: 0.01,
        carbonNitrogenRatio: 15.0,
      );

      final map = nutrientContent.toMap();

      expect(map, isA<Map<String, double>>());
      expect(
          map.length, 7); // 7 nutrient properties without carbonNitrogenRatio
      expect(map['dryMatter'], 0.75);
      expect(map['organicCarbon'], 0.45);
      expect(map['nitrogen'], 0.03);
      expect(map['phosphorus'], 0.02);
      expect(map['potassium'], 0.04);
      expect(map['calcium'], 0.03);
      expect(map['magnesium'], 0.01);

      // carbonNitrogenRatio is not included in the map
      expect(map.containsKey('carbonNitrogenRatio'), false);
    });

    test('handles zero values correctly', () {
      const nutrientContent = NutrientContent(
        dryMatterPercent: 0.0,
        organicCarbonPercent: 0.0,
        nitrogenPercent: 0.0,
        phosphorusPercent: 0.0,
        potassiumPercent: 0.0,
        calciumPercent: 0.0,
        magnesiumPercent: 0.0,
        carbonNitrogenRatio: 0.0,
      );

      final map = nutrientContent.toMap();

      expect(map['dryMatter'], 0.0);
      expect(map['organicCarbon'], 0.0);
      expect(map['nitrogen'], 0.0);
      expect(map['phosphorus'], 0.0);
      expect(map['potassium'], 0.0);
      expect(map['calcium'], 0.0);
      expect(map['magnesium'], 0.0);
    });

    test('handles very small values correctly', () {
      const nutrientContent = NutrientContent(
        dryMatterPercent: 0.000001,
        organicCarbonPercent: 0.000002,
        nitrogenPercent: 0.000003,
        phosphorusPercent: 0.000004,
        potassiumPercent: 0.000005,
        calciumPercent: 0.000006,
        magnesiumPercent: 0.000007,
        carbonNitrogenRatio: 0.000008,
      );

      final map = nutrientContent.toMap();

      expect(map['dryMatter'], 0.000001);
      expect(map['organicCarbon'], 0.000002);
      expect(map['nitrogen'], 0.000003);
      expect(map['phosphorus'], 0.000004);
      expect(map['potassium'], 0.000005);
      expect(map['calcium'], 0.000006);
      expect(map['magnesium'], 0.000007);
    });

    test('handles large values correctly', () {
      const nutrientContent = NutrientContent(
        dryMatterPercent: 1.0, // 100%
        organicCarbonPercent: 0.99,
        nitrogenPercent: 0.95,
        phosphorusPercent: 0.90,
        potassiumPercent: 0.85,
        calciumPercent: 0.80,
        magnesiumPercent: 0.75,
        carbonNitrogenRatio: 100.0,
      );

      final map = nutrientContent.toMap();

      expect(map['dryMatter'], 1.0);
      expect(map['organicCarbon'], 0.99);
      expect(map['nitrogen'], 0.95);
      expect(map['phosphorus'], 0.90);
      expect(map['potassium'], 0.85);
      expect(map['calcium'], 0.80);
      expect(map['magnesium'], 0.75);
    });
  });
}
