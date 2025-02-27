class Price {
  final int pricePerTon;

  Price({
    required this.pricePerTon,
  });

  double calculatePrice(double amount) {
    return (pricePerTon / 1000) * amount;
  }
}
