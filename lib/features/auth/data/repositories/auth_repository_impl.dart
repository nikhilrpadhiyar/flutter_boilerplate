import 'package:dartz/dartz.dart';
import 'package:flutter_boilerplate/core/error/exceptions.dart';
import 'package:flutter_boilerplate/core/error/failures.dart';
import 'package:flutter_boilerplate/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:flutter_boilerplate/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_boilerplate/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_boilerplate/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remote = remoteDataSource,
        _local = localDataSource;

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  @override
  bool get isAuthenticated => _local.getCachedUser() != null;

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remote.login(email: email, password: password);
      await _local.cacheUser(user);
      if (user.accessToken != null) {
        await _local.cacheTokens(
          accessToken: user.accessToken!,
          refreshToken: user.refreshToken,
        );
      }
      return Right(user);
    } on UnauthorizedException catch (e) {
      return Left(UnauthorizedFailure(message: e.message));
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await _remote.register(
        name: name,
        email: email,
        password: password,
      );
      await _local.cacheUser(user);
      if (user.accessToken != null) {
        await _local.cacheTokens(
          accessToken: user.accessToken!,
          refreshToken: user.refreshToken,
        );
      }
      return Right(user);
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remote.logout();
      await _local.clearAuthData();
      return const Right(null);
    } on AppException catch (e) {
      // Still clear local data even if remote call fails
      await _local.clearAuthData();
      return Left(ApiFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final cached = _local.getCachedUser();
      if (cached != null) return Right(cached);
      final user = await _remote.getCurrentUser();
      await _local.cacheUser(user);
      return Right(user);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({required String email}) async {
    try {
      await _remote.forgotPassword(email: email);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure(message: e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    }
  }
}
