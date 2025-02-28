import '../generated/l10n.dart';

class AvailabilityPeriod {
  final int startMonth; // 1-12 for Jan-Dec
  final int endMonth; // 1-12 for Jan-Dec
  final String name;

  // Pre-defined availability periods
  static const AvailabilityPeriod janToDec =
      AvailabilityPeriod._predefined('janToDec', 1, 12);
  static const AvailabilityPeriod marToAug =
      AvailabilityPeriod._predefined('marToAug', 3, 8);
  static const AvailabilityPeriod octToDec =
      AvailabilityPeriod._predefined('octToDec', 10, 12);
  static const AvailabilityPeriod octToJan =
      AvailabilityPeriod._predefined('octToJan', 10, 1);
  static const AvailabilityPeriod mayToJul =
      AvailabilityPeriod._predefined('mayToJul', 5, 7);
  static const AvailabilityPeriod sepToDec =
      AvailabilityPeriod._predefined('sepToDec', 9, 12);

  // List of all predefined periods
  static const List<AvailabilityPeriod> values = [
    janToDec,
    marToAug,
    octToDec,
    octToJan,
    mayToJul,
    sepToDec
  ];

  // Private constructor for predefined periods
  const AvailabilityPeriod._predefined(
      this.name, this.startMonth, this.endMonth);

  // Public constructor for custom periods
  AvailabilityPeriod(this.startMonth, this.endMonth)
      : name = 'custom_${startMonth}_to_$endMonth';

  bool isAvailable(DateTime date) {
    final month = date.month;
    if (startMonth <= endMonth) {
      // Normal range within a year (e.g., Mar-Aug)
      return month >= startMonth && month <= endMonth;
    } else {
      // Range spanning across years (e.g., Oct-Jan)
      return month >= startMonth || month <= endMonth;
    }
  }

  String getLocalizedPeriod() {
    // Try to get predefined localized string if this is a predefined period
    switch (name) {
      case 'janToDec':
        return S.current.availabilityJanToDec;
      case 'marToAug':
        return S.current.availabilityMarToAug;
      case 'octToDec':
        return S.current.availabilityOctToDec;
      case 'octToJan':
        return S.current.availabilityOctToJan;
      case 'mayToJul':
        return S.current.availabilityMayToJul;
      case 'sepToDec':
        return S.current.availabilitySepToDec;
      default:
        // For custom periods, return a generic localized string
        return '${S.current.available} ${_getMonthName(startMonth)} ${S.current.to} ${_getMonthName(endMonth)}';
    }
  }

  static String _getMonthName(int month) {
    switch (month) {
      case 1:
        return S.current.january;
      case 2:
        return S.current.february;
      case 3:
        return S.current.march;
      case 4:
        return S.current.april;
      case 5:
        return S.current.may;
      case 6:
        return S.current.june;
      case 7:
        return S.current.july;
      case 8:
        return S.current.august;
      case 9:
        return S.current.september;
      case 10:
        return S.current.october;
      case 11:
        return S.current.november;
      case 12:
        return S.current.december;
      default:
        return month.toString();
    }
  }

  // For serialization/deserialization
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'startMonth': startMonth,
      'endMonth': endMonth,
    };
  }

  factory AvailabilityPeriod.fromJson(Map<String, dynamic> json) {
    // Check if this is a predefined period
    final name = json['name'];
    for (var period in values) {
      if (period.name == name) {
        return period;
      }
    }

    // This is a custom period
    return AvailabilityPeriod(
      json['startMonth'] as int,
      json['endMonth'] as int,
    );
  }

  // For comparison
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvailabilityPeriod &&
          runtimeType == other.runtimeType &&
          startMonth == other.startMonth &&
          endMonth == other.endMonth;

  @override
  int get hashCode => startMonth.hashCode ^ endMonth.hashCode;

  // For string representation (used in persistence)
  @override
  String toString() => name;
}
