import 'package:flutter/material.dart';

/// ============================================================================
/// ودجت عنصر قائمة الملف الشخصي (ProfileMenuItem)
/// خيار تفاعلي في قائمة الحساب (مثل البيانات الشخصية، المساعدة، تسجيل الخروج)
/// يتكون من أيقونة داخل مربع ملون، عنوان رئيسي، وصف فرعي، وسهم انتقال.
/// ============================================================================
class ProfileMenuItem extends StatelessWidget {
  /// الأيقونة التعبيرية للعنصر
  final IconData icon;

  /// عنوان العنصر
  final String title;

  /// وصف إضافي أسفل العنوان (اختياري)
  final String? subtitle;

  /// دالة الاستدعاء عند الضغط
  final VoidCallback onTap;

  /// لون الأيقونة المخصص (مثال: أحمر لزر تسجيل الخروج)
  final Color? iconColor;

  /// لون النص المخصص
  final Color? textColor;

  /// هل يتم عرض سهم الانتقال الجانبي
  final bool showChevron;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.iconColor,
    this.textColor,
    this.showChevron = true,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    final effectiveIconColor = iconColor ?? cs.primary;
    final effectiveTextColor = textColor ?? cs.secondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: cs.onSurface.withValues(alpha: 0.06),
          ),
        ),
        child: Row(
          children: [
            // حاوية الأيقونة بخلفية خفيفة
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: effectiveIconColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: effectiveIconColor),
            ),
            const SizedBox(width: 12),

            // عنوان ووصف العنصر
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: tt.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: effectiveTextColor,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: tt.bodySmall?.copyWith(
                        color: cs.secondary.withValues(alpha: 0.5),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // سهم التنقل
            if (showChevron)
              Icon(
                Icons.arrow_back_ios_new,
                size: 14,
                color: cs.secondary.withValues(alpha: 0.3),
              ),
          ],
        ),
      ),
    );
  }
}
