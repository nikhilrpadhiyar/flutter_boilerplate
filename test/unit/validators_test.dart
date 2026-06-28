import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_boilerplate/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('returns error for empty input', () {
      expect(Validators.email(''), isNotNull);
      expect(Validators.email(null), isNotNull);
    });

    test('returns error for invalid email', () {
      expect(Validators.email('notanemail'), isNotNull);
      expect(Validators.email('missing@'), isNotNull);
    });

    test('returns null for valid email', () {
      expect(Validators.email('user@example.com'), isNull);
    });
  });

  group('Validators.password', () {
    test('returns error for empty password', () {
      expect(Validators.password(''), isNotNull);
      expect(Validators.password(null), isNotNull);
    });

    test('returns error for password shorter than 8 chars', () {
      expect(Validators.password('abc'), isNotNull);
    });

    test('returns null for valid password', () {
      expect(Validators.password('securePass1'), isNull);
    });
  });

  group('Validators.confirmPassword', () {
    test('returns error when passwords do not match', () {
      expect(Validators.confirmPassword('abc', 'xyz'), isNotNull);
    });

    test('returns null when passwords match', () {
      expect(Validators.confirmPassword('same', 'same'), isNull);
    });
  });

  group('Validators.phone', () {
    test('returns error for empty phone', () {
      expect(Validators.phone(''), isNotNull);
    });

    test('returns error for invalid phone', () {
      expect(Validators.phone('abc'), isNotNull);
    });

    test('returns null for valid phone', () {
      expect(Validators.phone('+919876543210'), isNull);
    });
  });
}
