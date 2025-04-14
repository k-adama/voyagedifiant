import 'package:dio/dio.dart';
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
}
