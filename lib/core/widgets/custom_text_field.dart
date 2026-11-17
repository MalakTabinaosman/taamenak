import 'package:flutter/material.dart';

/// ============================================================================
/// ودجت حقل الإدخال المخصص الموحد (CustomTextField)
/// حقل نصي مزود بتسمية علوية (Label)، أيقونة بادئة (Prefix Icon)،
/// وأيقونة لاحقة (Suffix Icon مثل زر إظهار/إخفاء كلمة المرور)،
/// مع دعم التحقق التلقائي (Validator) ونمط الخطوط المأخوذ مباشرة من الثيم.
/// ============================================================================
class CustomTextField extends StatelessWidget {
  /// تسمية الحقل التوضيحية التي تظهر أعلى الحقل
  final String label;

  /// النص التلميحي داخل الحقل عند خلوه
  final String hint;

  /// الأيقونة البادئة داخل الحقل
  final IconData icon;

  /// وحدة التحكم بالنص (Controller)
  final TextEditingController controller;

  /// دالة التحقق من صحة القيمة المدخلة
  final String? Function(String?) validator;

  /// نوع لوحة المفاتيح المناسبة (نص، رقم، هاتف، بريد إلكتروني)
  final TextInputType keyboardType;

  /// هل الحقل مخصص لكلمة مرور
  final bool isPassword;

  /// هل النص مخفي بنجوم أم ظاهر
  final bool obscureText;

  /// ودجت في نهاية الحقل (مثل زر إظهار كلمة المرور)
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // عنوان الحقل المكتوب أعلاه
        Text(
          label,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 6),

        // حقل إدخال النص مع التنسيق وثيم التطبيق
        TextFormField(
          controller: controller,
          obscureText: isPassword ? obscureText : false,
          keyboardType: keyboardType,
          validator: validator,
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

// تعريف بديل متوافق مع الأسماء القديمة المستخدمة في بعض الشاشات
// ignore: camel_case_types
typedef customTextField = CustomTextField;
