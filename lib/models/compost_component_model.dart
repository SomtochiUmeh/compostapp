import 'availability_model.dart';
import 'nutrient_content_model.dart';
import 'price_model.dart';

class CompostComponent {
  final String name;
  final AvailabilityPeriod availability;
  final NutrientContent nutrients;
  final String unit;
  final Price? price;
  final List<String> sources;

  const CompostComponent({
    required this.name,
    required this.availability,
    required this.nutrients,
    required this.unit,
    this.price,
    this.sources = const [],
  });

  bool isAvailableOn(DateTime date) => availability.isAvailable(date);
}
