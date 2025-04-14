class VehicleModel {
  final int id;
  final String name;
  final String imageUrl;
  final int seats;
  final int luggage;
  final int numberOfSeats;
  final bool airConditioning;

  VehicleModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.seats,
    required this.luggage,
    required this.numberOfSeats,
    required this.airConditioning,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      seats: json['seats'],
      luggage: json['luggage'],
      numberOfSeats: json['number_of_seats'],
      airConditioning: json['air_conditioning'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'seats': seats,
      'luggage': luggage,
      'number_of_seats': numberOfSeats,
      //'air_conditioning': airConditioning,
    };
  }
}
