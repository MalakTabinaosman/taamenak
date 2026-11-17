import 'package:flutter_test/flutter_test.dart';
import 'package:taamenak/core/utils/validators.dart';

void main() {
  group('اختبارات التحقق AppValidators Tests', () {
    test('فحص الاسم', () {
      expect(AppValidators.validateName(''), contains('إدخال الاسم'));
      expect(AppValidators.validateName('أ'), contains('3 أحرف'));
      expect(AppValidators.validateName('أحمد محمد علي'), isNull);
    });

    test('فحص رقم الهاتف المصري', () {
      expect(AppValidators.validatePhone('12345'), contains('رقم هاتف صحيح'));
      expect(AppValidators.validatePhone('01012345678'), isNull);
      expect(AppValidators.validatePhone('01112345678'), isNull);
    });

    test('فحص البريد الإلكتروني', () {
      expect(AppValidators.validateEmail('invalid-email'), contains('صحيحة'));
      expect(AppValidators.validateEmail('test@gmail.com'), isNull);
    });

    test('فحص الرقم القومي (14 رقم)', () {
      expect(AppValidators.validateNationalId('123'), contains('14'));
      expect(AppValidators.validateNationalId('29901011234567'), isNull);
    });

    test('فحص كلمة المرور', () {
      expect(AppValidators.validatePassword('123'), contains('6'));
      expect(AppValidators.validatePassword('123456'), isNull);
    });
  });
}
