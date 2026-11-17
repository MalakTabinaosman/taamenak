import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taamenak/data/services/auth_service.dart';
import 'package:taamenak/ui/signup/cubit/signup_state.dart';

// ========================================================
// إدارة حالة شاشة إنشاء حساب جديد (SignupCubit)
// المسؤول عن استقبال بيانات تسجيل المريض وإرسالها لـ AuthService
// ========================================================
class SignupCubit extends Cubit<SignupState> {
  final AuthService _authService;

  SignupCubit({AuthService? authService})
      : _authService = authService ?? AuthService(),
        super(const SignupInitial());

  /// تنفيذ عملية تسجيل المريض في Supabase
  Future<void> registerPatient({
    required String name,
    required String insuranceId,
    required String phone,
    required String email,
    required String nationalId,
    required String password,
  }) async {
    // 1. إطلاق حالة التحميل لإظهار مؤشر الانتظار
    emit(const SignupLoading());

    try {
      // 2. إرسال البيانات لخدمة المصادقة وحفظها بحالة 'pending'
      await _authService.signUpPatient(
        email: email,
        password: password,
        name: name,
        phone: phone,
        nationalId: nationalId,
        insuranceId: insuranceId,
      );

      // 3. إطلاق حالة النجاح عند اكتمال الحفظ بنجاح
      emit(const SignupSuccess(
        'تم تسجيل الحساب بنجاح! طلبك الآن قيد مراجعة الإدارة وسنوافيك عند التفعيل.',
      ));
    } on AuthException catch (e) {
      // 4. معالجة أخطاء المصادقة الخاصة بسيرفر Supabase
      emit(SignupError(_mapAuthError(e.message)));
    } catch (e) {
      // 5. معالجة أي أخطاء أخرى غير متوقعة
      emit(SignupError('حدث خطأ أثناء التسجيل: ${e.toString()}'));
    }
  }

  /// ترجمة رسائل الخطأ من الإنجليزية إلى العربية ليفهمها المستخدم
  String _mapAuthError(String message) {
    if (message.contains('User already registered')) {
      return 'هذا البريد الإلكتروني مسجل بالفعل، يمكنك تسجيل الدخول مباشرة.';
    } else if (message.contains('Password should be')) {
      return 'كلمة المرور ضعيفة، يجب أن تحتوي على 6 أحرف على الأقل.';
    } else if (message.contains('Invalid email')) {
      return 'صيغة البريد الإلكتروني غير صحيحة.';
    }
    return message;
  }
}
