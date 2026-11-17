// ========================================================
// حالات شاشة تسجيل الدخول (LoginState)
// تدير وتتحكم في سيناريوهات الدخول المختلفة (مريض، موظف، معلق، مرفوض)
// ========================================================
abstract class LoginState {
  const LoginState();
}

/// 1. الحالة الافتراضية
class LoginInitial extends LoginState {
  const LoginInitial();
}

/// 2. حالة جاري التحقق وتسجيل الدخول
class LoginLoading extends LoginState {
  const LoginLoading();
}

/// 3. تسجيل دخول مريض معتمد وموافق عليه (ينتقل للصفحة الرئيسية مباشرة)
class LoginPatientSuccess extends LoginState {
  final String name;
  const LoginPatientSuccess(this.name);
}

/// 4. تسجيل دخول موظف أو أدمن (ينتقل للوحة تحكم الإدارة والموظفين)
class LoginStaffSuccess extends LoginState {
  final String name;
  final String role;
  const LoginStaffSuccess({required this.name, required this.role});
}

/// 5. محاولة دخول مريض وحسابه لا يزال قيد المراجعة (تظهر نافذة التنبيه)
class LoginPendingApproval extends LoginState {
  final String message;
  const LoginPendingApproval(this.message);
}

/// 6. محاولة دخول مريض تم رفض حسابه من قِبل الإدارة
class LoginRejected extends LoginState {
  final String message;
  const LoginRejected(this.message);
}

/// 7. فشل تسجيل الدخول أو خطأ في كلمة المرور/البريد
class LoginError extends LoginState {
  final String error;
  const LoginError(this.error);
}
