import 'package:dio/dio.dart';
import 'package:sikshya/core/shared_prefences/shared_prefences_service.dart';

class TokenInterceptor extends Interceptor {
  final SharedPreferencesService _preferencesService;
  TokenInterceptor({required SharedPreferencesService preferencesService})
      : _preferencesService = preferencesService;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _preferencesService.token;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
