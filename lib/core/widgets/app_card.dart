import 'package:flutter/material.dart';

/// ============================================================================
/// ودجت البطاقة الموحدة (AppCard)
/// حاوية عامة بنصف قطر دائري وظلال خفيفة، تُستخدم لكروت الأطباء، المواعيد،
/// والروشتات لتحقيق تناسق بصري كامل في أرجاء التطبيق.
/// تدعم خاصية النقر (onTap) مع تأثير لمس مائي (InkWell).
/// ============================================================================
class AppCard extends StatelessWidget {
  /// المحتوى الداخلي للبطاقة
  final Widget child;

  /// الحشو الداخلي
  final EdgeInsetsGeometry padding;

  /// الهامش الخارجي للبطاقة
  final EdgeInsetsGeometry margin;

  /// دالة الاستجابة عند الضغط على البطاقة (اختيارية)
  final VoidCallback? onTap;

  /// لون خلفية البطاقة (افتراضياً يأخذ لون السطح من الثيم)
  final Color? backgroundColor;

  /// نصف قطر استدارة الحواف
  final double borderRadius;

  /// حد الإطار الخارجي المخصص
  final Border? border;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.margin = const EdgeInsets.only(bottom: 12),
    this.onTap,
    this.backgroundColor,
    this.borderRadius = 16,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // تصميم البطاقة الأساسي بالحواف والظلال
    Widget card = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? cs.surface,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border ??
            Border.all(
              color: cs.onSurface.withValues(alpha: 0.08),
              width: 1,
            ),
        boxShadow: [
          BoxShadow(
            color: cs.secondary.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );

    // إذا تم تمرير دالة ضغط، يتم تغليف البطاقة بـ InkWell
    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: card,
      );
    }

    return card;
  }
}
