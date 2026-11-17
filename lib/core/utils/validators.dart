// ========================================================
// دوال التحقق من صحة المدخلات (AppValidators)
// للتأكد من صحة البيانات قبل إرسالها للسيرفر وتنبيه المستخدم بالأخطاء
// ========================================================
class AppValidators {
  /// 1. التحقق من الاسم بالكامل (يجب ألا يقل عن 3 أحرف وألا يكون فارغاً)
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال الاسم بالكامل";
    }
    if (value.trim().length < 3) {
      return "يجب أن يتكون الاسم من 3 أحرف على الأقل";
    }
    return null;
  }

  /// 2. التحقق من رقم عضوية التأمين الصحي (لا يقل عن 4 أرقام)
  static String? validateInsuranceId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال رقم عضوية التأمين";
    }
    if (value.trim().length < 4) {
      return "رقم العضوية يجب ألا يقل عن 4 أرقام";
    }
    return null;
  }

  /// 3. التحقق من رقم الهاتف (أرقام مصرية مكونة من 11 رقماً تبدأ بـ 01 أو أرقام دولية)
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال رقم الهاتف";
    }
    final phone = value.trim();
    final phoneRegex = RegExp(r'^(01[0125][0-9]{8}|[0-9]{9,15})$');
    if (!phoneRegex.hasMatch(phone)) {
      return "يرجى إدخال رقم هاتف صحيح (مثال: 01012345678)";
    }
    return null;
  }

  /// 4. التحقق من البريد الإلكتروني (صيغة الإيميل القياسية: name@domain.com)
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال البريد الإلكتروني";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "صيغة البريد الإلكتروني غير صحيحة (مثال: name@domain.com)";
    }
    return null;
  }

  /// 5. التحقق من رقم الهاتف أو البريد الإلكتروني (مفيد لشاشة تسجيل الدخول)
  static String? validatePhoneOrEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال رقم الهاتف أو البريد الإلكتروني";
    }
    final input = value.trim();
    final isEmail = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input);
    final isPhone = RegExp(r'^(01[0125][0-9]{8}|[0-9]{9,15})$').hasMatch(input);

    if (!isEmail && !isPhone) {
      return "يرجى إدخال بريد إلكتروني صحيح أو رقم هاتف صحيح";
    }
    return null;
  }

  /// 6. التحقق من كلمة المرور (يجب ألا تقل عن 6 أحرف)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "يرجى إدخال كلمة المرور";
    }
    if (value.length < 6) {
      return "كلمة المرور يجب ألا تقل عن 6 أحرف";
    }
    return null;
  }

  /// 7. التحقق من تطابق كلمتي المرور (Confirm Password)
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "يرجى تأكيد كلمة المرور";
    }
    if (value != password) {
      return "كلمتا المرور غير متطابقتين";
    }
    return null;
  }

  /// 8. التحقق من الرقم القومي (يجب أن يكون 14 رقماً بالضبط وأرقاماً فقط)
  static String? validateNationalId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرقم القومي مطلوب';
    }

    final trimmedValue = value.trim();

    // التأكد من أن الإدخال أرقام فقط
    final isNumeric = RegExp(r'^\d+$').hasMatch(trimmedValue);
    if (!isNumeric) {
      return 'الرقم القومي يجب أن يتكون من أرقام فقط';
    }

    // التأكد من أن الطول 14 رقماً بالضبط
    if (trimmedValue.length != 14) {
      return 'الرقم القومي يجب أن يتكون من 14 رقماً بالضبط';
    }

    return null;
  }
}
