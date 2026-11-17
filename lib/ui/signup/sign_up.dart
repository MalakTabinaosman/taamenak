import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taamenak/core/utils/validators.dart';
import 'package:taamenak/core/widgets/custom_text_field.dart';
import 'package:taamenak/ui/signup/cubit/signup_cubit.dart';
import 'package:taamenak/ui/signup/cubit/signup_state.dart';

/// ============================================================================
/// شاشة تسجيل حساب مريض جديد (SignupScreen)
/// تتيح للمريض إدخال بياناته الطبية والشخصية:
/// (الاسم الكامل، رقم عضوية التأمين، رقم الهاتف، البريد، الرقم القومي، كلمة المرور)
/// مع التحقق التلقائي الصارم من كل حقل عبر [AppValidators].
/// بعد التسجيل، يُحفظ الحساب بحالة 'pending' وتظهر نافذة تفيد بانتظار مراجعة الإدارة.
/// ============================================================================
class SignupScreen extends StatefulWidget {
  /// اسم route للتنقل
  static const String routeName = '/signup';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  /// مفتاح النموذج العام للتحقق من الحقول
  final _formKey = GlobalKey<FormState>();

  // ---------------------------------------------------------------------------
  // متحكمات حقول الإدخال (Controllers)
  // ---------------------------------------------------------------------------
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _insuranceIdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  /// حالة إظهار / إخفاء كلمة المرور
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _insuranceIdController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// دالة التحقق وإرسال بيانات التسجيل إلى SignupCubit
  void _submitSignup(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignupCubit>().registerPatient(
            name: _nameController.text,
            insuranceId: _insuranceIdController.text,
            phone: _phoneController.text,
            email: _emailController.text,
            nationalId: _nationalIdController.text,
            password: _passwordController.text,
          );
    }
  }

  /// نافذة حوارية تظهر للمريض عند إتمام التسجيل بنجاح توضح أن طلبه قيد مراجعة الإدارة
  void _showPendingDialog(BuildContext context, String message) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.all(24),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // أيقونة الساعة الرملية لبيان حالة الانتظار
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.hourglass_top_rounded,
                    size: 40,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 18),
                // العنوان
                Text(
                  "طلبك قيد المراجعة ⏳",
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 12),
                // رسالة الشرح
                Text(
                  "تم إنشاء حسابك بنجاح! سيقوم مسؤول النظام بمراجعة بيانات التأمين والرقم القومي والموافقة على حسابك قريباً لتتمكن من استخدام التطبيق.",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.disabledColor,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                // زر التوجه لتسجيل الدخول
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext); // إغلاق النافذة
                      Navigator.pushReplacementNamed(context, '/login'); // التوجه لصفحة تسجيل الدخول
                    },
                    child: const Text(
                      "الذهاب لتسجيل الدخول",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: BlocConsumer<SignupCubit, SignupState>(
                listener: (context, state) {
                  // إظهار رسالة خطأ عند فشل التسجيل
                  if (state is SignupError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.error,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        backgroundColor: theme.colorScheme.error,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  } 
                  // إظهار نافذة الانتظار عند نجاح إرسال الطلب
                  else if (state is SignupSuccess) {
                    _showPendingDialog(context, state.message);
                  }
                },
                builder: (context, state) {
                  final isLoading = state is SignupLoading;

                  return Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),

                        // -----------------------------------------------------
                        // العنوان والرسالة التوجيهية
                        // -----------------------------------------------------
                        Column(
                          children: [
                            Text(
                              "أهلاً بك في تأمينك",
                              style: theme.textTheme.displayMedium?.copyWith(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "أدخل بياناتك كما هي مسجلة لدى الجهة المختصة.",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.disabledColor,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        // -----------------------------------------------------
                        // 1. حقل الاسم بالكامل
                        // -----------------------------------------------------
                        customTextField(
                          label: "الاسم بالكامل",
                          hint: "أدخل البيانات",
                          icon: Icons.person_outline,
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          validator: AppValidators.validateName,
                        ),
                        const SizedBox(height: 16),

                        // -----------------------------------------------------
                        // 2. حقل رقم عضوية التأمين
                        // -----------------------------------------------------
                        customTextField(
                          label: "رقم عضوية التأمين",
                          hint: "أدخل الرقم المسجل",
                          icon: Icons.verified_user_outlined,
                          controller: _insuranceIdController,
                          keyboardType: TextInputType.text,
                          validator: AppValidators.validateInsuranceId,
                        ),
                        const SizedBox(height: 16),

                        // -----------------------------------------------------
                        // 3. حقل رقم الهاتف
                        // -----------------------------------------------------
                        customTextField(
                          label: "ادخل رقم الهاتف",
                          hint: "أدخل رقم الهاتف",
                          icon: Icons.phone_android_outlined,
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          validator: AppValidators.validatePhone,
                        ),
                        const SizedBox(height: 16),

                        // -----------------------------------------------------
                        // 4. حقل البريد الإلكتروني
                        // -----------------------------------------------------
                        customTextField(
                          label: "ادخل البريد الالكتروني",
                          hint: "أدخل البريد الإلكتروني",
                          icon: Icons.email_outlined,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidators.validateEmail,
                        ),
                        const SizedBox(height: 16),

                        // -----------------------------------------------------
                        // 5. حقل الرقم القومي (14 رقماً)
                        // -----------------------------------------------------
                        customTextField(
                          label: "ادخل الرقم القومي",
                          hint: "أدخل الرقم القومي",
                          icon: Icons.badge_outlined,
                          controller: _nationalIdController,
                          keyboardType: TextInputType.number,
                          validator: AppValidators.validateNationalId,
                        ),
                        const SizedBox(height: 16),

                        // -----------------------------------------------------
                        // 6. حقل كلمة المرور (مع خيار إظهار وإخفاء النص)
                        // -----------------------------------------------------
                        customTextField(
                          label: "كلمة المرور",
                          hint: "••••••••",
                          icon: Icons.lock_outline,
                          controller: _passwordController,
                          isPassword: true,
                          obscureText: _obscurePassword,
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
                      const SizedBox(height: 24),

                      // -------------------------------------------------------
                      // زر إنشاء الحساب
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
                              : () => _submitSignup(context),
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
                                  "إنشاء الحساب",
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // -------------------------------------------------------
                      // رابط الانتقال لتسجيل الدخول إذا كان لديه حساب بالفعل
                      // -------------------------------------------------------
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "لديك حساب بالفعل؟ ",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.disabledColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              },
                              child: Text(
                                "تسجيل الدخول",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // -------------------------------------------------------
                      // إشعار شروط الاستخدام وسياسة الخصوصية
                      // -------------------------------------------------------
                      Center(
                        child: Text(
                          "بالدخول، أنت توافق على شروط الاستخدام وسياسة الخصوصية والموافقة على معالجة البيانات الصحية.",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.disabledColor,
                            fontSize: 11,
                          ),
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
    ),
  );
}
}
