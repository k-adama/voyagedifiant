import 'package:dio/dio.dart';
import 'package:voyagedifiant/core/models/hotel.dart';
import 'package:voyagedifiant/core/models/orders_model.dart';
import 'package:voyagedifiant/core/models/touristic_discovery.dart';
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
      // Capturer et afficher plus d'informations selon le type d'erreur
      if (e is DioException) {
        // Vérifie si l'exception Dio contient une réponse
        final message =
            e.response?.data["message"] ?? "Une erreur est survenue";
        return ApiResultService.failure(message);
      } else {
        // Si ce n'est pas une erreur Dio, affiche plus d'infos
        return ApiResultService.failure("Erreur inconnue: $e");
      }
    }
  }

  Future<void> createReservation(Map<String, dynamic> data) async {
    final client = server.client(requireAuth: true);
    final response = await client.post('/vehicle-reservations', data: data);
    // Tu peux ici retourner response.data si besoin
  }

Future<ApiResultService<List<OrderModel>>> getUserOrders({int page = 1}) async {
  try {
    final client = server.client(requireAuth: true);
    final response = await client.get('/user/orders?page=$page');

    final rawData = response.data['data'];
    final list = rawData['data'] as List;

    final orders = list.map((e) => OrderModel.fromJson(e)).toList();

    return ApiResultService.success(data: orders);
  } catch (e) {
    if (e is DioException) {
      final message = e.response?.data["message"] ?? "Une erreur est survenue historique commandes";
      return ApiResultService.failure(message);
    }
    return ApiResultService.failure("Erreur check hisoriques commandes");
  }
}

}
