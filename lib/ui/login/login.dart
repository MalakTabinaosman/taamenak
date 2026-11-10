import 'package:flutter/material.dart';
import 'package:taamenak/core/utils/validators.dart';
import 'package:taamenak/core/widgets/custom_text_field.dart';
import 'package:taamenak/ui/home/buttom_navigation_bar.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30),

                // Header Section (العنوان الترحيبي)
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

                // 1. حقل البريد الإلكتروني أو الهاتف (مربوط بـ validatePhoneOrEmail)
                customTextField(
                  label: "البريد الإلكتروني أو الهاتف",
                  hint: "Terry42@yahoo.com",
                  icon: Icons.email_outlined,
                  controller: _emailOrPhoneController,
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.validatePhoneOrEmail,
                ),

                const SizedBox(height: 20),

                // 2. حقل كلمة المرور (مربوط بـ validatePassword)
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

                const SizedBox(height: 8),

                // رابط نسيت كلمة المرور
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      // TODO: الانتقال لشاشة استعادة كلمة المرور
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "نسيت كلمة المرور؟",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // زر دخول للحساب
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        HomeScreen.routeName,
                      );
                      if (_formKey.currentState!.validate()) {
                        // إذا كانت المدخلات صحيحة، قم بتنفيذ تسجيل الدخول هنا
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('جاري تسجيل الدخول...')),
                        );
                      }
                    },
                    child: Text(
                      "دخول للحساب",
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),
                /*
                // الفاصل (أو سجل باستخدام)
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: theme.disabledColor.withValues(alpha: 0.3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        "أو سجل باستخدام",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.disabledColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: theme.disabledColor.withValues(alpha: 0.3),
                      ),
                    ),
                  ],
                ), */

                const SizedBox(height: 28),

                // الانتقال لشاشة إنشاء حساب جديد
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ليس لديك حساب؟ ",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.disabledColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child: Text(
                          "سجل الآن",
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
          ),
        ),
      ),
    );
  }
}

// مكون فرعي لأزرار التواصل الاجتماعي
