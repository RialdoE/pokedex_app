import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_app/validators/validators.dart';

void main() {
  group('Email Validator', () {
    test('returns error when email is empty', () {
      expect(Validators.email(''), 'Please enter your email.');
    });

    test('returns error when email is null', () {
      expect(Validators.email(null), 'Please enter your email.');
    });

    test('returns error when email is invalid', () {
      expect(Validators.email('notanemail'), 'Please enter a valid email.');
    });

    test('returns error when email has no domain', () {
      expect(Validators.email('test@'), 'Please enter a valid email.');
    });

    test('returns null when email is valid', () {
      expect(Validators.email('test@test.com'), null);
    });
  });

  group('Password Validator', () {
    test('returns error when password is empty', () {
      expect(Validators.password(''), 'Please enter your password.');
    });

    test('returns error when password is null', () {
      expect(Validators.password(null), 'Please enter your password.');
    });

    test('returns error when password is too short', () {
      expect(
        Validators.password('Ab1!'),
        'Password must be at least 8 characters, include an uppercase letter, a number and a special character.',
      );
    });

    test('returns error when password has no uppercase', () {
      expect(
        Validators.password('abcdef1!'),
        'Password must be at least 8 characters, include an uppercase letter, a number and a special character.',
      );
    });

    test('returns error when password has no number', () {
      expect(
        Validators.password('Abcdef!!'),
        'Password must be at least 8 characters, include an uppercase letter, a number and a special character.',
      );
    });

    test('returns error when password has no special character', () {
      expect(
        Validators.password('Abcdef12'),
        'Password must be at least 8 characters, include an uppercase letter, a number and a special character.',
      );
    });

    test('returns null when password is valid', () {
      expect(Validators.password('Abcdef1!'), null);
    });
  });

  group('Confirm Password Validator', () {
    test('returns error when confirm password is empty', () {
      expect(
        Validators.confirmPassword('', 'Abcdef1!'),
        'Please confirm your password.',
      );
    });

    test('returns error when confirm password do not match', () {
      expect(
        Validators.confirmPassword('Abcdef1!', 'Different1!'),
        'Passwords do not match.',
      );
    });

    test('returns null when passwords match', () {
      expect(
        Validators.confirmPassword('Abcdef1!', 'Abcdef1!'),
        null,
      );
    });
  });
}
