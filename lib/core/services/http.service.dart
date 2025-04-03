import 'package:dio/dio.dart';
import 'package:voyagedifiant/core/config/env/environment.dart';
import 'package:voyagedifiant/core/interceptors/token.interceptor.dart';

class HttpService {
  Dio client({
    bool requireAuth = false,
  }) {
    final options = BaseOptions(
      baseUrl: Environment.backEnPoint,
      connectTimeout: const Duration(milliseconds: 60 * 1000),
      receiveTimeout: const Duration(milliseconds: 60 * 1000),
      sendTimeout: const Duration(milliseconds: 60 * 1000),
      headers: {
        'Accept':
            'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
        'Content-type': 'application/json',
      },
    );

    final dio = Dio(options);

    dio.interceptors.add(TokenInterceptor(requireAuth: requireAuth));
    // dio.interceptors.add(RefreshTokenInterceptor(dio));
    dio.interceptors.add(
      LogInterceptor(
        responseHeader: false,
        requestHeader: true,
        responseBody: true,
        requestBody: true,
      ),
    );

    return dio;
  }
}
