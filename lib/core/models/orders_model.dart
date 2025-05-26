import 'package:voyagedifiant/core/models/vehicle_orders_model.dart';

class OrderModel {
  final int id;
  final String type;
  final String totalPrice;
  final VehicleOrdersModels? vehicleDetails;
  //final HotelOrdersModels? hotelDetails; // Exemple pour hotel

  OrderModel({
    required this.id,
    required this.type,
    required this.totalPrice,
    this.vehicleDetails,
    // this.hotelDetails,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    VehicleOrdersModels? vehicleDetails;
    // HotelOrdersModels? hotelDetails;

    if (json['type'] == 'vehicle' && json['details'] != null) {
      vehicleDetails = VehicleOrdersModels.fromJson(
          Map<String, dynamic>.from(json['details']));
    } else if (json['type'] == 'hotel' && json['details'] != null) {
      // hotelDetails = HotelOrdersModels.fromJson(Map<String, dynamic>.from(json['details']));
    }

    return OrderModel(
      id: json['id'],
      type: json['type'],
      totalPrice: json['total_price'].toString(),
      vehicleDetails: vehicleDetails,
      // hotelDetails: hotelDetails,
    );
  }
}
