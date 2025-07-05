class NutrientContent {
  final double dryMatterPercent;
  final double organicCarbonPercent;
  final double nitrogenPercent;
  final double phosphorusPercent;
  final double potassiumPercent;
  final double calciumPercent;
  final double magnesiumPercent;
  final double carbonNitrogenRatio;

  const NutrientContent({
    required this.dryMatterPercent,
    required this.organicCarbonPercent,
    required this.nitrogenPercent,
    required this.phosphorusPercent,
    required this.potassiumPercent,
    required this.calciumPercent,
    required this.magnesiumPercent,
    required this.carbonNitrogenRatio,
  });

  Map<String, double> toMap() => {
        'dryMatter': dryMatterPercent,
        'organicCarbon': organicCarbonPercent,
        'nitrogen': nitrogenPercent,
        'phosphorus': phosphorusPercent,
        'potassium': potassiumPercent,
        'calcium': calciumPercent,
        'magnesium': magnesiumPercent,
      };

  Map<String, dynamic> toJson() {
    return {
      'dryMatterPercent': dryMatterPercent,
      'organicCarbonPercent': organicCarbonPercent,
      'nitrogenPercent': nitrogenPercent,
      'phosphorusPercent': phosphorusPercent,
      'potassiumPercent': potassiumPercent,
      'calciumPercent': calciumPercent,
      'magnesiumPercent': magnesiumPercent,
      'carbonNitrogenRatio': carbonNitrogenRatio,
    };
  }

  static NutrientContent fromJson(Map<String, dynamic> json) {
    return NutrientContent(
      dryMatterPercent: json['dryMatterPercent']?.toDouble() ?? 0.0,
      organicCarbonPercent: json['organicCarbonPercent']?.toDouble() ?? 0.0,
      nitrogenPercent: json['nitrogenPercent']?.toDouble() ?? 0.0,
      phosphorusPercent: json['phosphorusPercent']?.toDouble() ?? 0.0,
      potassiumPercent: json['potassiumPercent']?.toDouble() ?? 0.0,
      calciumPercent: json['calciumPercent']?.toDouble() ?? 0.0,
      magnesiumPercent: json['magnesiumPercent']?.toDouble() ?? 0.0,
      carbonNitrogenRatio: json['carbonNitrogenRatio']?.toDouble() ?? 0.0,
    );
  }
}
