class TouristicDiscovery {
  final int id;
  final String name;
  final String location;
  final String description;
  final double standardPrice;
  final double premiumPrice;
  final String visitStartTime;
  final String visitEndTime;

  TouristicDiscovery({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.standardPrice,
    required this.premiumPrice,
    required this.visitStartTime,
    required this.visitEndTime,
  });

  factory TouristicDiscovery.fromJson(Map<String, dynamic> json) {
    return TouristicDiscovery(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      standardPrice: double.tryParse(json['standard_price'].toString()) ?? 0.0,
      premiumPrice: double.tryParse(json['premium_price'].toString()) ?? 0.0,
      visitStartTime: json['visit_start_time'],
      visitEndTime: json['visit_end_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'standard_price': standardPrice,
      'premium_price': premiumPrice,
      'visit_start_time': visitStartTime,
      'visit_end_time': visitEndTime,
    };
  }
}
