class OrderModel {
  final String vehicleName;
  final String driverName;
  final String rentalPeriod;
  final double totalPrice;
  //final String vehicleImageUrl;
  final DateTime createdAt; 

  OrderModel({
    required this.vehicleName,
    required this.driverName,
    required this.rentalPeriod,
    required this.totalPrice,
    //required this.vehicleImageUrl,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      vehicleName: json['vehicle_name'] ?? '',
      driverName: json['driver'] ?? '',
      rentalPeriod: json['rental_period'] ?? '',
      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      //vehicleImageUrl: json['vehicle_image'] ?? '',
      createdAt: DateTime.parse(json['created_at']),  
    );
  }
}
