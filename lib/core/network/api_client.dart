import 'package:dio/dio.dart';
import 'package:flutter_boilerplate/core/config/env_config.dart';
import 'package:flutter_boilerplate/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_boilerplate/core/network/interceptors/error_interceptor.dart';
import 'package:flutter_boilerplate/core/network/interceptors/logging_interceptor.dart';
import 'package:flutter_boilerplate/core/storage/storage_service.dart';

/// Singleton Dio wrapper. All HTTP calls must go through this client.
class ApiClient {
  ApiClient._();

  static ApiClient? _instance;
  static ApiClient get instance => _instance ??= ApiClient._();

  late final Dio _dio;

  Dio get dio => _dio;

  void init(StorageService storage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.apiBaseUrl,
        connectTimeout: Duration(milliseconds: EnvConfig.apiTimeout),
        receiveTimeout: Duration(milliseconds: EnvConfig.apiTimeout),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    )
      ..interceptors.add(AuthInterceptor(storage))
      ..interceptors.add(ErrorInterceptor())
      ..interceptors.add(LoggingInterceptor());
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.get<T>(path, queryParameters: queryParameters, options: options);

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Options? options,
  }) =>
      _dio.put<T>(path, data: data, options: options);

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Options? options,
  }) =>
      _dio.delete<T>(path, data: data, options: options);

  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Options? options,
  }) =>
      _dio.patch<T>(path, data: data, options: options);
}
