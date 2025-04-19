class HotelModel {
  final int id;
  final String name;
  final String description;
  final bool hasCleaning;
  final bool hasWifi;
  final bool hasBreakfast;
  final String city;
  final String neighborhood;
  final int numberOfBeds;
  final int numberOfBathrooms;
  final int numberOfAc;
  final String details;
  final double priceStandard;
  final double pricePremium;
  final double priceSuite;

  HotelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.hasCleaning,
    required this.hasWifi,
    required this.hasBreakfast,
    required this.city,
    required this.neighborhood,
    required this.numberOfBeds,
    required this.numberOfBathrooms,
    required this.numberOfAc,
    required this.details,
    required this.priceStandard,
    required this.pricePremium,
    required this.priceSuite,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) {
    return HotelModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      hasCleaning: json['has_cleaning'] == 1,
      hasWifi: json['has_wifi'] == 1,
      hasBreakfast: json['has_breakfast'] == 1,
      city: json['city'],
      neighborhood: json['emplacement'] ?? '',
      numberOfBeds: json['number_of_beds'] ?? 0,
      numberOfBathrooms: json['number_of_bathrooms'] ?? 0,
      numberOfAc: json['number_of_ac'] ?? 0,
      details: json['details'] ?? '',
      priceStandard: _parsePrice(json['price_standard']),
      pricePremium: _parsePrice(json['price_premium']),
      priceSuite: _parsePrice(json['price_suite']),
    );
  }

  static double _parsePrice(dynamic price) {
    if (price is String) {
      return double.tryParse(price) ?? 0.0;
    }
    return price?.toDouble() ?? 0.0;
  }
}
