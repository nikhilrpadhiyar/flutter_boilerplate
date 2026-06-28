import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate/core/error/failures.dart';
import 'package:flutter_boilerplate/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_boilerplate/features/auth/domain/repositories/auth_repository.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {
  @override
  bool get isAuthenticated => false;

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async =>
      Right(
        UserEntity(
          id: 'mock-id',
          email: email,
          name: 'Mock User',
          createdAt: DateTime(2024),
        ),
      );
}
