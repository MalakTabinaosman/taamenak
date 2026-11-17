// ========================================================
// حالات شاشة إنشاء حساب مريض جديد (SignupState)
// تُستخدم مع الـ Cubit للتحكم في حالة الزر ورسائل التحميل والنجاح والخطأ
// ========================================================
abstract class SignupState {
  const SignupState();
}

/// 1. الحالة الافتراضية عند فتح الشاشة
class SignupInitial extends SignupState {
  const SignupInitial();
}

/// 2. حالة جاري التحميل (تظهر علامة التحميل في زر التسجيل)
class SignupLoading extends SignupState {
  const SignupLoading();
}

/// 3. حالة نجاح إنشاء الحساب (ينبثق نافذة الانتظار ومراجعة الإدارة)
class SignupSuccess extends SignupState {
  final String message;
  const SignupSuccess(this.message);
}

/// 4. حالة حدوث خطأ أثناء التسجيل (يظهر شريط تنبيه أحمر بالسبب)
class SignupError extends SignupState {
  final String error;
  const SignupError(this.error);
}
