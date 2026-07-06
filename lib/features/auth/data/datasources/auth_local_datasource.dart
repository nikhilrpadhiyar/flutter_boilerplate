import 'dart:convert';

import 'package:flutter_boilerplate/core/constants/app_constants.dart';
import 'package:flutter_boilerplate/core/error/exceptions.dart';
import 'package:flutter_boilerplate/core/storage/storage_service.dart';
import 'package:flutter_boilerplate/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  UserModel? getCachedUser();
  Future<void> cacheTokens({required String accessToken, String? refreshToken});
  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._storage);

  final StorageService _storage;

  @override
  Future<void> cacheUser(UserModel user) async {
    await _storage.write(AppConstants.keyUser, jsonEncode(user.toJson()));
  }

  @override
  UserModel? getCachedUser() {
    final String? raw = _storage.read<String>(AppConstants.keyUser);
    if (raw == null) return null;
    try {
      return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      throw const CacheException(message: 'Failed to parse cached user.');
    }
  }

  @override
  Future<void> cacheTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _storage.write(AppConstants.keyAccessToken, accessToken);
    if (refreshToken != null) {
      await _storage.write(AppConstants.keyRefreshToken, refreshToken);
    }
  }

  @override
  Future<void> clearAuthData() async {
    await _storage.remove(AppConstants.keyUser);
    await _storage.remove(AppConstants.keyAccessToken);
    await _storage.remove(AppConstants.keyRefreshToken);
  }
}
