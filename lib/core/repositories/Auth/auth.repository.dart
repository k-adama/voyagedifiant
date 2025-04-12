import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/models/user.dart';
import 'package:voyagedifiant/core/services/api_result.service.dart';
import 'package:voyagedifiant/core/services/http.service.dart';
import 'package:voyagedifiant/core/services/network_exceptions.service.dart';

class AuthRepository {
  HttpService server = HttpService();

  /*Future<ApiResultService> getConnexion() async {
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
  }*/

  Future<ApiResultService<UserModel>> register({
    required String name,
    required String email,
    required String country,
    required String phone,
    required String password,
  }) async {
    try {
      final client = server.client(requireAuth: false);
      final response = await client.post(
        '/register',
        data: {
          'name': name,
          'email': email,
          'country': country,
          'phone': phone,
          'password': password,
        },
      );
      debugPrint(response.data.toString());
      return ApiResultService.success(data: UserModel.fromJson(response.data));
    } catch (e) {
      debugPrint('==> register failure: $e');
      return ApiResultService.failure(
        error: NetworkExceptionsService.getDioException(e),
        statusCode: NetworkExceptionsService.getDioStatus(e),
      ); // Retourne une réponse d'échec en cas d'erreur
    }
  }

  Future<ApiResultService<UserModel>> login(
      {required String phone, required String password}) async {
    try {
      final client = server.client(requireAuth: false);
      final response = await client.post(
        '/login',
        data: {'phone': phone, 'password': password},
      );
      debugPrint(response.data.toString());
      return ApiResultService.success(data: UserModel.fromJson(response.data));
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
