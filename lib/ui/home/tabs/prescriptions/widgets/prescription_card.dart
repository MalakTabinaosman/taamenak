import 'package:flutter/material.dart';
import 'package:taamenak/core/widgets/app_card.dart';
import 'package:taamenak/core/widgets/status_badge.dart';
import 'package:taamenak/data/models/prescription_model.dart';

/// ============================================================================
/// كارت عرض الروشتة في القائمة (PrescriptionCard)
/// ده الـ Widget اللي بيعرض ملخص طلب الروشتة للمريض:
/// - أيقونة الروشتة الطبية
/// - رقم الأوردر أو الطلب (Order Number)
/// - شارة حالة الصرف (Status Badge) زي "متوفر بالكامل" أو "في انتظار الرد"
/// - اسم الصيدلية والفرع وتوقيت إرسال الطلب
/// - عند الضغط عليه بيفتح تفاصيل الروشتة بالكامل في Bottom Sheet
/// ============================================================================
class PrescriptionCard extends StatelessWidget {
  /// بيانات الروشتة الممررة للكارت
  final PrescriptionModel prescription;

  /// الـ Callback function اللي بتتنفذ لما المريض يضغط على الكارت
  final VoidCallback? onTap;

  const PrescriptionCard({
    super.key,
    required this.prescription,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return AppCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // -------------------------------------------------------------------
          // المربع اللي جواه أيقونة الروشتة بلون الـ Primary
          // -------------------------------------------------------------------
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cs.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: cs.primary.withValues(alpha: 0.15),
              ),
            ),
            child: Icon(
              Icons.description_outlined,
              color: cs.primary,
              size: 26,
            ),
          ),

          const SizedBox(width: 12),

          // -------------------------------------------------------------------
          // تفاصيل الروشتة: رقم الطلب، الحالة، الصيدلية، والوقت
          // -------------------------------------------------------------------
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الصف اللي فيه رقم الطلب وشارة الحالة (StatusBadge)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'طلب ${prescription.orderNumber}',
                      style: tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: cs.secondary,
                        fontSize: 15,
                      ),
                    ),
                    StatusBadge(status: prescription.status),
                  ],
                ),
                const SizedBox(height: 4),

                // اسم الصيدلية والفرع
                Text(
                  '${prescription.pharmacyName} • ${prescription.branch}',
                  style: tt.bodySmall?.copyWith(
                    color: cs.secondary.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),

                // وقت وتاريخ الطلب وملاحظات إضافية لو موجودة
                Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      size: 13,
                      color: cs.secondary.withValues(alpha: 0.5),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      prescription.dateStr,
                      style: tt.bodySmall?.copyWith(
                        color: cs.secondary.withValues(alpha: 0.5),
                        fontSize: 11,
                      ),
                    ),
                    if (prescription.notes.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '•',
                          style: TextStyle(
                            color: cs.secondary.withValues(alpha: 0.4),
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          prescription.notes,
                          style: tt.bodySmall?.copyWith(
                            color: cs.secondary.withValues(alpha: 0.6),
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
