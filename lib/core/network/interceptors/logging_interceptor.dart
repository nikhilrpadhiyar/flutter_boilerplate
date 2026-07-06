import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/core/config/env_config.dart';
import 'package:logger/logger.dart';

/// Logs requests and responses only in development builds.
class LoggingInterceptor extends Interceptor {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      dateTimeFormat: DateTimeFormat.dateAndTime,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (EnvConfig.isDevelopment) {
      _logger.i(
        '[${options.method}] ${options.uri}\n'
        'Headers: ${options.headers}\n'
        'Data: ${options.data}',
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (EnvConfig.isDevelopment) {
      _logger.d(
        '[${response.statusCode}] ${response.requestOptions.uri}\n'
        'Data: ${response.data}',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      '[ERROR] ${err.requestOptions.uri}\n'
      'Message: ${err.message}',
    );
    handler.next(err);
  }
}
