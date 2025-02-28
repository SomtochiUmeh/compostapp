import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/models/price_model.dart';

void main() {
  group('Price', () {
    test('constructor initializes pricePerTon correctly', () {
      final price = Price(pricePerTon: 500);
      expect(price.pricePerTon, 500);
    });

    test('calculatePrice returns correct price for amount', () {
      final price = Price(pricePerTon: 500);

      // 1000kg = 1 ton, so 10kg should be 1/100th of the price per ton
      expect(price.calculatePrice(10.0), equals(5.0));

      // 500kg = 0.5 ton, so should be half of the price per ton
      expect(price.calculatePrice(500.0), equals(250.0));

      // 1kg = 0.001 ton, so should be 1/1000th of the price per ton
      expect(price.calculatePrice(1.0), equals(0.5));

      // 2000kg = 2 tons, so should be twice the price per ton
      expect(price.calculatePrice(2000.0), equals(1000.0));
    });

    test('calculatePrice handles zero amount', () {
      final price = Price(pricePerTon: 500);
      expect(price.calculatePrice(0.0), equals(0.0));
    });

    test('calculatePrice handles decimal amounts', () {
      final price = Price(pricePerTon: 500);

      // 1.5kg
      expect(price.calculatePrice(1.5), equals(0.75));

      // 0.25kg
      expect(price.calculatePrice(0.25), equals(0.125));

      // 0.1kg
      expect(price.calculatePrice(0.1), equals(0.05));
    });

    test('calculatePrice handles zero pricePerTon', () {
      final price = Price(pricePerTon: 0);
      expect(price.calculatePrice(10.0), equals(0.0));
      expect(price.calculatePrice(100.0), equals(0.0));
      expect(price.calculatePrice(1000.0), equals(0.0));
    });

    test('calculatePrice handles very large values', () {
      final price = Price(pricePerTon: 1000000); // 1 million per ton

      // 1000kg = 1 ton
      expect(price.calculatePrice(1000.0), equals(1000000.0));

      // 1kg = 0.001 ton
      expect(price.calculatePrice(1.0), equals(1000.0));

      // 0.001kg = 0.000001 ton
      expect(price.calculatePrice(0.001), equals(1.0));
    });
  });
}
