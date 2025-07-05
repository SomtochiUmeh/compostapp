class CurrencyConstants {
  // Base currency is CFA (rate = 1.0)
  static const Map<String, Map<String, dynamic>> currencies = {
    'CFA': {
      'symbol': 'FCFA',
      'rate': 1.0,
      'name': 'West African CFA Franc',
      'decimalPlaces': 0,
    },
    'USD': {
      'symbol': '\$',
      'rate': 0.0016,
      'name': 'US Dollar',
      'decimalPlaces': 2,
    },
    'EUR': {
      'symbol': '€',
      'rate': 0.0015,
      'name': 'Euro',
      'decimalPlaces': 2,
    },
    'GBP': {
      'symbol': '£',
      'rate': 0.0013,
      'name': 'British Pound',
      'decimalPlaces': 2,
    },
    'MWK': {
      'symbol': 'MWK',
      'rate': 1.75,
      'name': 'Malawian Kwacha',
      'decimalPlaces': 0,
    },
    'NGN': {
      'symbol': '₦',
      'rate': 1.33,
      'name': 'Nigerian Naira',
      'decimalPlaces': 0,
    },
    'GHS': {
      'symbol': '₵',
      'rate': 0.019,
      'name': 'Ghanaian Cedi',
      'decimalPlaces': 2,
    },
  };

  static const String defaultCurrency = 'CFA';

  /// Convert price from CFA (base currency) to target currency
  static double convertFromCFA(double cfaPrice, String toCurrency) {
    if (!currencies.containsKey(toCurrency)) {
      throw ArgumentError('Currency $toCurrency not supported');
    }
    return cfaPrice * currencies[toCurrency]!['rate'];
  }

  /// Convert price from any currency back to CFA
  static double convertToCFA(double price, String fromCurrency) {
    if (!currencies.containsKey(fromCurrency)) {
      throw ArgumentError('Currency $fromCurrency not supported');
    }
    return price / currencies[fromCurrency]!['rate'];
  }

  /// Format price with currency symbol and appropriate decimal places
  static String formatPrice(double price, String currency) {
    if (!currencies.containsKey(currency)) {
      throw ArgumentError('Currency $currency not supported');
    }
    
    final currencyData = currencies[currency]!;
    final symbol = currencyData['symbol'];
    final decimalPlaces = currencyData['decimalPlaces'];
    
    return '$symbol ${price.toStringAsFixed(decimalPlaces)}';
  }

  /// Get currency symbol
  static String getCurrencySymbol(String currency) {
    return currencies[currency]?['symbol'] ?? '';
  }


  /// Get list of all supported currency codes
  static List<String> getSupportedCurrencies() {
    return currencies.keys.toList();
  }

  /// Check if currency is supported
  static bool isCurrencySupported(String currency) {
    return currencies.containsKey(currency);
  }
}