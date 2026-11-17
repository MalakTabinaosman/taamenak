import 'package:shared_preferences/shared_preferences.dart';
import 'package:taamenak/data/models/user_model.dart';

// ========================================================
// إدارة جلسة المريض المسجل (UserSession Manager)
// وظيفتها حفظ بيانات المريض الحالي ومشاركتها مع كل شاشات التطبيق
// ========================================================
class UserSession {
  // متغير داخلي لحفظ بيانات المريض في الذاكرة السريعة (RAM)
  static UserModel? _currentUser;

  /// الحصول على بيانات المريض الحالي المسجل (أو بيانات افتراضية إذا لم يسجل بعد)
  static UserModel get currentUser =>
      _currentUser ??
      const UserModel(
        id: '',
        name: 'المريض',
        email: '',
        phone: '',
        nationalId: '',
        insuranceId: '',
      );

  /// تحديث المريض الحالي في الذاكرة
  static set currentUser(UserModel user) {
    _currentUser = user;
  }

  /// حفظ بيانات المريض في الذاكرة المؤقتة وفي التخزين الدائم (SharedPreferences)
  static Future<void> saveUser({
    required String id,
    required String name,
    required String email,
    String phone = '',
    String nationalId = '',
    String insuranceId = '',
  }) async {
    // 1. التحديث في الذاكرة السريعة للتطبيق
    _currentUser = UserModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      nationalId: nationalId,
      insuranceId: insuranceId,
    );

    // 2. الحفظ في ذاكرة الهاتف الدائمة حتى لا تضيع البيانات عند قفل التطبيق
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', id);
      await prefs.setString('user_name', name);
      await prefs.setString('user_email', email);
      await prefs.setString('user_phone', phone);
      await prefs.setString('user_national_id', nationalId);
      await prefs.setString('user_insurance_id', insuranceId);
    } catch (_) {}
  }

  /// استرجاع بيانات المريض المحفوظة تلقائياً عند تشغيل التطبيق في main.dart
  static Future<void> loadUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final name = prefs.getString('user_name');
      if (name != null && name.isNotEmpty) {
        _currentUser = UserModel(
          id: prefs.getString('user_id') ?? '',
          name: name,
          email: prefs.getString('user_email') ?? '',
          phone: prefs.getString('user_phone') ?? '',
          nationalId: prefs.getString('user_national_id') ?? '',
          insuranceId: prefs.getString('user_insurance_id') ?? '',
        );
      }
    } catch (_) {}
  }

  /// مسح بيانات الجلسة بالكامل عند الضغط على "تسجيل الخروج"
  static Future<void> clear() async {
    _currentUser = null;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (_) {}
  }
}
