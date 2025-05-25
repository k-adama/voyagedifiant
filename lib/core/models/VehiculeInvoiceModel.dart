class VehiculeInvoiceModel {
  final String name;
  final String bag;
  final String person;
  final String airConditioning;
  final String classe;
  final String locationVehiclePeriod;
  final String driver;
  final String price;
  final double totalPrice;
  final String totalPriceOperation;

  VehiculeInvoiceModel({
    required this.name,
    required this.bag,
    required this.person,
    required this.airConditioning,
    required this.classe,
    required this.locationVehiclePeriod,
    required this.driver,
    required this.price,
    required this.totalPrice,
    required this.totalPriceOperation,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'bag': bag,
        'person': person,
        'airConditioning': airConditioning,
        'class': classe,
        'locationVehiclePeriod': locationVehiclePeriod,
        'driver': driver,
        'price': price,
        'totalPrice': totalPrice,
        'totalPriceOperation': totalPriceOperation,
      };

  factory VehiculeInvoiceModel.fromJson(Map<String, dynamic> json) =>
      VehiculeInvoiceModel(
        name: json['name'],
        bag: json['bag'],
        person: json['person'],
        airConditioning: json['airConditioning'],
        classe: json['class'],
        locationVehiclePeriod: json['locationVehiclePeriod'],
        driver: json['driver'],
        price: json['price'],
        totalPrice: json['totalPrice'],
        totalPriceOperation: json['totalPriceOperation'],
      );
}
