import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taamenak/data/services/auth_service.dart';
import 'package:taamenak/ui/login/cubit/login_state.dart';

// ========================================================
// إدارة حالة تسجيل الدخول (LoginCubit)
// المسؤول عن فحص هوية المستخدم وتوجيهه حسب صلاحيته (أدمن، مريض، معلق)
// ========================================================
class LoginCubit extends Cubit<LoginState> {
  final AuthService _authService;

  LoginCubit({AuthService? authService})
      : _authService = authService ?? AuthService(),
        super(const LoginInitial());

  /// دالة تسجيل الدخول
  Future<void> login({
    required String emailOrPhone,
    required String password,
  }) async {
    // 1. إطلاق حالة التحميل
    emit(const LoginLoading());

    try {
      // 2. التحقق من صحة البيانات وجلب دور المستخدم وحالته
      final result = await _authService.signIn(
        emailOrPhoneOrUsername: emailOrPhone,
        password: password,
      );

      final role = (result['role'] ?? 'patient').toString().toLowerCase();
      final status = (result['status'] ?? 'pending').toString().toLowerCase();
      final name = result['name']?.toString() ?? '';

      // 3. السيناريو الأول: إذا كان المستخدم موظفاً أو مديراً للنظام
      if (role == 'admin' || role == 'employee' || role == 'doctor') {
        emit(LoginStaffSuccess(name: name, role: role));
        return;
      }

      // 4. السيناريو الثاني: إذا كان المستخدم مريضاً:
      if (status == 'approved') {
        // أ) الحساب معتمد ومقبول: يدخل مباشرة للتطبيق
        emit(LoginPatientSuccess(name));
      } else if (status == 'rejected') {
        // ب) الحساب مرفوض من الإدارة
        await _authService.signOut();
        emit(const LoginRejected(
          'تم رفض طلب حسابك من قِبل الإدارة. يرجى مراجعة خدمة العملاء.',
        ));
      } else {
        // ج) الحساب لا زال قيد الانتظار (Pending)
        await _authService.signOut();
        emit(const LoginPendingApproval(
          'حسابك قيد المراجعة والتدقيق حالياً من قِبل إدارة التأمين. ستتمكن من تسجيل الدخول فور اعتماد الحساب.',
        ));
      }
    } on AuthException catch (e) {
      // معالجة أخطاء المصادقة
      emit(LoginError(_mapAuthError(e.message)));
    } catch (e) {
      // معالجة أي خطأ عام
      emit(LoginError('حدث خطأ أثناء تسجيل الدخول: ${e.toString()}'));
    }
  }

  /// ترجمة رسائل الخطأ من الإنجليزية للعربية
  String _mapAuthError(String message) {
    if (message.contains('Invalid login credentials')) {
      return 'بيانات الدخول غير صحيحة، يرجى التأكد من البريد وكلمة المرور.';
    } else if (message.contains('Email not confirmed')) {
      return 'يرجى تأكيد البريد الإلكتروني أولاً عبر الرابط المرسل لإيميلك، أو تعطيل تأكيد البريد في Supabase.';
    }
    return message;
  }
}
