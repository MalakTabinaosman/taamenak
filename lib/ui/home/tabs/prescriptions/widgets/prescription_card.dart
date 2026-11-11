import 'package:flutter/material.dart';
import 'package:taamenak/core/widgets/app_card.dart';
import 'package:taamenak/core/widgets/status_badge.dart';
import 'package:taamenak/data/models/prescription_model.dart';

class PrescriptionCard extends StatelessWidget {
  final PrescriptionModel prescription;
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
          // Icon Container
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

          // Prescription Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Text(
                  '${prescription.pharmacyName} • ${prescription.branch}',
                  style: tt.bodySmall?.copyWith(
                    color: cs.secondary.withValues(alpha: 0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
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
