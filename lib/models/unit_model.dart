import '../generated/l10n.dart';

enum MassUnit {
  kgs,
  tons;

  String getLocalizedUnit() {
    switch (this) {
      case MassUnit.kgs:
        return S.current.unitKgs;
      case MassUnit.tons:
        return S.current.unitTons;
    }
  }

  static MassUnit fromString(String value) {
    return MassUnit.values.firstWhere(
      (unit) => unit.toString().split('.').last == value.toLowerCase(),
      orElse: () => MassUnit.kgs,
    );
  }
}
