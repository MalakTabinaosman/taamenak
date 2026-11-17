import 'package:flutter/material.dart';

/// ============================================================================
/// ودجت شارة الحالة الطبية (StatusBadge)
/// تُستخدم لعرض حالة الموعد، الروشتة، أو التأمين (مثل: "مؤكد"، "قيد التأكيد"،
/// "متوفر بالكامل"، "ملغي"، "مكتمل") مع لون وأيقونة مناسبة تلقائياً بناءً على النص.
/// ============================================================================
class StatusBadge extends StatelessWidget {
  /// نص الحالة (مثال: "مؤكد"، "ملغي"، "متوفر بالكامل")
  final String status;

  /// هل يتم إظهار الأيقونة بجانب النص
  final bool showIcon;

  const StatusBadge({
    super.key,
    required this.status,
    this.showIcon = true,
  });

  /// دالة مساعدة لتحديد اللون المناسب للحالة
  static Color getStatusColor(BuildContext context, String status) {
    final theme = Theme.of(context);
    switch (status.trim()) {
      case 'مؤكد':
      case 'متوفر بالكامل':
      case 'نشط':
        return const Color(0xFF10B981); // أخضر زمردي يدل على النجاح والتوفر
      case 'قيد التأكيد':
      case 'في انتظار الرد':
      case 'معلق':
        return const Color(0xFFF59E0B); // برتقالي / عنبري يدل على الانتظار
      case 'مكتمل':
      case 'تم الرد':
        return theme.colorScheme.primary; // اللون الأساسي للتطبيق
      case 'متوفر جزئياً':
        return const Color(0xFF0284C7); // أزرق سماوي
      case 'ملغي':
      case 'مرفوض':
        return theme.colorScheme.error; // أحمر يدل على الإلغاء أو الخطأ
      default:
        return theme.colorScheme.secondary.withValues(alpha: 0.6);
    }
  }

  /// دالة مساعدة لاختيار الأيقونة المعبرة عن الحالة
  static IconData getStatusIcon(String status) {
    switch (status.trim()) {
      case 'مؤكد':
      case 'متوفر بالكامل':
      case 'نشط':
        return Icons.check_circle_outline; // علامة صح
      case 'قيد التأكيد':
      case 'في انتظار الرد':
      case 'معلق':
        return Icons.hourglass_empty_rounded; // ساعة رملية
      case 'مكتمل':
      case 'تم الرد':
        return Icons.task_alt_rounded; // مهمة مكتملة
      case 'متوفر جزئياً':
        return Icons.pie_chart_outline_rounded; // شكل دائري جزئي
      case 'ملغي':
      case 'مرفوض':
        return Icons.cancel_outlined; // علامة إلغاء
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor(context, status);
    final statusIcon = getStatusIcon(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusColor.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // أيقونة الحالة
          if (showIcon) ...[
            Icon(
              statusIcon,
              size: 12,
              color: statusColor,
            ),
            const SizedBox(width: 4),
          ],
          // نص الحالة
          Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
