import 'package:flutter/material.dart';

/// ============================================================================
/// ودجت شارة التاريخ المربعة (DateBadge)
/// تُستخدم لعرض موعد أو تاريخ كبطاقة صغيرة منظمة تظهر رقم اليوم في الأعلى
/// واسم الشهر أو رمزه بالأسفل (مثل "15" / "مايو")، مماثلة لكروت المواعيد الطبية.
/// ============================================================================
class DateBadge extends StatelessWidget {
  /// رقم اليوم (مثال: "22")
  final String day;

  /// اسم أو اختصار الشهر (مثال: "نوفمبر")
  final String month;

  /// عرض الشارة (افتراضياً 64)
  final double width;

  /// ارتفاع الشارة (افتراضياً 72)
  final double height;

  const DateBadge({
    super.key,
    required this.day,
    required this.month,
    this.width = 64,
    this.height = 72,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: cs.primary.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // نص اليوم
          Text(
            day,
            style: tt.headlineMedium?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 2),
          // نص الشهر
          Text(
            month,
            style: tt.bodySmall?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
