import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/features/auth/data/models/user_model.dart';

void main() {
  final testJson = {
    'id': 'user-123',
    'email': 'test@example.com',
    'name': 'Test User',
    'avatar_url': null,
    'phone_number': null,
    'created_at': '2024-01-01T00:00:00.000Z',
    'access_token': 'tok_abc',
    'refresh_token': 'ref_xyz',
  };

  group('UserModel', () {
    test('fromJson parses all fields correctly', () {
      final model = UserModel.fromJson(testJson);
      expect(model.id, 'user-123');
      expect(model.email, 'test@example.com');
      expect(model.name, 'Test User');
      expect(model.accessToken, 'tok_abc');
      expect(model.refreshToken, 'ref_xyz');
    });

    test('toJson serialises without token fields', () {
      final model = UserModel.fromJson(testJson);
      final json = model.toJson();
      expect(json['id'], 'user-123');
      expect(json.containsKey('access_token'), isFalse);
    });

    test('copyWith updates only specified fields', () {
      final model = UserModel.fromJson(testJson);
      final updated = model.copyWith(name: 'Updated');
      expect(updated.name, 'Updated');
      expect(updated.email, model.email);
    });
  });
}
