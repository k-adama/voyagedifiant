class VehicleModel {
  final int id;
  final String name;
  final String imageUrl;
  final int luggage;
  final int numberOfSeats;
  final bool airConditioning;
  final double economyPrice;
  final double businessPrice;

  VehicleModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.luggage,
    required this.numberOfSeats,
    required this.airConditioning,
    required this.economyPrice,
    required this.businessPrice,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      imageUrl: json['image_url'] ?? '',
      luggage: int.tryParse(json['luggage'].toString()) ?? 0,
      numberOfSeats: int.tryParse(json['number_of_seats'].toString()) ?? 0,
      airConditioning: json['air_conditioning'].toString() == 'true' ||
          json['air_conditioning'].toString() == '1',
      economyPrice: double.tryParse(json['price_economy'].toString()) ?? 0.0,
      businessPrice: double.tryParse(json['price_business'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'luggage': luggage,
      'number_of_seats': numberOfSeats,
      'air_conditioning': airConditioning,
      'price_economy': economyPrice, // Modifié ici
      'price_business': businessPrice, // Modifié ici
    };
  }
}
