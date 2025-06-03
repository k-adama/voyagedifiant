class DiscoveryInvoiceModel {
  final String name;
  final String classe;
  final String lieuDeRassemblement;
  final String reservationPeriod;
  final String price;
  final int totalPrice;
  final String totalPriceOperation;

  DiscoveryInvoiceModel({
    required this.name,
    required this.classe,
    required this.lieuDeRassemblement,
    required this.reservationPeriod,
    required this.price,
    required this.totalPrice,
    required this.totalPriceOperation,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'class': classe,
        'lieuDeRassemblement': lieuDeRassemblement,
        'reservationPeriod': reservationPeriod,
        'price': price,
        'totalPrice': totalPrice,
        'totalPriceOperation': totalPriceOperation,
      };

  factory DiscoveryInvoiceModel.fromJson(Map<String, dynamic> json) =>
      DiscoveryInvoiceModel(
        name: json['name'],
        classe: json['class'],
        lieuDeRassemblement: json['lieuDeRassemblement'],
        reservationPeriod: json['reservationPeriod'],
        price: json['price'],
        totalPrice: json['totalPrice'],
        totalPriceOperation: json['totalPriceOperation'],
      );
}
