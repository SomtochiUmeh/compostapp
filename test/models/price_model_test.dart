import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/models/price_model.dart';

void main() {
  group('Price', () {
    test('constructor initializes pricePerTon correctly', () {
      final price = Price(pricePerTon: 500000);
      expect(price.pricePerTon, 500000);
    });

    test('calculatePrice returns correct price for amount', () {
      final price = Price(pricePerTon: 500); // 500 CFA per ton

      // 10 tons should be 10 * 500 = 5000.0
      expect(price.calculatePrice(10.0), equals(5000.0));

      // 0.5 tons should be 0.5 * 500 = 250.0
      expect(price.calculatePrice(0.5), equals(250.0));

      // 1 ton should be 1 * 500 = 500.0
      expect(price.calculatePrice(1.0), equals(500.0));

      // 2 tons should be 2 * 500 = 1000.0
      expect(price.calculatePrice(2.0), equals(1000.0));
    });

    test('calculatePrice handles zero amount', () {
      final price = Price(pricePerTon: 500000);
      expect(price.calculatePrice(0.0), equals(0.0));
    });

    test('calculatePrice handles decimal amounts', () {
      final price = Price(pricePerTon: 500); // 500 CFA per ton

      // 1.5 tons should be 1.5 * 500 = 750.0
      expect(price.calculatePrice(1.5), equals(750.0));

      // 0.25 tons should be 0.25 * 500 = 125.0
      expect(price.calculatePrice(0.25), equals(125.0));

      // 0.1 tons should be 0.1 * 500 = 50.0
      expect(price.calculatePrice(0.1), equals(50.0));
    });

    test('calculatePrice handles zero pricePerTon', () {
      final price = Price(pricePerTon: 0);
      expect(price.calculatePrice(10.0), equals(0.0));
      expect(price.calculatePrice(100.0), equals(0.0));
      expect(price.calculatePrice(1000.0), equals(0.0));
    });

    test('calculatePrice handles very large values', () {
      final price = Price(pricePerTon: 1000000); // 1000000 CFA per ton

      // 1000 tons should be 1000 * 1000000 = 1,000,000,000
      expect(price.calculatePrice(1000.0), equals(1000000000.0));

      // 1 ton should be 1 * 1000000 = 1,000,000
      expect(price.calculatePrice(1.0), equals(1000000.0));

      // 0.001 tons should be 0.001 * 1000000 = 1000.0
      expect(price.calculatePrice(0.001), equals(1000.0));
    });

    group('Regional Pricing', () {
      test('constructor with regional prices initializes correctly', () {
        final price = Price(
          pricePerTon: 1000000,
          regionalPrices: {'USD': 1500, 'EUR': 2000},
        );
        expect(price.pricePerTon, equals(1000000));
        expect(price.regionalPrices, isNotNull);
        expect(price.regionalPrices!['USD'], equals(1500));
        expect(price.regionalPrices!['EUR'], equals(2000));
      });

      test('getPriceForCurrency returns CFA price for CFA currency', () {
        final price = Price(
          pricePerTon: 1000000,
          regionalPrices: {'USD': 1500},
        );
        expect(price.getPriceForCurrency('CFA'), equals(1000000));
      });

      test('getPriceForCurrency returns regional price when available', () {
        final price = Price(
          pricePerTon: 1000000,
          regionalPrices: {'USD': 1500, 'EUR': 2000},
        );
        expect(price.getPriceForCurrency('USD'), equals(1500));
        expect(price.getPriceForCurrency('EUR'), equals(2000));
      });

      test('getPriceForCurrency falls back to conversion when no regional price', () {
        final price = Price(pricePerTon: 1000000);
        // USD conversion: 1000000 * 0.0016 = 1600
        expect(price.getPriceForCurrency('USD'), equals(1600));
      });

      test('withRegionalPrice sets regional price for non-CFA currency', () {
        final price = Price(pricePerTon: 1000000);
        final updated = price.withRegionalPrice('USD', 2500);
        
        expect(updated.pricePerTon, equals(1000000));
        expect(updated.regionalPrices!['USD'], equals(2500));
        expect(updated.getPriceForCurrency('USD'), equals(2500));
      });

      test('withRegionalPrice updates CFA base price when currency is CFA', () {
        final price = Price(
          pricePerTon: 1000000,
          regionalPrices: {'USD': 1500},
        );
        final updated = price.withRegionalPrice('CFA', 1500000);
        
        expect(updated.pricePerTon, equals(1500000));
        expect(updated.regionalPrices!.containsKey('CFA'), isFalse);
        expect(updated.regionalPrices!['USD'], equals(1500)); // preserves other regional prices
      });

      test('withRegionalPrice creates regional prices map when null', () {
        final price = Price(pricePerTon: 1000000);
        final updated = price.withRegionalPrice('USD', 1500);
        
        expect(updated.regionalPrices, isNotNull);
        expect(updated.regionalPrices!['USD'], equals(1500));
      });

      test('withRegionalPrice preserves existing regional prices', () {
        final price = Price(
          pricePerTon: 1000000,
          regionalPrices: {'USD': 1500, 'EUR': 2000},
        );
        final updated = price.withRegionalPrice('GBP', 3000);
        
        expect(updated.regionalPrices!['USD'], equals(1500));
        expect(updated.regionalPrices!['EUR'], equals(2000));
        expect(updated.regionalPrices!['GBP'], equals(3000));
      });

      test('clearRegionalPrice removes specific regional price', () {
        final price = Price(
          pricePerTon: 1000000,
          regionalPrices: {'USD': 1500, 'EUR': 2000},
        );
        final updated = price.clearRegionalPrice('USD');
        
        expect(updated.regionalPrices!.containsKey('USD'), isFalse);
        expect(updated.regionalPrices!['EUR'], equals(2000));
      });

      test('clearRegionalPrice does nothing for CFA currency', () {
        final price = Price(
          pricePerTon: 1000000,
          regionalPrices: {'USD': 1500},
        );
        final updated = price.clearRegionalPrice('CFA');
        
        expect(updated.pricePerTon, equals(1000000));
        expect(updated.regionalPrices!['USD'], equals(1500));
      });

      test('clearRegionalPrice returns same instance when no regional prices', () {
        final price = Price(pricePerTon: 1000000);
        final updated = price.clearRegionalPrice('USD');
        
        expect(identical(price, updated), isTrue);
      });

      test('clearRegionalPrice sets regionalPrices to null when map becomes empty', () {
        final price = Price(
          pricePerTon: 1000000,
          regionalPrices: {'USD': 1500},
        );
        final updated = price.clearRegionalPrice('USD');
        
        expect(updated.regionalPrices, isNull);
      });

      test('hasRegionalPrice returns correct boolean values', () {
        final price = Price(
          pricePerTon: 1000000,
          regionalPrices: {'USD': 1500, 'EUR': 2000},
        );
        
        expect(price.hasRegionalPrice('USD'), isTrue);
        expect(price.hasRegionalPrice('EUR'), isTrue);
        expect(price.hasRegionalPrice('GBP'), isFalse);
        expect(price.hasRegionalPrice('CFA'), isFalse); // CFA is never considered regional
      });

      test('hasRegionalPrice returns false when regionalPrices is null', () {
        final price = Price(pricePerTon: 1000000);
        expect(price.hasRegionalPrice('USD'), isFalse);
      });

      test('isUntouchedCurrency returns correct boolean values', () {
        final price = Price(
          pricePerTon: 1000000,
          regionalPrices: {'USD': 1500},
        );
        
        expect(price.isUntouchedCurrency('USD'), isFalse); // has regional price
        expect(price.isUntouchedCurrency('EUR'), isTrue); // no regional price
        expect(price.isUntouchedCurrency('CFA'), isFalse); // CFA is never untouched
      });

      test('updateCFAPrice preserves all regional overrides', () {
        final price = Price(
          pricePerTon: 1000000,
          regionalPrices: {'USD': 1500, 'EUR': 2000, 'GBP': 2500},
        );
        final updated = price.updateCFAPrice(1500000);
        
        expect(updated.pricePerTon, equals(1500000));
        expect(updated.regionalPrices!['USD'], equals(1500));
        expect(updated.regionalPrices!['EUR'], equals(2000));
        expect(updated.regionalPrices!['GBP'], equals(2500));
      });

      test('updateCFAPrice preserves null regionalPrices', () {
        final price = Price(pricePerTon: 1000000);
        final updated = price.updateCFAPrice(1500000);
        
        expect(updated.pricePerTon, equals(1500000));
        expect(updated.regionalPrices, isNull);
      });

      test('calculatePrice works with regional pricing and specific currency', () {
        final price = Price(
          pricePerTon: 1000, // 1000 CFA per ton
          regionalPrices: {'USD': 2}, // 2 USD per ton
        );
        
        // 0.5 tons should be 0.5 * 2 = 1.0 USD for USD currency
        expect(price.calculatePrice(0.5, currency: 'USD'), equals(1.0));
        
        // 0.5 tons should be 0.5 * 1000 = 500 CFA for CFA currency  
        expect(price.calculatePrice(0.5, currency: 'CFA'), equals(500.0));
        
        // For EUR (no regional price), falls back to conversion: 1000 CFA per ton converted to EUR
        // 0.5 tons with CFA->EUR conversion should be 0.5 * 1.5 = 0.75 EUR
        expect(price.calculatePrice(0.5, currency: 'EUR'), equals(0.75));
      });
    });
  });
}
