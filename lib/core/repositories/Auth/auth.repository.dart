import 'package:flutter/material.dart';
import 'package:voyagedifiant/core/services/api_result.service.dart';
import 'package:voyagedifiant/core/services/http.service.dart';

class AuthRepository {
  HttpService server = HttpService();
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
