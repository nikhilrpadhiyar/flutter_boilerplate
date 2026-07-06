import 'package:equatable/equatable.dart';

/// Domain-layer failures returned by repositories via [Either].
abstract class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  @override
  List<Object> get props => <Object>[message];
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

class ApiFailure extends Failure {
  const ApiFailure({required super.message, this.statusCode});

  final int? statusCode;

  @override
  List<Object> get props => <Object>[message, statusCode ?? 0];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Unauthorized. Please log in again.',
  });
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'An unexpected server error occurred.'});
}
