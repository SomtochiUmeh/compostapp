import 'package:flutter_test/flutter_test.dart';
import 'package:compostapp/constants/currency_constants.dart';

void main() {
  group('CurrencyConstants', () {
    group('convertFromCFA', () {
      test('converts CFA to USD correctly', () {
        expect(CurrencyConstants.convertFromCFA(1000, 'USD'), equals(1.6));
      });

      test('converts CFA to EUR correctly', () {
        expect(CurrencyConstants.convertFromCFA(1000, 'EUR'), equals(1.5));
      });

      test('converts CFA to GBP correctly', () {
        expect(CurrencyConstants.convertFromCFA(1000, 'GBP'), equals(1.3));
      });

      test('converts CFA to MWK correctly', () {
        expect(CurrencyConstants.convertFromCFA(1000, 'MWK'), equals(1750.0));
      });

      test('converts CFA to NGN correctly', () {
        expect(CurrencyConstants.convertFromCFA(1000, 'NGN'), equals(1330.0));
      });

      test('converts CFA to GHS correctly', () {
        expect(CurrencyConstants.convertFromCFA(1000, 'GHS'), equals(19.0));
      });

      test('converts CFA to CFA returns same value', () {
        expect(CurrencyConstants.convertFromCFA(1000, 'CFA'), equals(1000.0));
      });

      test('handles zero amount', () {
        expect(CurrencyConstants.convertFromCFA(0, 'USD'), equals(0.0));
      });

      test('handles decimal amounts', () {
        expect(CurrencyConstants.convertFromCFA(1500.5, 'USD'), closeTo(2.4008, 0.0001));
      });

      test('throws error for unsupported currency', () {
        expect(
          () => CurrencyConstants.convertFromCFA(1000, 'XYZ'),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('convertToCFA', () {
      test('converts USD to CFA correctly', () {
        expect(CurrencyConstants.convertToCFA(1.6, 'USD'), equals(1000.0));
      });

      test('converts EUR to CFA correctly', () {
        expect(CurrencyConstants.convertToCFA(1.5, 'EUR'), equals(1000.0));
      });

      test('converts GBP to CFA correctly', () {
        expect(CurrencyConstants.convertToCFA(1.3, 'GBP'), closeTo(1000.0, 0.0001));
      });

      test('handles zero amount', () {
        expect(CurrencyConstants.convertToCFA(0, 'USD'), equals(0.0));
      });

      test('throws error for unsupported currency', () {
        expect(
          () => CurrencyConstants.convertToCFA(100, 'XYZ'),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('formatPrice', () {
      test('formats CFA correctly with no decimals', () {
        expect(CurrencyConstants.formatPrice(1000, 'CFA'), equals('FCFA 1000'));
      });

      test('formats USD correctly with 2 decimals', () {
        expect(CurrencyConstants.formatPrice(1.5, 'USD'), equals('\$ 1.50'));
      });

      test('formats EUR correctly with 2 decimals', () {
        expect(CurrencyConstants.formatPrice(2.33, 'EUR'), equals('€ 2.33'));
      });

      test('formats GBP correctly with 2 decimals', () {
        expect(CurrencyConstants.formatPrice(5.67, 'GBP'), equals('£ 5.67'));
      });

      test('formats MWK correctly with no decimals', () {
        expect(CurrencyConstants.formatPrice(1750, 'MWK'), equals('MWK 1750'));
      });

      test('formats NGN correctly with no decimals', () {
        expect(CurrencyConstants.formatPrice(1330, 'NGN'), equals('₦ 1330'));
      });

      test('formats GHS correctly with 2 decimals', () {
        expect(CurrencyConstants.formatPrice(19.50, 'GHS'), equals('₵ 19.50'));
      });

      test('handles zero amount', () {
        expect(CurrencyConstants.formatPrice(0, 'USD'), equals('\$ 0.00'));
      });

      test('rounds decimals correctly', () {
        expect(CurrencyConstants.formatPrice(1.236, 'USD'), equals('\$ 1.24'));
      });

      test('throws error for unsupported currency', () {
        expect(
          () => CurrencyConstants.formatPrice(100, 'XYZ'),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    group('getCurrencySymbol', () {
      test('returns correct symbols for all supported currencies', () {
        expect(CurrencyConstants.getCurrencySymbol('CFA'), equals('FCFA'));
        expect(CurrencyConstants.getCurrencySymbol('USD'), equals('\$'));
        expect(CurrencyConstants.getCurrencySymbol('EUR'), equals('€'));
        expect(CurrencyConstants.getCurrencySymbol('GBP'), equals('£'));
        expect(CurrencyConstants.getCurrencySymbol('MWK'), equals('MWK'));
        expect(CurrencyConstants.getCurrencySymbol('NGN'), equals('₦'));
        expect(CurrencyConstants.getCurrencySymbol('GHS'), equals('₵'));
      });

      test('returns empty string for unsupported currency', () {
        expect(CurrencyConstants.getCurrencySymbol('XYZ'), equals(''));
      });
    });

    group('getSupportedCurrencies', () {
      test('returns all supported currency codes', () {
        final currencies = CurrencyConstants.getSupportedCurrencies();
        expect(currencies, contains('CFA'));
        expect(currencies, contains('USD'));
        expect(currencies, contains('EUR'));
        expect(currencies, contains('GBP'));
        expect(currencies, contains('MWK'));
        expect(currencies, contains('NGN'));
        expect(currencies, contains('GHS'));
        expect(currencies.length, equals(7));
      });

      test('returns a new list each time', () {
        final list1 = CurrencyConstants.getSupportedCurrencies();
        final list2 = CurrencyConstants.getSupportedCurrencies();
        expect(identical(list1, list2), isFalse);
      });
    });

    group('isCurrencySupported', () {
      test('returns true for supported currencies', () {
        expect(CurrencyConstants.isCurrencySupported('CFA'), isTrue);
        expect(CurrencyConstants.isCurrencySupported('USD'), isTrue);
        expect(CurrencyConstants.isCurrencySupported('EUR'), isTrue);
        expect(CurrencyConstants.isCurrencySupported('GBP'), isTrue);
        expect(CurrencyConstants.isCurrencySupported('MWK'), isTrue);
        expect(CurrencyConstants.isCurrencySupported('NGN'), isTrue);
        expect(CurrencyConstants.isCurrencySupported('GHS'), isTrue);
      });

      test('returns false for unsupported currencies', () {
        expect(CurrencyConstants.isCurrencySupported('XYZ'), isFalse);
        expect(CurrencyConstants.isCurrencySupported(''), isFalse);
        expect(CurrencyConstants.isCurrencySupported('usd'), isFalse); // case sensitive
      });
    });

    group('defaultCurrency', () {
      test('default currency is CFA', () {
        expect(CurrencyConstants.defaultCurrency, equals('CFA'));
      });
    });

    group('currency data integrity', () {
      test('all currencies have required properties', () {
        for (final currency in CurrencyConstants.getSupportedCurrencies()) {
          final data = CurrencyConstants.currencies[currency]!;
          expect(data.containsKey('symbol'), isTrue, reason: '$currency missing symbol');
          expect(data.containsKey('rate'), isTrue, reason: '$currency missing rate');
          expect(data.containsKey('name'), isTrue, reason: '$currency missing name');
          expect(data.containsKey('decimalPlaces'), isTrue, reason: '$currency missing decimalPlaces');
        }
      });

      test('CFA has rate of 1.0', () {
        expect(CurrencyConstants.currencies['CFA']!['rate'], equals(1.0));
      });

      test('all rates are positive numbers', () {
        for (final currency in CurrencyConstants.getSupportedCurrencies()) {
          final rate = CurrencyConstants.currencies[currency]!['rate'] as double;
          expect(rate, greaterThan(0), reason: '$currency rate should be positive');
        }
      });

      test('decimal places are valid integers', () {
        for (final currency in CurrencyConstants.getSupportedCurrencies()) {
          final decimalPlaces = CurrencyConstants.currencies[currency]!['decimalPlaces'] as int;
          expect(decimalPlaces, greaterThanOrEqualTo(0), reason: '$currency decimal places should be non-negative');
          expect(decimalPlaces, lessThanOrEqualTo(4), reason: '$currency decimal places should be reasonable');
        }
      });
    });
  });
}