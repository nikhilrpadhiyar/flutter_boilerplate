import 'package:flutter_boilerplate/features/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final Map<String, String?> testJson = <String, String?>{
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
      final UserModel model = UserModel.fromJson(testJson);
      expect(model.id, 'user-123');
      expect(model.email, 'test@example.com');
      expect(model.name, 'Test User');
      expect(model.accessToken, 'tok_abc');
      expect(model.refreshToken, 'ref_xyz');
    });

    test('toJson serialises without token fields', () {
      final UserModel model = UserModel.fromJson(testJson);
      final Map<String, dynamic> json = model.toJson();
      expect(json['id'], 'user-123');
      expect(json.containsKey('access_token'), isFalse);
    });

    test('copyWith updates only specified fields', () {
      final UserModel model = UserModel.fromJson(testJson);
      final UserModel updated = model.copyWith(name: 'Updated');
      expect(updated.name, 'Updated');
      expect(updated.email, model.email);
    });
  });
}
