import 'package:flutter/material.dart';
import 'package:taamenak/data/models/user_model.dart';

/// ============================================================================
/// ودجت بطاقة التأمين الطبي الرقمية (InsuranceCardWidget)
/// تحاكي بطاقة التأمين البلاستيكية بتصميم أنيق بتدرج لوني أزرق/أخضر وظلال ثلاثية الأبعاد.
/// تعرض:
/// - شارة نسبة التغطية التأمينية (مثال: تغطية 85%)
/// - اسم المريض المسجل
/// - رقم عضوية التأمين
/// - رقم الوثيقة وتاريخ انتهاء الصلاحية
/// ============================================================================
class InsuranceCardWidget extends StatelessWidget {
  /// بيانات المستخدم والمريض لعرضها على البطاقة
  final UserModel user;

  const InsuranceCardWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary, cs.primary.withValues(alpha: 0.85)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: cs.primary.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // شارة نسبة التغطية التأمينية
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              'تغطية ${user.coveragePercentage}%',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // اسم المريض ورقم العضوية
          Text(
            user.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'رقم العضوية: ${user.insuranceId.isNotEmpty ? user.insuranceId : "TM-78945612"}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.85),
              fontSize: 13,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 18),

          // خط فاصل شفاف داخل البطاقة
          Container(height: 1, color: Colors.white.withValues(alpha: 0.2)),

          const SizedBox(height: 12),

          // التفاصيل السفلية: رقم الوثيقة وصلاحية البطاقة
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // رقم الوثيقة
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'رقم الوثيقة',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.policyNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              // تاريخ سريان البطاقة
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'ساري حتى',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.validUntil,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
