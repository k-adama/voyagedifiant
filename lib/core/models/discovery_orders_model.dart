class DiscoveryOrder {
  final String siteName;
  final String? classe;
  final String? lieuDeRassemblement;
  final String reservationPeriod;
  final String? price;
  final double? totalPrice;
  final String? username;
  final String? phone;
  final String? amountPaid;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DiscoveryOrder({
    required this.siteName,
    this.classe,
    this.lieuDeRassemblement,
    required this.reservationPeriod,
    this.price,
    this.totalPrice,
    this.username,
    this.phone,
    this.amountPaid,
    this.createdAt,
    this.updatedAt,
  });

  factory DiscoveryOrder.fromJson(Map<String, dynamic> json) {
    return DiscoveryOrder(
      siteName: json['site_name'] ?? '',
      classe: json['classe'],
      lieuDeRassemblement: json['lieu_de_rassemblement'],
      reservationPeriod: json['reservation_period'] ?? '',
      price: json['price'],
      totalPrice: json['total_price'] != null
          ? double.tryParse(json['total_price'].toString())
          : null,
      username: json['username'],
      phone: json['phone'],
      amountPaid: json['amount_paid'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }
}
