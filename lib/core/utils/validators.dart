

class AppValidators {
  // التحقق من الاسم بالكامل
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال الاسم بالكامل";
    }
    if (value.trim().length < 3) {
      return "يجب أن يتكون الاسم من 3 أحرف على الأقل";
    }
    return null;
  }

  // التحقق من رقم عضوية التأمين
  static String? validateInsuranceId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال رقم عضوية التأمين";
    }
    if (value.trim().length < 4) {
      return "رقم العضوية غير صحيح";
    }
    return null;
  }

  // التحقق من رقم الهاتف أو البريد الإلكتروني
  static String? validatePhoneOrEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال رقم الهاتف أو البريد الإلكتروني";
    }
    final input = value.trim();
    final isEmail = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(input);
    final isPhone = RegExp(r'^[0-9]{9,15}$').hasMatch(input);

    if (!isEmail && !isPhone) {
      return "يرجى إدخال بريد إلكتروني صحيح أو رقم هاتف صحيح";
    }
    return null;
  }

  // التحقق من البريد الإلكتروني فقط (مفيد لشاشة تسجيل الدخول لاحقاً)
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال البريد الإلكتروني";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return "صيغة البريد الإلكتروني غير صحيحة";
    }
    return null;
  }

  // التحقق من رقم الهاتف فقط
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "يرجى إدخال رقم الهاتف";
    }
    final phoneRegex = RegExp(r'^[0-9]{9,15}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return "رقم الهاتف غير صحيح";
    }
    return null;
  }

  // التحقق من كلمة المرور
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "يرجى إدخال كلمة المرور";
    }
    if (value.length < 6) {
      return "كلمة المرور يجب ألا تقل عن 6 أحرف";
    }
    return null;
  }

  // التحقق من تطابق كلمة المرور (Confirm Password)
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "يرجى تأكيد كلمة المرور";
    }
    if (value != password) {
      return "كلمتا المرور غير متطابقتين";
    }
    return null;
  }

  static String? validateNationalId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الرقم القومي مطلوب';
    }

    final trimmedValue = value.trim();

    // التأكد من أن الإدخال يحتوي على أرقام فقط
    final isNumeric = RegExp(r'^\d+$').hasMatch(trimmedValue);
    if (!isNumeric) {
      return 'الرقم القومي يجب أن يتكون من أرقام فقط';
    }

    // التأكد من أن الطول المطابق هو 14 رقماً
    if (trimmedValue.length != 14) {
      return 'الرقم القومي يجب أن يكون 14 رقماًق'; // أو "14 رقماً"
    }

    return null;
  }

}