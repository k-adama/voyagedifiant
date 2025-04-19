import 'network_exceptions.service.dart';

class ApiResultService<T> {
  final T? data;
  final String? error;

  ApiResultService.success({this.data}) : error = null;
  ApiResultService.failure(this.error) : data = null;

  // Méthode pour vérifier si la réponse est un succès
  bool isSuccess() => error == null;
  void when(
      {required Function(T data) success,
      required Function(String error) failure}) {
    if (isSuccess()) {
      success(data!); // Appelle le callback de succès
    } else {
      failure(error!); // Appelle le callback d'échec
    }
  }
  /*final T? data;
  final NetworkExceptionsService error;
  final int statusCode;

  const ApiResultService.success({required this.data})
      : error = const NetworkExceptionsService(),
        statusCode = 200;

  const ApiResultService.failure(
      {required this.error, required this.statusCode})
      : data = null;

  R when<R>({
    required R Function(T? data) success,
    required R Function(NetworkExceptionsService error, int statusCode) failure,
  }) {
    if (this.data != null) {
      return success(this.data);
    } else if (this.error != null && this.statusCode != null) {
      return failure(this.error, this.statusCode);
    } else {
      throw Exception('Invalid ApiResult type');
    }
  }*/
}
