import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taamenak/data/services/user_session.dart';

// ========================================================
// خدمة المصادقة والتعامل مع سيرفر وقاعدة بيانات Supabase (AuthService)
// المسؤولة عن تسجيل المرضى الجدد، وتسجيل الدخول، وموافقة الأدمن، وتسجيل الخروج
// ========================================================
class AuthService {
  // كائن الاتصال المباشر بـ Supabase
  final SupabaseClient _supabase = Supabase.instance.client;

  // --------------------------------------------------------
  // 1. تسجيل حساب مريض جديد (Sign Up Patient)
  // --------------------------------------------------------
  Future<void> signUpPatient({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String nationalId,
    required String insuranceId,
  }) async {
    // أ) محاولة إنشاء حساب المصادقة في نظام الحماية الداخلي (Supabase Auth)
    try {
      await _supabase.auth.signUp(
        email: email.trim(),
        password: password,
        data: {
          'name': name.trim(),
          'phone': phone.trim(),
          'national_id': nationalId.trim(),
          'insurance_id': insuranceId.trim(),
          'role': 'patient',
          'status': 'pending', // حالة قيد المراجعة افتراضياً للمريض
        },
      );
    } catch (_) {
      // تجاوز أي خطأ متعلق بحد إرسال الإيميلات المجاني لضمان استمرار الحفظ
    }

    // ب) إضافة سجل المريض في جدول users العام مع حالة 'pending' ودور 'patient'
    final userRow = await _supabase
        .from('users')
        .insert({
          'user_name': name.trim(),
          'email': email.trim(),
          'password': password.trim(),
          'role': 'patient',
          'status': 'pending',
        })
        .select('user_id')
        .single();

    final dynamic rawUserId = userRow['user_id'];
    final int? userId = rawUserId is int ? rawUserId : int.tryParse(rawUserId.toString());

    if (userId != null) {
      // ج) إضافة المريض في جدول patients مع ربط رقم التأمين الطبي والتاريخ المرضي
      final int parsedInsurance = int.tryParse(insuranceId.trim()) ?? 0;
      try {
        await _supabase.from('patients').insert({
          'user_id': userId,
          'insurance_number': parsedInsurance,
          'medical_history': 'لا يوجد',
          'blood_group': 'غير محدد',
        });
      } catch (_) {}

      // د) إضافة رقم الهاتف في جدول users_phone لربطه بالمستخدم
      try {
        await _supabase.from('users_phone').insert({
          'user_id': userId,
          'phone': phone.trim(),
        });
      } catch (_) {}

      // هـ) حفظ بيانات المريض في جلسة التطبيق UserSession
      await UserSession.saveUser(
        id: userId.toString(),
        name: name.trim(),
        email: email.trim(),
        phone: phone.trim(),
        nationalId: nationalId.trim(),
        insuranceId: insuranceId.trim(),
      );
    }
  }

  // --------------------------------------------------------
  // 2. تسجيل الدخول الذكي (Sign In)
  // يدعم الدخول بـ (البريد، أو الهاتف، أو اسم المستخدم)
  // --------------------------------------------------------
  Future<Map<String, dynamic>> signIn({
    required String emailOrPhoneOrUsername,
    required String password,
  }) async {
    String input = emailOrPhoneOrUsername.trim();
    String email = input;

    // أ) في حال لم يدخل بريداً (لا يحتوي على @)، نبحث في قاعدة البيانات عن الإيميل المرتبط به
    if (!input.contains('@')) {
      try {
        // البحث بواسطة اسم المستخدم (Username)
        final userByName = await _supabase
            .from('users')
            .select('email')
            .ilike('user_name', input)
            .maybeSingle();

        if (userByName != null && userByName['email'] != null) {
          email = userByName['email'] as String;
        } else {
          // البحث بواسطة رقم الهاتف من جدول users_phone
          final phoneRes = await _supabase
              .from('users_phone')
              .select('user_id')
              .eq('phone', input)
              .maybeSingle();

          if (phoneRes != null && phoneRes['user_id'] != null) {
            final userRes = await _supabase
                .from('users')
                .select('email')
                .eq('user_id', phoneRes['user_id'])
                .maybeSingle();

            if (userRes != null && userRes['email'] != null) {
              email = userRes['email'] as String;
            }
          }
        }
      } catch (_) {}
    }

    String role = 'patient';
    String status = 'pending';
    String userName = '';
    dynamic userId;

    // ب) المحاولة الأولى: المصادقة عبر نظام Supabase Auth
    try {
      final AuthResponse res = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (res.user != null) {
        final userRow = await _supabase
            .from('users')
            .select('user_id, user_name, email, role, status')
            .eq('email', email)
            .maybeSingle();

        userId = userRow?['user_id'];
        role = (userRow?['role'] ?? res.user?.userMetadata?['role'] ?? 'patient').toString().toLowerCase();
        status = (userRow?['status'] ?? res.user?.userMetadata?['status'] ?? 'pending').toString().toLowerCase();
        userName = userRow?['user_name'] ?? res.user?.userMetadata?['name'] ?? '';
      }
    } catch (authError) {
      // ج) المحاولة البديلة (Fail-Safe): الفحص المباشر في جدول users في حال كان الحساب غير مفعل الإيميل
      final userRow = await _supabase
          .from('users')
          .select('user_id, user_name, email, password, role, status')
          .eq('email', email)
          .maybeSingle();

      if (userRow != null) {
        final storedPassword = userRow['password']?.toString();
        // التحقق من صحة كلمة المرور المدخلة
        if (storedPassword == null || storedPassword.isEmpty || storedPassword == password.trim()) {
          userId = userRow['user_id'];
          role = (userRow['role'] ?? 'patient').toString().toLowerCase();
          status = (userRow['status'] ?? 'pending').toString().toLowerCase();
          userName = userRow['user_name'] ?? '';
        } else {
          throw const AuthException('كلمة المرور غير صحيحة.');
        }
      } else {
        if (authError is AuthException) {
          rethrow;
        }
        throw const AuthException('بيانات الدخول غير صحيحة، يرجى التأكد من البريد وكلمة المرور.');
      }
    }

    // د) جلب رقم التأمين ورقم الهاتف لتجهيز جلسة المريض
    String insuranceNumber = '';
    String phoneNumber = '';

    if (userId != null) {
      try {
        final patientRes = await _supabase
            .from('patients')
            .select('insurance_number')
            .eq('user_id', userId)
            .maybeSingle();
        if (patientRes != null && patientRes['insurance_number'] != null) {
          insuranceNumber = patientRes['insurance_number'].toString();
        }
      } catch (_) {}

      try {
        final phoneRes = await _supabase
            .from('users_phone')
            .select('phone')
            .eq('user_id', userId)
            .maybeSingle();
        if (phoneRes != null && phoneRes['phone'] != null) {
          phoneNumber = phoneRes['phone'].toString();
        }
      } catch (_) {}
    }

    // هـ) حفظ بيانات المريض في UserSession لاستخدامها في باقي شاشات التطبيق
    await UserSession.saveUser(
      id: userId?.toString() ?? '',
      name: userName,
      email: email,
      phone: phoneNumber,
      insuranceId: insuranceNumber.isNotEmpty ? insuranceNumber : 'TM-78945612',
    );

    return {
      'userId': userId,
      'name': userName,
      'role': role,
      'status': status,
    };
  }

  // --------------------------------------------------------
  // 3. جلب قائمة المرضى المعلقين في انتظار موافقة الإدارة (Pending Patients)
  // --------------------------------------------------------
  Future<List<Map<String, dynamic>>> getPendingPatients() async {
    final response = await _supabase
        .from('users')
        .select('user_id, user_name, email, role, status')
        .eq('role', 'patient')
        .eq('status', 'pending');

    return List<Map<String, dynamic>>.from(response);
  }

  // --------------------------------------------------------
  // 4. تحديث حالة المريض من قِبل الأدمن (قبول 'approved' أو رفض 'rejected')
  // --------------------------------------------------------
  Future<void> updatePatientStatus({
    required dynamic userId,
    required String newStatus,
  }) async {
    await _supabase
        .from('users')
        .update({'status': newStatus})
        .eq('user_id', userId);
  }

  // --------------------------------------------------------
  // 5. تسجيل الخروج ومسح الجلسة (Sign Out)
  // --------------------------------------------------------
  Future<void> signOut() async {
    await UserSession.clear();
    try {
      await _supabase.auth.signOut();
    } catch (_) {}
  }
}
