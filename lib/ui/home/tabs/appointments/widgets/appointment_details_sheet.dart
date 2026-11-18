import 'package:flutter/material.dart';
import 'package:taamenak/core/widgets/app_bottom_sheet.dart';
import 'package:taamenak/data/models/appointment_model.dart';
import 'package:taamenak/ui/home/tabs/appointments/widgets/appointment_card.dart';

/// ============================================================================
/// دالة فتح تفاصيل الموعد (showAppointmentDetailsSheet)
/// تعرض ورقة سفلية (Modal Bottom Sheet) بتفاصيل حجز الموعد الطبي:
/// 1. كارت الموعد الطبي [AppointmentCard].
/// 2. تفاصيل التغطية التأمينية للمريض.
/// 3. عنوان العيادة أو المستشفى.
/// 4. خيارات إلغاء الموعد أو إعادة الجدولة.
/// ============================================================================
void showAppointmentDetailsSheet({
  required BuildContext context,
  required AppointmentModel appointment,
  VoidCallback? onCancel,
  void Function(String newTime)? onReschedule,
}) {
  final cs = Theme.of(context).colorScheme;

  showAppModalBottomSheet(
    context: context,
    title: 'تفاصيل الحجز',
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------------------------------------------------------------------
        // كارت الموعد
        // ---------------------------------------------------------------------
        AppointmentCard(appointment: appointment),
        const SizedBox(height: 16),

        // ---------------------------------------------------------------------
        // التغطية التأمينية
        // ---------------------------------------------------------------------
        _buildDetailTile(
          context: context,
          icon: Icons.verified_user_outlined,
          title: 'التغطية التأمينية',
          value: 'مغطى بنسبة 100% عبر تأمينك',
          color: cs.primary,
        ),
        const SizedBox(height: 12),

        // ---------------------------------------------------------------------
        // أزرار التحكم: إلغاء الموعد وإعادة الجدولة
        // ---------------------------------------------------------------------
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onCancel?.call();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إلغاء الموعد')),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: cs.error),
                  foregroundColor: cs.error,
                  backgroundColor: cs.error.withValues(alpha: 0.05),
                ),
                child: const Text('إلغاء الموعد'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  onReschedule?.call('٠٢:٠٠ م');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إرسال طلب إعادة الجدولة')),
                  );
                },
                child: const Text('إعادة الجدولة'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}

/// ودجت مساعدة لعرض تفاصيل الموعد بتنسيق موحد
Widget _buildDetailTile({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String value,
  required Color color,
}) {
  final cs = Theme.of(context).colorScheme;
  final tt = Theme.of(context).textTheme;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: cs.primary.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: cs.onSurface.withValues(alpha: 0.06)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: tt.bodySmall?.copyWith(
                  color: cs.secondary.withValues(alpha: 0.6),
                  fontSize: 11,
                ),
              ),
              Text(
                value,
                style: tt.bodyMedium?.copyWith(
                  color: cs.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
