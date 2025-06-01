class HotelInvoiceModel {
  final String hotelName;
  final String driverName;
  final String neighborhood;
  final String city;
  final String descriptionFr;
  final String descriptionEn;
  final String rentalPeriod;
  final String classe;
  final int totalPrice;
  final String price;
  final String totalPriceOperation;
  // final String hotelImageUrl;
  //final DateTime createdAt;

  HotelInvoiceModel({
    required this.hotelName,
    required this.driverName,
    required this.neighborhood,
    required this.city,
    required this.descriptionFr,
    required this.descriptionEn,
    required this.rentalPeriod,
    required this.classe,
    required this.totalPrice,
    required this.price,
    required this.totalPriceOperation,
    // required this.hotelImageUrl,
    // required this.createdAt,
  });

  factory HotelInvoiceModel.fromJson(Map<String, dynamic> json) {
    return HotelInvoiceModel(
      hotelName: json['hotel_name'] ?? '',
      driverName: json['driver'] ?? '',
      neighborhood: json['neighborhood'] ?? '',
      city: json['city'] ?? '',
      descriptionFr: json['description_fr'] ?? '',
      descriptionEn: json['description_en'] ?? '',
      rentalPeriod: json['rental_period'] ?? '',
      classe: json['class'] ?? '',
      totalPrice: int.tryParse(json['total_price'].toString()) ?? 0,
      price: json['price']?.toString() ?? '',
      totalPriceOperation: json['total_price_operation']?.toString() ?? '',
      // hotelImageUrl: json['hotel_image_url'] ?? '',
      /* createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),*/
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hotel_name': hotelName,
      'driver': driverName,
      'neighborhood': neighborhood,
      'city': city,
      'description_fr': descriptionFr,
      'description_en': descriptionEn,
      'rental_period': rentalPeriod,
      'class': classe,
      'total_price': totalPrice,
      'price': price,
      'total_price_operation': totalPriceOperation,
      // 'hotel_image_url': hotelImageUrl,
      //'created_at': createdAt.toIso8601String(),
    };
  }
}
