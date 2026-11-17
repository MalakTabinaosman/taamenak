import 'package:flutter/material.dart';

/// ============================================================================
/// ودجت الترويسة المخصصة للشاشات (CustomHeader)
/// تُستخدم في أعلى الشاشات أو التبويبات لعرض العنوان الرئيسي، العنوان الفرعي،
/// زر الرجوع (اختياري)، وعنصر إضافي على الطرف الآخر مثل شارة أو زر إجراء.
/// ============================================================================
class CustomHeader extends StatelessWidget {
  /// العنوان الرئيسي للشاشة
  final String title;

  /// عنوان فرعي توضيحي أسفل العنوان الرئيسي
  final String? subtitle;

  /// عنصر على الطرف المقابل (مثل شارة أو أيقونة)
  final Widget? trailing;

  /// دالة الرجوع للخلف، عند تمريرها يظهر سهم الرجوع
  final VoidCallback? onBack;

  const CustomHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                // سهم الرجوع إذا كانت دالة onBack موجودة
                if (onBack != null) ...[
                  IconButton(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_forward_ios, size: 18),
                    color: cs.secondary,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 8),
                ],
                // عمود العنوان والعنوان الفرعي
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: tt.displayLarge?.copyWith(
                          fontSize: 22,
                          color: cs.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: tt.bodySmall?.copyWith(
                            color: cs.secondary.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          // العنصر الإضافي على اليمين/اليسار إن وجد
          ?trailing,
        ],
      ),
    );
  }
}

/// ============================================================================
/// ودجت الشارة الجانبية للترويسة (HeaderBadge)
/// شارة ملونة توضع في الترويسة لعرض عداد أو معلومة سريعة مع أيقونة وخلفية شفافة.
/// ============================================================================
class HeaderBadge extends StatelessWidget {
  /// النص المكتوب داخل الشارة
  final String label;

  /// الأيقونة التعبيرية بجانب النص
  final IconData? icon;

  /// اللون المخصص للشارة (افتراضياً لون الثيم الأساسي)
  final Color? color;

  /// دالة الضغط على الشارة في حال كانت تفاعلية
  final VoidCallback? onTap;

  const HeaderBadge({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final badgeColor = color ?? cs.primary;

    final badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: badgeColor.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: badgeColor),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: tt.labelMedium?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    // دعم إمكانية النقر في حال تمرير onTap
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: badge,
      );
    }

    return badge;
  }
}
