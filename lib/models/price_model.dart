import '../constants/currency_constants.dart';

class Price {
  final double pricePerKg; // Base CFA price per kg
  final Map<String, double>? regionalPrices; // Optional regional overrides

  Price({
    required this.pricePerKg,
    this.regionalPrices,
  });

  /// Get price for specific currency (regional if available, converted if not)
  double getPriceForCurrency(String currency) {
    if (currency == 'CFA') return pricePerKg;
    if (regionalPrices?.containsKey(currency) == true) {
      return regionalPrices![currency]!; // Use regional price
    }
    return CurrencyConstants.convertFromCFA(pricePerKg, currency); // Fallback to conversion
  }

  /// Set regional price for specific currency
  Price withRegionalPrice(String currency, double price) {
    final newRegionalPrices = Map<String, double>.from(regionalPrices ?? {});
    
    if (currency == 'CFA') {
      // If setting CFA, update base price and remove from regional
      newRegionalPrices.remove('CFA');
      return Price(
        pricePerKg: price, 
        regionalPrices: newRegionalPrices.isEmpty ? null : newRegionalPrices,
      );
    }
    
    newRegionalPrices[currency] = price;
    return Price(
      pricePerKg: pricePerKg, 
      regionalPrices: newRegionalPrices,
    );
  }

  /// Clear regional price to fall back to CFA conversion
  Price clearRegionalPrice(String currency) {
    if (currency == 'CFA' || regionalPrices == null) return this;
    
    final newRegional = Map<String, double>.from(regionalPrices!);
    newRegional.remove(currency);
    
    return Price(
      pricePerKg: pricePerKg,
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
      pricePerKg: newCfaPrice,
      regionalPrices: regionalPrices, // Keep all regional overrides unchanged
    );
  }

  double calculatePrice(double amount, {String currency = 'CFA'}) {
    final price = getPriceForCurrency(currency);
    return price * amount;
  }

  Map<String, dynamic> toJson() {
    return {
      'pricePerKg': pricePerKg,
      'regionalPrices': regionalPrices,
    };
  }

  static Price fromJson(Map<String, dynamic> json) {
    // Handle migration from pricePerTon to pricePerKg
    double pricePerKg;
    if (json.containsKey('pricePerKg')) {
      pricePerKg = json['pricePerKg']?.toDouble() ?? 0.0;
    } else if (json.containsKey('pricePerTon')) {
      // Migrate from old format: divide by 1000 to convert ton to kg
      pricePerKg = (json['pricePerTon']?.toDouble() ?? 0.0) / 1000;
    } else {
      pricePerKg = 0.0;
    }
    
    return Price(
      pricePerKg: pricePerKg,
      regionalPrices: json['regionalPrices'] != null
          ? Map<String, double>.from(json['regionalPrices'])
          : null,
    );
  }
}
