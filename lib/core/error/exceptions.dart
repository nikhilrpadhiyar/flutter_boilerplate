/// Base class for all application exceptions.
abstract class AppException implements Exception {
  const AppException({required this.message, this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => '$runtimeType(message: $message, code: $statusCode)';
}

class NetworkException extends AppException {
  const NetworkException({required super.message, super.statusCode});
}

class ApiException extends AppException {
  const ApiException({required super.message, super.statusCode});
}

class CacheException extends AppException {
  const CacheException({required super.message});
}

class ValidationException extends AppException {
  const ValidationException({required super.message});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Unauthorized. Please log in again.',
  });
}

class ServerException extends AppException {
  const ServerException({
    super.message = 'An unexpected server error occurred.',
    super.statusCode,
  });
}
