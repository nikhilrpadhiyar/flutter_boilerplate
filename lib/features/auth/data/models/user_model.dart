import 'package:flutter_boilerplate/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as String,
    email: json['email'] as String,
    name: json['name'] as String,
    avatarUrl: json['avatar_url'] as String?,
    phoneNumber: json['phone_number'] as String?,
    createdAt: DateTime.parse(json['created_at'] as String),
    accessToken: json['access_token'] as String?,
    refreshToken: json['refresh_token'] as String?,
  );
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    super.avatarUrl,
    super.phoneNumber,
    required super.createdAt,
    this.accessToken,
    this.refreshToken,
  });

  final String? accessToken;
  final String? refreshToken;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'email': email,
    'name': name,
    'avatar_url': avatarUrl,
    'phone_number': phoneNumber,
    'created_at': createdAt.toIso8601String(),
  };

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? avatarUrl,
    String? phoneNumber,
    DateTime? createdAt,
    String? accessToken,
    String? refreshToken,
  }) => UserModel(
    id: id ?? this.id,
    email: email ?? this.email,
    name: name ?? this.name,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    createdAt: createdAt ?? this.createdAt,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken,
  );
}
