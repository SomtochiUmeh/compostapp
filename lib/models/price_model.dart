import '../constants/currency_constants.dart';

class Price {
  final double pricePerTon; // Base CFA price per ton
  final Map<String, double>? regionalPrices; // Optional regional overrides

  Price({
    required this.pricePerTon,
    this.regionalPrices,
  });

  /// Get price for specific currency (regional if available, converted if not)
  double getPriceForCurrency(String currency) {
    if (currency == 'CFA') return pricePerTon;
    if (regionalPrices?.containsKey(currency) == true) {
      return regionalPrices![currency]!; // Use regional price
    }
    return CurrencyConstants.convertFromCFA(pricePerTon, currency); // Fallback to conversion
  }

  /// Set regional price for specific currency
  Price withRegionalPrice(String currency, double price) {
    final newRegionalPrices = Map<String, double>.from(regionalPrices ?? {});
    
    if (currency == 'CFA') {
      // If setting CFA, update base price and remove from regional
      newRegionalPrices.remove('CFA');
      return Price(
        pricePerTon: price, 
        regionalPrices: newRegionalPrices.isEmpty ? null : newRegionalPrices,
      );
    }
    
    newRegionalPrices[currency] = price;
    return Price(
      pricePerTon: pricePerTon, 
      regionalPrices: newRegionalPrices,
    );
  }

  /// Clear regional price to fall back to CFA conversion
  Price clearRegionalPrice(String currency) {
    if (currency == 'CFA' || regionalPrices == null) return this;
    
    final newRegional = Map<String, double>.from(regionalPrices!);
    newRegional.remove(currency);
    
    return Price(
      pricePerTon: pricePerTon,
      regionalPrices: newRegional.isEmpty ? null : newRegional,
    );
  }

  /// Check if a currency has a regional override
  bool hasRegionalPrice(String currency) {
    return currency != 'CFA' && regionalPrices?.containsKey(currency) == true;
  }

  /// Check if a currency is "untouched" (using CFA conversion, not regional override)
  bool isUntouchedCurrency(String currency) {
    return currency != 'CFA' && !hasRegionalPrice(currency);
  }

  /// Update CFA price and preserve regional overrides
  Price updateCFAPrice(double newCfaPrice) {
    return Price(
      pricePerTon: newCfaPrice,
      regionalPrices: regionalPrices, // Keep all regional overrides unchanged
    );
  }

  double calculatePrice(double amount, {String currency = 'CFA'}) {
    final pricePerTon = getPriceForCurrency(currency);
    // Amount is already in tons, multiply directly by price per ton
    return amount * pricePerTon;
  }

  Map<String, dynamic> toJson() {
    return {
      'pricePerTon': pricePerTon,
      'regionalPrices': regionalPrices,
    };
  }

  static Price fromJson(Map<String, dynamic> json) {
    // Handle migration from pricePerKg to pricePerTon
    double pricePerTon;
    if (json.containsKey('pricePerTon')) {
      pricePerTon = json['pricePerTon']?.toDouble() ?? 0.0;
    } else if (json.containsKey('pricePerKg')) {
      // Migrate from old format: multiply by 1000 to convert kg to ton
      pricePerTon = (json['pricePerKg']?.toDouble() ?? 0.0) * 1000;
    } else {
      pricePerTon = 0.0;
    }
    
    return Price(
      pricePerTon: pricePerTon,
      regionalPrices: json['regionalPrices'] != null
          ? Map<String, double>.from(json['regionalPrices'])
          : null,
    );
  }
}
