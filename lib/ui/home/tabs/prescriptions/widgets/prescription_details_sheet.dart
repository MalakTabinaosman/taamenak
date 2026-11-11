import 'package:flutter/material.dart';
import 'package:taamenak/core/widgets/app_bottom_sheet.dart';
import 'package:taamenak/data/models/prescription_model.dart';
import 'package:taamenak/ui/home/tabs/prescriptions/widgets/prescription_card.dart';

void showPrescriptionDetailsSheet(
  BuildContext context,
  PrescriptionModel prescription,
) {
  showAppModalBottomSheet(
    context: context,
    title: 'تفاصيل الروشتة',
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrescriptionCard(prescription: prescription),
        const SizedBox(height: 14),

        _buildInfoTile(
          context: context,
          icon: Icons.medication_outlined,
          title: 'الأدوية المطلوبة',
          value: '${prescription.itemsCount} أصناف معتمدة بالتأمين',
        ),
        const SizedBox(height: 10),

        _buildInfoTile(
          context: context,
          icon: Icons.health_and_safety_outlined,
          title: 'نسبة التحمل التأميني',
          value: 'تغطية 100% - بدون دفع نقدي',
        ),

        const SizedBox(height: 20),
      ],
    ),
  );
}

Widget _buildInfoTile({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String value,
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
        Icon(icon, size: 20, color: cs.primary),
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
