import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:voyagedifiant/core/models/hotel.dart';
import 'package:voyagedifiant/core/models/orders_model.dart';
import 'package:voyagedifiant/core/models/touristic_discovery.dart';
import 'package:voyagedifiant/core/models/user.dart';
import 'package:voyagedifiant/core/models/vehicule.dart';
import 'package:voyagedifiant/core/services/api_result.service.dart';
import 'package:voyagedifiant/core/services/http.service.dart';

class HomeRepository {
  HttpService server = HttpService();
  Future<ApiResultService<List<VehicleModel>>> getVehicles() async {
    try {
      final client = server.client(requireAuth: false);
      final response = await client.get('/vehicles');

      final List data = response.data as List;

      final vehicles = data.map((e) => VehicleModel.fromJson(e)).toList();

      return ApiResultService.success(data: vehicles);
    } catch (e) {
      if (e is DioException) {
        final message =
            e.response?.data["message"] ?? "Une erreur est survenue";
        return ApiResultService.failure(message);
      }
      return ApiResultService.failure("Erreur inconnue");
    }
  }

  Future<ApiResultService<List<TouristicDiscovery>>> getTouristicSites() async {
    try {
      final client = server.client(requireAuth: false);
      final response = await client.get('/touristic-discoveries');

      final List data = response.data as List;

      final touristicSites =
          data.map((e) => TouristicDiscovery.fromJson(e)).toList();

      return ApiResultService.success(data: touristicSites);
    } catch (e) {
      if (e is DioException) {
        final message =
            e.response?.data["message"] ?? "Une erreur est survenue";
        return ApiResultService.failure(message);
      }
      return ApiResultService.failure("Erreur inconnue");
    }
  }

  Future<ApiResultService<List<HotelModel>>> getHotels() async {
    try {
      final client = server.client(requireAuth: false);
      final response = await client.get('/hotels');

      // Vérifie si la réponse est bien une liste
      if (response.data is List) {
        final List data = response.data as List;
        final hotels = data.map((e) => HotelModel.fromJson(e)).toList();
        return ApiResultService.success(data: hotels);
      } else {
        return ApiResultService.failure("Format de réponse invalide");
      }
    } catch (e) {
      if (e is DioException) {
        final message =
            e.response?.data["message"] ?? "Une erreur est survenue";
        return ApiResultService.failure(message);
      } else {
        return ApiResultService.failure("Erreur inconnue: $e");
      }
    }
  }

  Future<void> createReservation(Map<String, dynamic> data) async {
    final client = server.client(requireAuth: true);
    await client.post('/vehicle-reservations', data: data);
  }

  Future<void> createDiscoveryReservation(Map<String, dynamic> data) async {
    final client = server.client(requireAuth: true);
    await client.post('/discovery-orders', data: data);
  }

  Future<void> createHotelReservation(Map<String, dynamic> data) async {
    final client = server.client(requireAuth: true);
    await client.post('/hotels-orders', data: data);
  }

  Future<ApiResultService<List<OrderModel>>> getUserOrders(
      {int page = 1}) async {
    try {
      final client = server.client(requireAuth: true);
      final response = await client.get('/orders?page=$page');

      final list = response.data['data'] as List;

      final orders = list.map((e) => OrderModel.fromJson(e)).toList();

      return ApiResultService.success(data: orders);
    } catch (e) {
      if (e is DioException) {
        final message = e.response?.data["message"] ??
            "Une erreur est survenue historique commandes";
        return ApiResultService.failure(message);
      }
      return ApiResultService.failure("Erreur check historiques commandes");
    }
  }

  Future<void> sendHotelInvoicePdf({
    required Uint8List pdfBytes,
    required String email,
  }) async {
    final client = server.client(requireAuth: true);

    final formData = FormData.fromMap({
      'email': email,
      'invoice_pdf': MultipartFile.fromBytes(
        pdfBytes,
        filename: 'facture.pdf',
        contentType: MediaType('application', 'pdf'),
      ),
    });

    try {
      final response = await client.post('/send-invoice-pdf', data: formData);
      print('PDF envoyé avec succès : ${response.data}');
    } catch (e) {
      print('Erreur lors de l’envoi du PDF : $e');
      rethrow;
    }
  }

  Future<UserModel> updateUserProfile(Map<String, dynamic> data) async {
    final client = server.client(requireAuth: true);
    final response = await client.put('/profile/update', data: data);
    final json = response.data;

    final adaptedJson = {
      'user': json['data'],
      'token': null,
    };

    return UserModel.fromJson(adaptedJson);
  }

  Future<void> changePassword(Map<String, dynamic> data) async {
    final client = server.client(requireAuth: true);
    await client.put('/profile/change-password', data: data);
  }
}
