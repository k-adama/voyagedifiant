import 'package:voyagedifiant/core/models/discovery_orders_model.dart';
import 'package:voyagedifiant/core/models/hotel_orders_model.dart';
import 'package:voyagedifiant/core/models/vehicle_orders_model.dart';

class OrderModel {
  final int id;
  final String type;
  final String totalPrice;
  final VehicleOrdersModels? vehicleDetails;
  final DiscoveryOrder? discoveryDetails;
  final HotelsOrdersModel? hotelDetails;

  OrderModel({
    required this.id,
    required this.type,
    required this.totalPrice,
    this.vehicleDetails,
    this.discoveryDetails,
    this.hotelDetails,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    VehicleOrdersModels? vehicleDetails;
    DiscoveryOrder? discoveryDetails;
    HotelsOrdersModel? hotelDetails;

    if (json['type'] == 'vehicle' && json['details'] != null) {
      vehicleDetails = VehicleOrdersModels.fromJson(
          Map<String, dynamic>.from(json['details']));
    } else if (json['type'] == 'hotel' && json['details'] != null) {
      hotelDetails = HotelsOrdersModel.fromJson(
          Map<String, dynamic>.from(json['details']));
    }
     else if (json['type'] == 'site' && json['details'] != null) {
      discoveryDetails =
          DiscoveryOrder.fromJson(Map<String, dynamic>.from(json['details']));
    }

    return OrderModel(
      id: json['id'],
      type: json['type'],
      totalPrice: json['total_price'].toString(),
      vehicleDetails: vehicleDetails,
      discoveryDetails: discoveryDetails,
      hotelDetails: hotelDetails,
    );
  }
}
