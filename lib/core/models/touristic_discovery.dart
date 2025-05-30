class TouristicDiscovery {
  final int id;
  final String name;
  final String location;
  final String descriptionFr;
  final String descriptionEn;
  final int standardPrice;
  final int suitePrice;
  final int premiumPrice;
  final String visitStartTime;
  final String visitEndTime;

  TouristicDiscovery({
    required this.id,
    required this.name,
    required this.location,
    required this.descriptionFr,
    required this.descriptionEn,
    required this.standardPrice,
    required this.suitePrice,
    required this.premiumPrice,
    required this.visitStartTime,
    required this.visitEndTime,
  });

  factory TouristicDiscovery.fromJson(Map<String, dynamic> json) {
    return TouristicDiscovery(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      descriptionFr: json['description_fr'] ?? '',
      descriptionEn: json['description_en'] ?? '',
      standardPrice: int.tryParse(json['standard_price'].toString()) ?? 0,
      suitePrice: int.tryParse(json['suite_price'].toString()) ?? 0,
      premiumPrice: int.tryParse(json['premium_price'].toString()) ?? 0,
      visitStartTime: json['visit_start_time'],
      visitEndTime: json['visit_end_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description_fr': descriptionFr,
      'description_en': descriptionEn,
      'standard_price': standardPrice,
      'suite_price': suitePrice,
      'premium_price': premiumPrice,
      'visit_start_time': visitStartTime,
      'visit_end_time': visitEndTime,
    };
  }
}
