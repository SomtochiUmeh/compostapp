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

    group('Regional Pricing', () {
      test('constructor with regional prices initializes correctly', () {
        final price = Price(
          pricePerTon: 1000,
          regionalPrices: {'USD': 1.5, 'EUR': 2.0},
        );
        expect(price.pricePerTon, equals(1000));
        expect(price.regionalPrices, isNotNull);
        expect(price.regionalPrices!['USD'], equals(1.5));
        expect(price.regionalPrices!['EUR'], equals(2.0));
      });

      test('getPriceForCurrency returns CFA price for CFA currency', () {
        final price = Price(
          pricePerTon: 1000,
          regionalPrices: {'USD': 1.5},
        );
        expect(price.getPriceForCurrency('CFA'), equals(1000));
      });

      test('getPriceForCurrency returns regional price when available', () {
        final price = Price(
          pricePerTon: 1000,
          regionalPrices: {'USD': 1.5, 'EUR': 2.0},
        );
        expect(price.getPriceForCurrency('USD'), equals(1.5));
        expect(price.getPriceForCurrency('EUR'), equals(2.0));
      });

      test('getPriceForCurrency falls back to conversion when no regional price', () {
        final price = Price(pricePerTon: 1000);
        // USD conversion: 1000 * 0.0016 = 1.6
        expect(price.getPriceForCurrency('USD'), equals(1.6));
      });

      test('withRegionalPrice sets regional price for non-CFA currency', () {
        final price = Price(pricePerTon: 1000);
        final updated = price.withRegionalPrice('USD', 2.5);
        
        expect(updated.pricePerTon, equals(1000));
        expect(updated.regionalPrices!['USD'], equals(2.5));
        expect(updated.getPriceForCurrency('USD'), equals(2.5));
      });

      test('withRegionalPrice updates CFA base price when currency is CFA', () {
        final price = Price(
          pricePerTon: 1000,
          regionalPrices: {'USD': 1.5},
        );
        final updated = price.withRegionalPrice('CFA', 1500);
        
        expect(updated.pricePerTon, equals(1500));
        expect(updated.regionalPrices!.containsKey('CFA'), isFalse);
        expect(updated.regionalPrices!['USD'], equals(1.5)); // preserves other regional prices
      });

      test('withRegionalPrice creates regional prices map when null', () {
        final price = Price(pricePerTon: 1000);
        final updated = price.withRegionalPrice('USD', 1.5);
        
        expect(updated.regionalPrices, isNotNull);
        expect(updated.regionalPrices!['USD'], equals(1.5));
      });

      test('withRegionalPrice preserves existing regional prices', () {
        final price = Price(
          pricePerTon: 1000,
          regionalPrices: {'USD': 1.5, 'EUR': 2.0},
        );
        final updated = price.withRegionalPrice('GBP', 3.0);
        
        expect(updated.regionalPrices!['USD'], equals(1.5));
        expect(updated.regionalPrices!['EUR'], equals(2.0));
        expect(updated.regionalPrices!['GBP'], equals(3.0));
      });

      test('clearRegionalPrice removes specific regional price', () {
        final price = Price(
          pricePerTon: 1000,
          regionalPrices: {'USD': 1.5, 'EUR': 2.0},
        );
        final updated = price.clearRegionalPrice('USD');
        
        expect(updated.regionalPrices!.containsKey('USD'), isFalse);
        expect(updated.regionalPrices!['EUR'], equals(2.0));
      });

      test('clearRegionalPrice does nothing for CFA currency', () {
        final price = Price(
          pricePerTon: 1000,
          regionalPrices: {'USD': 1.5},
        );
        final updated = price.clearRegionalPrice('CFA');
        
        expect(updated.pricePerTon, equals(1000));
        expect(updated.regionalPrices!['USD'], equals(1.5));
      });

      test('clearRegionalPrice returns same instance when no regional prices', () {
        final price = Price(pricePerTon: 1000);
        final updated = price.clearRegionalPrice('USD');
        
        expect(identical(price, updated), isTrue);
      });

      test('clearRegionalPrice sets regionalPrices to null when map becomes empty', () {
        final price = Price(
          pricePerTon: 1000,
          regionalPrices: {'USD': 1.5},
        );
        final updated = price.clearRegionalPrice('USD');
        
        expect(updated.regionalPrices, isNull);
      });

      test('hasRegionalPrice returns correct boolean values', () {
        final price = Price(
          pricePerTon: 1000,
          regionalPrices: {'USD': 1.5, 'EUR': 2.0},
        );
        
        expect(price.hasRegionalPrice('USD'), isTrue);
        expect(price.hasRegionalPrice('EUR'), isTrue);
        expect(price.hasRegionalPrice('GBP'), isFalse);
        expect(price.hasRegionalPrice('CFA'), isFalse); // CFA is never considered regional
      });

      test('hasRegionalPrice returns false when regionalPrices is null', () {
        final price = Price(pricePerTon: 1000);
        expect(price.hasRegionalPrice('USD'), isFalse);
      });

      test('isUntouchedCurrency returns correct boolean values', () {
        final price = Price(
          pricePerTon: 1000,
          regionalPrices: {'USD': 1.5},
        );
        
        expect(price.isUntouchedCurrency('USD'), isFalse); // has regional price
        expect(price.isUntouchedCurrency('EUR'), isTrue); // no regional price
        expect(price.isUntouchedCurrency('CFA'), isFalse); // CFA is never untouched
      });

      test('updateCFAPrice preserves all regional overrides', () {
        final price = Price(
          pricePerTon: 1000,
          regionalPrices: {'USD': 1.5, 'EUR': 2.0, 'GBP': 2.5},
        );
        final updated = price.updateCFAPrice(1500);
        
        expect(updated.pricePerTon, equals(1500));
        expect(updated.regionalPrices!['USD'], equals(1.5));
        expect(updated.regionalPrices!['EUR'], equals(2.0));
        expect(updated.regionalPrices!['GBP'], equals(2.5));
      });

      test('updateCFAPrice preserves null regionalPrices', () {
        final price = Price(pricePerTon: 1000);
        final updated = price.updateCFAPrice(1500);
        
        expect(updated.pricePerTon, equals(1500));
        expect(updated.regionalPrices, isNull);
      });

      test('calculatePrice works with regional pricing and specific currency', () {
        final price = Price(
          pricePerTon: 1000, // 1000 CFA per ton
          regionalPrices: {'USD': 2.0}, // 2 USD per ton
        );
        
        // 500kg = 0.5 ton, so should be 1 USD for USD currency
        expect(price.calculatePrice(500.0, currency: 'USD'), equals(1.0));
        
        // 500kg = 0.5 ton, so should be 500 CFA for CFA currency  
        expect(price.calculatePrice(500.0, currency: 'CFA'), equals(500.0));
        
        // For EUR (no regional price), falls back to conversion: 1000 * 0.0015 = 1.5 per ton
        // 500kg = 0.5 ton, so should be 0.75 EUR
        expect(price.calculatePrice(500.0, currency: 'EUR'), equals(0.75));
      });
    });
  });
}
