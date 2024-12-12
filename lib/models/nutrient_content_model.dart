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
}
