import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taamenak/core/utils/validators.dart';
import 'package:taamenak/core/widgets/custom_text_field.dart';
import 'package:taamenak/ui/admin/admin_dashboard_screen.dart';
import 'package:taamenak/ui/home/buttom_navigation_bar.dart';
import 'package:taamenak/ui/login/cubit/login_cubit.dart';
import 'package:taamenak/ui/login/cubit/login_state.dart';

/// ============================================================================
/// شاشة تسجيل الدخول (LoginScreen)
/// تتيح تسجيل الدخول لكل من:
/// 1. المرضى: باستخدام البريد، الهاتف، أو اسم المستخدم مع كلمة المرور (مع التحقق من حالة الموافقة approved).
/// 2. الموظفين والإدارة: يتم توجيههم مباشرة إلى لوحة تحكم الإدارة (Admin Dashboard).
/// تدعم إدارة الحالة بواسطة [LoginCubit]، والتحقق التلقائي من الحقول، وعرض الحوارات التنبيهية.
/// ============================================================================
class LoginScreen extends StatefulWidget {
  /// اسم المسار للتنقل
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// مفتاح النموذج للتحقق من صحة المدخلات
  final _formKey = GlobalKey<FormState>();

  /// متحكم حقل اسم المستخدم أو البريد أو الهاتف
  final TextEditingController _emailOrPhoneController = TextEditingController();

  /// متحكم حقل كلمة المرور
  final TextEditingController _passwordController = TextEditingController();

  /// حالة إخفاء/إظهار كلمة المرور
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// إرسال طلب تسجيل الدخول إلى LoginCubit بعد التحقق من صحة النموذج
  void _submitLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().login(
        emailOrPhone: _emailOrPhoneController.text,
        password: _passwordController.text,
      );
    }
  }

  /// عرض نافذة منبثقة تنبيهية في حال كان الحساب قيد المراجعة أو مرفوضاً
  void _showNoticeDialog(
    BuildContext context, {
    required String title,
    required String message,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (dialogCtx) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: const EdgeInsets.all(24),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // دائرة الأيقونة التنبيهية
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 36, color: color),
              ),
              const SizedBox(height: 16),
              // عنوان التنبيه
              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 10),
              // رسالة التوضيح
              Text(
                message,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.disabledColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              // زر الإغلاق
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(dialogCtx),
                  child: const Text(
                    'حسناً',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // توفير الـ LoginCubit للشاشة عبر BlocProvider
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: BlocConsumer<LoginCubit, LoginState>(
              // الاستماع لتغير الحالات للتنقل أو إظهار الرسائل
              listener: (context, state) {
                // في حالة نجاح تسجيل دخول مريض معتمد
                if (state is LoginPatientSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('أهلاً بك، ${state.name} 👋'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                } 
                // في حالة نجاح تسجيل دخول موظف أو مدير
                else if (state is LoginStaffSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'أهلاً بك يا ${state.name} (${state.role == 'admin' ? 'مدير النظام' : 'الموظف'}) 🛡️',
                      ),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                  Navigator.pushReplacementNamed(
                    context,
                    AdminDashboardScreen.routeName,
                  );
                } 
                // في حال كان حساب المريض لا يزال بانتظار مراجعة الإدارة
                else if (state is LoginPendingApproval) {
                  _showNoticeDialog(
                    context,
                    title: 'الحساب قيد المراجعة ⏳',
                    message: state.message,
                    icon: Icons.hourglass_top_rounded,
                    color: theme.colorScheme.primary,
                  );
                } 
                // في حال رفض حساب المريض
                else if (state is LoginRejected) {
                  _showNoticeDialog(
                    context,
                    title: 'تم رفض الحساب ❌',
                    message: state.message,
                    icon: Icons.cancel_outlined,
                    color: theme.colorScheme.error,
                  );
                } 
                // في حال وجود خطأ في البيانات أو الاتصال
                else if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: theme.colorScheme.error,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is LoginLoading;

                return Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 30),

                      // -------------------------------------------------------
                      // الترويسة الترحيبية
                      // -------------------------------------------------------
                      Center(
                        child: Column(
                          children: [
                            Text(
                              "أهلاً بك في تأمينك",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.disabledColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "تسجيل الدخول",
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 36),

                      // -------------------------------------------------------
                      // 1. حقل البريد الإلكتروني أو الهاتف أو اسم المستخدم
                      // -------------------------------------------------------
                      customTextField(
                        label: "البريد الإلكتروني أو الهاتف أو اسم المستخدم",
                        hint: "البريد أو الهاتف أو اسم المستخدم",
                        icon: Icons.person_outline,
                        controller: _emailOrPhoneController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "يرجى إدخال البريد الإلكتروني أو الهاتف أو اسم المستخدم";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // -------------------------------------------------------
                      // 2. حقل كلمة المرور مع زر الإظهار والإخفاء
                      // -------------------------------------------------------
                      customTextField(
                        label: "كلمة المرور",
                        hint: "الحد الأدنى 6 أحرف",
                        icon: Icons.lock_outline,
                        controller: _passwordController,
                        isPassword: true,
                        obscureText: _obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: theme.disabledColor,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validator: AppValidators.validatePassword,
                      ),

                      const SizedBox(height: 32),

                      // -------------------------------------------------------
                      // زر تسجيل الدخول (مع مؤشر تحميل أثناء المعالجة)
                      // -------------------------------------------------------
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          onPressed: isLoading
                              ? null
                              : () => _submitLogin(context),
                          child: isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  "دخول للحساب",
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      // -------------------------------------------------------
                      // رابط الانتقال لشاشة إنشاء حساب مريض جديد
                      // -------------------------------------------------------
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "ليس لديك حساب ؟",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.disabledColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/signup',
                                );
                              },
                              child: Text(
                                "سجل الان ",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
