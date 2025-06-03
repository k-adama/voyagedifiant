class VehicleOrdersModels {
  final String vehicleName;
  final String driverName;
  final String rentalPeriod;
  final double totalPrice;
  //final String vehicleImageUrl;
  final DateTime createdAt;

  VehicleOrdersModels({
    required this.vehicleName,
    required this.driverName,
    required this.rentalPeriod,
    required this.totalPrice,
    //required this.vehicleImageUrl,
    required this.createdAt,
  });

  factory VehicleOrdersModels.fromJson(Map<String, dynamic> json) {
    return VehicleOrdersModels(
      vehicleName: json['vehicle_name'] ?? '',
      driverName: json['driver'] ?? '',
      rentalPeriod: json['rental_period'] ?? '',
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime
              .now(),
    );
  }
}
