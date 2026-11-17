import 'package:flutter/material.dart';

/// ============================================================================
/// ودجت الحالة الفارغة (EmptyStateWidget)
/// تظهر عند عدم وجود بيانات لعرضها في القائمة (مثل: لا توجد مواعيد سابقة،
/// لا توجد روشتات، أو لا توجد نتائج بحث مطابقة)، مع زر إجراء اختياري.
/// ============================================================================
class EmptyStateWidget extends StatelessWidget {
  /// الأيقونة التوضيحية للحالة الفارغة
  final IconData icon;

  /// النص التوضيحي الذي يصف سبب فراغ الشاشة
  final String title;

  /// نص زر الإجراء (اختياري، مثلاً: "حجز موعد جديد")
  final String? actionText;

  /// دالة تنفيذ الإجراء عند الضغط على الزر (اختيارية)
  final VoidCallback? onAction;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الدائرة الحاضنة للأيقونة
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 34,
                color: cs.primary,
              ),
            ),
            const SizedBox(height: 16),

            // عنوان ورسالة الحالة الفارغة
            Text(
              title,
              style: tt.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.secondary,
              ),
              textAlign: TextAlign.center,
            ),

            // زر الإجراء إذا تم تمرير نص ودالة
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: onAction,
                child: Text(actionText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
