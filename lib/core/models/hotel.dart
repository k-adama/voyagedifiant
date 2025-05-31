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
  final int priceStandard;
  final int pricePremium;
  final int priceSuite;

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
      name: json['name'] ?? '',
      descriptionFr: json['description_fr'] ?? '',
      descriptionEn: json['description_en'] ?? '',
      hasCleaning: json['has_cleaning'].toString() == '1',
      hasWifi: json['has_wifi'].toString() == '1',
      hasBreakfast: json['has_breakfast'].toString() == '1',
      city: json['city'] ?? '',
      neighborhood: json['emplacement'] ?? '',
      numberOfBeds: int.tryParse(json['number_of_beds'].toString()) ?? 0,
      numberOfBathrooms:
          int.tryParse(json['number_of_bathrooms'].toString()) ?? 0,
      numberOfAc: int.tryParse(json['number_of_ac'].toString()) ?? 0,
      detailsFr: json['details_fr'] ?? '',
      detailsEn: json['details_en'] ?? '',
      priceStandard: int.tryParse(json['price_standard'].toString()) ?? 0,
      pricePremium: int.tryParse(json['price_premium'].toString()) ?? 0,
      priceSuite: int.tryParse(json['price_suite'].toString()) ?? 0,
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
      'has_cleaning': hasCleaning ? '1' : '0',
      'has_wifi': hasWifi ? '1' : '0',
      'has_breakfast': hasBreakfast ? '1' : '0',
      'city': city,
      'emplacement': neighborhood,
      'number_of_beds': numberOfBeds,
      'number_of_bathrooms': numberOfBathrooms,
      'number_of_ac': numberOfAc,
      'price_standard': priceStandard,
      'price_premium': pricePremium,
      'price_suite': priceSuite,
    };
  }

  static bool _toBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) return value == '1' || value.toLowerCase() == 'true';
    return false;
  }
}
