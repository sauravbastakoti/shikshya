import 'dart:developer';

import 'package:dio/dio.dart';

class HandleException implements Exception {
  String message = '';
  HandleException.fromDioError(DioException dioError) {
    log(dioError.type.toString());
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection Timeout Error';
        break;
      case DioExceptionType.cancel:
        message = 'Request Canceled';
        break;
      case DioExceptionType.connectionError:
        message = 'Unable to connect to the server';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Send Timeout Error';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Reciever Timeout Error';
        break;
      case DioExceptionType.unknown:
        message = 'Unexpected error occured, Please try again';
        break;
      case DioExceptionType.badCertificate:
        message = 'Invalid Certicificate , Please check yur Network Setting';
        break;

      case DioExceptionType.badResponse:
        message = _handleError(dioError);
        break;
    }
  }
  String _handleError(DioException error) {
    switch (error.response!.statusCode) {
      case 400:
        final response = error.response!.data as Map<String, dynamic>;
        log('=== RESPONSE ERROR === ');

        log(response.toString());
        final errorMessage = response.values.first;
        if (errorMessage is List) {
          return errorMessage.first;
        }
        if (errorMessage is String) {
          return errorMessage;
        }
        return 'Bad Request';
      case 500:
        return 'Internal Server Error';

      case 404:
        return 'Not found';
      case 405:
        return 'Method not allowed';
      case 422:
        return 'Something went wrong';

      default:
        return 'Something went wrong';
    }
  }

  @override
  String toString() => message;
}
