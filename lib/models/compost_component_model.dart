import 'availability_model.dart';
import 'nutrient_content_model.dart';
import 'price_model.dart';
import '../generated/l10n.dart';

class CompostComponent {
  final String id;
  final String name;
  final AvailabilityPeriod availability;
  final NutrientContent nutrients;
  final Price? price;
  final List<String> sources;

  const CompostComponent({
    required this.id,
    required this.name,
    required this.availability,
    required this.nutrients,
    this.price,
    this.sources = const [],
  });

  String getName() {
    return S.current.getTranslation('component$id');
  }

  bool isAvailableOn(DateTime date) => availability.isAvailable(date);
}
