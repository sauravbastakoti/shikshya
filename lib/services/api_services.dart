import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sikshya/core/shared_prefences/exception.dart';
import 'package:sikshya/core/shared_prefences/locator.dart';
import 'package:sikshya/core/shared_prefences/shared_prefences_service.dart';
import 'package:sikshya/services/redirect_interceptor.dart';
import 'package:sikshya/services/token_interceptor.dart';
import 'package:sikshya/utils/api_string.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options = BaseOptions(
      baseUrl: ApiString.baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.interceptors.addAll([
      TokenInterceptor(
          preferencesService: locator.get<SharedPreferencesService>()),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: true,
      ),
      RedirectInterceptor(),
    ]);
  }

  /* Api Get Request */
  Future<Response> getRequest(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response =
          await _dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw HandleException.fromDioError(e);
    }
  }

  /* Api Post Request */
  Future<Response> postRequest(
    String endpoint,
    dynamic data, {
    Options? option,
  }) async {
    try {
      final response = await _dio.post(endpoint, data: data, options: option);
      return response;
    } on DioException catch (e) {
      throw HandleException.fromDioError(e);
    }
  }

  /* Api Patch Request */
  Future<Response> patchRequest(
    String endpoint,
    dynamic data, {
    Options? option,
  }) async {
    try {
      final response = await _dio.patch(endpoint, data: data, options: option);
      return response;
    } on DioException catch (e) {
      throw HandleException.fromDioError(e);
    }
  }

  /* Api Delete Request */
  Future<Response> deleteRequest(String endpoint, {dynamic data}) async {
    try {
      final response = await _dio.delete(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw HandleException.fromDioError(e);
    }
  }
}
