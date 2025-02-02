import 'unit_model.dart';

class Price {
  final int priceInFCFA;
  final MassUnit unit;
  final double unitAmount;
  final int pricePerUnit;

  Price({
    required this.priceInFCFA,
    required String unit,
    required this.unitAmount,
    required this.pricePerUnit,
  }) : unit = MassUnit.fromString(unit);

  double calculatePrice(double amount) {
    double amountInPriceUnit = unit == MassUnit.tons ? amount * 1000 : amount;
    return (amountInPriceUnit / unitAmount) * pricePerUnit;
  }

  String getLocalizedUnit() => unit.getLocalizedUnit();
}
