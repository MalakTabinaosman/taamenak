import 'package:flutter/material.dart';
import 'package:taamenak/core/widgets/app_card.dart';
import 'package:taamenak/core/widgets/status_badge.dart';
import 'package:taamenak/data/models/prescription_model.dart';

class RecentPrescriptionsSection extends StatelessWidget {
  final PrescriptionModel? prescription;
  final VoidCallback? onViewAll;
  final VoidCallback? onTap;

  const RecentPrescriptionsSection({
    super.key,
    this.prescription,
    this.onViewAll,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'آخر طلبات الروشتات',
              style: tt.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.secondary,
              ),
            ),
            if (onViewAll != null)
              GestureDetector(
                onTap: onViewAll,
                child: Text(
                  'عرض الكل',
                  style: tt.bodyMedium?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        if (prescription == null)
          AppCard(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.description_outlined, color: cs.primary),
                  const SizedBox(width: 10),
                  Text(
                    'لا توجد طلبات روشتات حالياً',
                    style: tt.bodyMedium?.copyWith(
                      color: cs.secondary.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          AppCard(
            onTap: onTap,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'طلب ${prescription!.orderNumber}',
                            style: tt.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: cs.secondary,
                              fontSize: 15,
                            ),
                          ),
                          StatusBadge(status: prescription!.status),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${prescription!.pharmacyName} • ${prescription!.branch}',
                        style: tt.bodySmall?.copyWith(
                          color: cs.secondary.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        prescription!.dateStr,
                        style: tt.bodySmall?.copyWith(
                          color: cs.secondary.withValues(alpha: 0.5),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
