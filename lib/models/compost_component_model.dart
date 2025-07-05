import 'package:compostapp/models/price_model.dart';

import 'nutrient_content_model.dart';
import '../generated/l10n.dart';

class CompostComponent {
  final String id;
  final String name;
  final NutrientContent nutrients;
  final Price? price;
  final List<String> sources;
  final bool isCustom;
  final String? createdBy;

  const CompostComponent({
    required this.id,
    required this.name,
    required this.nutrients,
    this.price,
    this.sources = const [],
    this.isCustom = false,
    this.createdBy,
  });

  String getName() {
    if (isCustom) {
      return name;
    }
    return S.current.getTranslation('component$id');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nutrients': nutrients.toJson(),
      'price': price?.toJson(),
      'sources': sources,
      'isCustom': isCustom,
      'createdBy': createdBy,
    };
  }

  static CompostComponent fromJson(Map<String, dynamic> json) {
    return CompostComponent(
      id: json['id'],
      name: json['name'],
      nutrients: NutrientContent.fromJson(json['nutrients']),
      price: json['price'] != null ? Price.fromJson(json['price']) : null,
      sources: List<String>.from(json['sources'] ?? []),
      isCustom: json['isCustom'] ?? false,
      createdBy: json['createdBy'],
    );
  }
}
