import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    this.phoneNumber,
    required this.createdAt,
  });

  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final String? phoneNumber;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, email, name, avatarUrl, phoneNumber, createdAt];
}
