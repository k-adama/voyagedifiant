import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/services/api_result.service.dart';
import 'package:voyagedifiant/core/services/http.service.dart';
import 'package:voyagedifiant/core/services/network_exceptions.service.dart';

class AuthRepository {
  HttpService server = HttpService();


  Future<ApiResultService> getConnexion() async {
    try {
      final client = server.client(requireAuth: true);
      final response = await client.get(
        '/connexion.php',
      );
      debugPrint(response.data.toString());
      return ApiResultService.success(
        data: response.data,
      );
    } catch (e) {
      debugPrint('==> connexion failure: $e');
      return ApiResultService.failure(
          error: NetworkExceptionsService.getDioException(e),
          statusCode: NetworkExceptionsService.getDioStatus(e));
    }
  }
  /*  Future<ApiResultService<LoginResponseEntity>> login({
    required String email,
    required String password,
  }) async {
    final data = LoginEntity(email: email, password: password);
    try {
      final client =
          server.client(requireAuth: false, requireRestaurantId: false);
      final response = await client.post(
        '/auth/login/',
        data: data,
      );
      return ApiResultService.success(
        data: LoginResponseEntity.fromJson(response.data),
      );
    } catch (e) {
      debugPrint('==> login failure: $e');
      return ApiResultService.failure(
          error: NetworkExceptionsService.getDioException(e),
          statusCode: NetworkExceptionsService.getDioStatus(e));
    }
  }*/
}
