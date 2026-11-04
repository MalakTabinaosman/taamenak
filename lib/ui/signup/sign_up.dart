import 'package:flutter/material.dart';
import 'package:taamenak/core/utils/validators.dart';
import 'package:taamenak/core/widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';

  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers لإدارة النصوص المدخلة
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _insuranceIdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // حالة إظهار / إخفاء كلمة المرور
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

  // دالة تنفيذ التسجيل
  void _submitSignup() {
    if (_formKey.currentState!.validate()) {
      // TODO: سيتم ربط هذه الدالة بـ Supabase لاحقاً
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم التحقق من صحة البيانات بنجاح!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),

                  // العنوان الترحيبي والنص الفرعي
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

                  // 1. حقل الاسم بالكامل
                  customTextField(
                    label: "الاسم بالكامل",
                    hint: "أدخل البيانات",
                    icon: Icons.person_outline,
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    validator: AppValidators.validateName,
                  ),
                  const SizedBox(height: 16),

                  // 2. حقل رقم عضوية التأمين
                  customTextField(
                    label: "رقم عضوية التأمين",
                    hint: "أدخل الرقم المسجل",
                    icon: Icons.verified_user_outlined,
                    controller: _insuranceIdController,
                    keyboardType: TextInputType.text,
                    validator: AppValidators.validateInsuranceId,
                  ),
                  const SizedBox(height: 16),

                  // 3. حقل رقم الهاتف
                  customTextField(
                    label: "ادخل رقم الهاتف",
                    hint: "أدخل رقم الهاتف",
                    icon: Icons.phone_android_outlined,
                    controller: _phoneController,
                    keyboardType:
                        TextInputType.phone, // تصحيح نوع لوحة المفاتيح
                    validator: AppValidators.validatePhoneOrEmail,
                  ),
                  const SizedBox(height: 16),

                  // 4. حقل البريد الإلكتروني
                  customTextField(
                    label: "ادخل البريد الالكتروني",
                    hint: "أدخل البريد الإلكتروني",
                    icon: Icons.email_outlined,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.validatePhoneOrEmail,
                  ),
                  const SizedBox(height: 16),

                  // 5. حقل الرقم القومي
                  customTextField(
                    label: "ادخل الرقم القومي",
                    hint: "أدخل الرقم القومي",
                    icon: Icons.badge_outlined, // تصحيح الأيقونة لتناسب الهوية
                    controller: _nationalIdController,
                    keyboardType: TextInputType.number, // تصحيح لنوع الأرقام
                    validator: AppValidators.validateNationalId,
                  ),
                  const SizedBox(height: 16),

                  // 6. حقل كلمة المرور (مع إمكانية الإظهار والإخفاء)
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

                  // زر إنشاء الحساب
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
                      onPressed: _submitSignup, // ربط الزر بدالة التحقق
                      child: Text(
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

                  // رابط الانتقال لتسجيل الدخول
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
                            Navigator.pushReplacementNamed(context, '/login');
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

                  // نص الشروط والأحكام
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
            ),
          ),
        ),
      ),
    );
  }
}
