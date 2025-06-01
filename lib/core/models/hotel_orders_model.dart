class HotelsOrdersModel {
  final String hotelName;
  final String driverName;
  final String? classe;
  final String? city;
  final String reservationPeriod;
  final String? price;
  final double? totalPrice;
  final String? username;
  final String? phone;
  final String? amountPaid;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  HotelsOrdersModel({
    required this.hotelName,
    this.classe,
    this.city,
    required this.reservationPeriod,
    this.price,
    this.totalPrice,
    this.username,
    this.phone,
    this.amountPaid,
    this.createdAt,
    this.updatedAt,
    required this.driverName,
  });

  factory HotelsOrdersModel.fromJson(Map<String, dynamic> json) {
    return HotelsOrdersModel(
      hotelName: json['hotel_name'] ?? '',
      driverName: json['driver_name'] ?? '',
      classe: json['classe'],
      city: json['city'],
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
