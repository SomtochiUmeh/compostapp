class Price {
  final int priceInFCFA;
  final String unit;
  final double unitAmount;
  final int pricePerUnit;

  const Price({
    required this.priceInFCFA,
    required this.unit,
    required this.unitAmount,
    required this.pricePerUnit,
  });

  double calculatePrice(double amount) {
    double amountInPriceUnit =
        unit.toLowerCase() == 'tons' ? amount * 1000 : amount;
    return (amountInPriceUnit / unitAmount) * pricePerUnit;
  }
}
