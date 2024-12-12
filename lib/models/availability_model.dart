enum AvailabilityPeriod {
  janToDec, // January to December
  marToAug, // March to August
  octToDec, // October to December
  octToJan, // October to January
  mayToJul, // May to July
  sepToDec // September to December
}

extension AvailabilityPeriodExtension on AvailabilityPeriod {
  bool isAvailable(DateTime date) {
    final month = date.month;
    switch (this) {
      case AvailabilityPeriod.janToDec:
        return true;
      case AvailabilityPeriod.marToAug:
        return month >= 3 && month <= 8;
      case AvailabilityPeriod.octToDec:
        return month >= 10 && month <= 12;
      case AvailabilityPeriod.octToJan:
        return month >= 10 || month <= 1;
      case AvailabilityPeriod.mayToJul:
        return month >= 5 && month <= 7;
      case AvailabilityPeriod.sepToDec:
        return month >= 9 && month <= 12;
    }
  }
}
