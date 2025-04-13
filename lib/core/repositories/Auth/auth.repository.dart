import 'package:dio/dio.dart';
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
  Future<ApiResultService> sendOtp({
    required String email,
  }) async {
    try {
      final client = server.client(requireAuth: false);
      final response = await client.post(
        '/send-otp',
        data: {
          'email': email,
        },
      );
      debugPrint(response.data.toString());

      // Retourne la réponse de l'API encapsulée dans ApiResultService
      return ApiResultService.success(data: response.data);
    } catch (e) {
      debugPrint('==> otp failure: $e');
      if (e is DioException) {
        final message =
            e.response?.data["message"] ?? "Une erreur est survenue";
        return ApiResultService.failure(message);
      }
      return ApiResultService.failure("Erreur inconnue");
    }
  }

  /* Future<ApiResultService> sendOtp({
    required String email,
  }) async {
    try {
      final client = server.client(requireAuth: false);
      final response = await client.post(
        '/send-otp',
        data: {
          'email': email,
        },
      );
      debugPrint(response.data.toString());
      return ApiResultService.success(data: response.data);
    } catch (e) {
      debugPrint('==> otp failure: $e');
      if (e is DioException) {
        final message =
            e.response?.data["message"] ?? "Une erreur est survenue";
        return ApiResultService.failure(message);
      }
      return ApiResultService.failure("Erreur inconnue");
    }
  }*/

  Future<ApiResultService> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final client = server.client(requireAuth: false);
      final response = await client.post('/verify-otp', data: {
        'email': email,
        'otp': otp,
      });
      return ApiResultService.success(data: response.data);
    } catch (e) {
      if (e is DioException) {
        final message =
            e.response?.data["message"] ?? "Une erreur est survenue";
        return ApiResultService.failure(message);
      }
      return ApiResultService.failure("Erreur inconnue");
    }
  }

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
      if (e is DioException) {
        final message =
            e.response?.data["message"] ?? "Une erreur est survenue";
        return ApiResultService.failure(message);
      }
      return ApiResultService.failure("Erreur inconnue");
    }
  }

  Future<ApiResultService<UserModel>> login({
    required String phone,
    required String password,
  }) async {
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

      if (e is DioException) {
        final data = e.response?.data;

        // Récupère le message principal
        String message = data?["message"] ?? "Une erreur est survenue";

        // Récupère les erreurs spécifiques si présentes
        if (data?['errors'] != null) {
          final errors = data['errors'] as Map<String, dynamic>;

          // On concatène les messages d'erreur spécifiques
          List<String> detailedErrors = [];
          errors.forEach((key, value) {
            if (value is List && value.isNotEmpty) {
              detailedErrors.add(value.first.toString());
            }
          });

          if (detailedErrors.isNotEmpty) {
            message = detailedErrors.join('\n'); // si plusieurs erreurs
          }
        }

        return ApiResultService.failure(message);
      }

      return ApiResultService.failure("Erreur inconnue");
    }
  }

/*  Future<ApiResultService<UserModel>> login(
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
      if (e is DioException) {
        final message =
            e.response?.data["message"] ?? "Une erreur est survenue";
        return ApiResultService.failure(message);
      }
      return ApiResultService.failure("Erreur inconnue");
      
    }
  }*/

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
