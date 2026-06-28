import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/core/error/exceptions.dart';

/// Converts Dio errors into typed [AppException] subclasses.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException(
          message: 'Connection timed out. Please try again.',
          statusCode: err.response?.statusCode,
        );

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode ?? 0;
        if (statusCode == 401) {
          throw UnauthorizedException();
        }
        throw ApiException(
          message:
              err.response?.data?['message']?.toString() ??
              'Server returned an error.',
          statusCode: statusCode,
        );

      case DioExceptionType.cancel:
        throw NetworkException(message: 'Request cancelled.');

      default:
        throw NetworkException(
          message: 'No internet connection. Please check your network.',
        );
    }
  }
}
