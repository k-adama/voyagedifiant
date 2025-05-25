class HotelModel {
  final int id;
  final String name;
  final String descriptionFr;
  final String descriptionEn;
  final bool hasCleaning;
  final bool hasWifi;
  final bool hasBreakfast;
  final String city;
  final String neighborhood;
  final int numberOfBeds;
  final int numberOfBathrooms;
  final int numberOfAc;
  final String detailsFr;
  final String detailsEn;
  final double priceStandard;
  final double pricePremium;
  final double priceSuite;

  HotelModel({
    required this.id,
    required this.name,
    required this.descriptionFr,
    required this.descriptionEn,
    required this.hasCleaning,
    required this.hasWifi,
    required this.hasBreakfast,
    required this.city,
    required this.neighborhood,
    required this.numberOfBeds,
    required this.numberOfBathrooms,
    required this.numberOfAc,
    required this.detailsFr,
    required this.detailsEn,
    required this.priceStandard,
    required this.pricePremium,
    required this.priceSuite,
  });

factory HotelModel.fromJson(Map<String, dynamic> json) {
  return HotelModel(
    id: int.tryParse(json['id'].toString()) ?? 0,
    name: json['name'],
    descriptionFr: json['description_fr'] ?? '',
    descriptionEn: json['description_en'] ?? '',
    hasCleaning: json['has_cleaning'].toString() == '1',
    hasWifi: json['has_wifi'].toString() == '1',
    hasBreakfast: json['has_breakfast'].toString() == '1',
    city: json['city'],
    neighborhood: json['emplacement'] ?? '',
    numberOfBeds: int.tryParse(json['number_of_beds'].toString()) ?? 0,
    numberOfBathrooms: int.tryParse(json['number_of_bathrooms'].toString()) ?? 0,
    numberOfAc: int.tryParse(json['number_of_ac'].toString()) ?? 0,
    detailsFr: json['details_fr'] ?? '',
    detailsEn: json['details_en'] ?? '',
    priceStandard: _parsePrice(json['price_standard']),
    pricePremium: _parsePrice(json['price_premium']),
    priceSuite: _parsePrice(json['price_suite']),
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description_fr': descriptionFr,
      'description_en': descriptionEn,
      'details_fr': detailsFr,
      'details_en': detailsEn,
    };
  }

  static double _parsePrice(dynamic price) {
    if (price is String) {
      return double.tryParse(price) ?? 0.0;
    }
    return price?.toDouble() ?? 0.0;
  }
  static bool _toBool(dynamic value) {
  if (value is bool) return value;
  if (value is int) return value == 1;
  if (value is String) return value == '1' || value.toLowerCase() == 'true';
  return false;
}

}
