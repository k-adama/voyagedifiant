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
        '/hello',
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

  Future<ApiResultService> register({
    required String username,
    required String email,
    required String city,
    required String number,
    required String password,
  }) async {
    try {
      final client = server.client(requireAuth: false);
      final response = await client.post(
        '/register',
        data: {
          'username': username,
          'email': email,
          'city': city,
          'number': number,
          'password': password,
        },
      );
      debugPrint(response.data.toString());
      return ApiResultService.success(data: response.data);
    } catch (e) {
      debugPrint('==> register failure: $e');
      return ApiResultService.failure(
        error: NetworkExceptionsService.getDioException(e),
        statusCode: NetworkExceptionsService.getDioStatus(e),
      ); // Retourne une réponse d'échec en cas d'erreur
    }
  }

  Future<ApiResultService> login(
      {required String number, required String password}) async {
    try {
      final client = server.client(requireAuth: false);
      final response = await client.post(
        '/login',
        data: {'number': number, 'password': password},
      );
      debugPrint(response.data.toString());
      return ApiResultService.success(data: response.data);
    } catch (e) {
      debugPrint('==> login failure: $e');
      return ApiResultService.failure(
        error: NetworkExceptionsService.getDioException(e),
        statusCode: NetworkExceptionsService.getDioStatus(e),
      );
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
