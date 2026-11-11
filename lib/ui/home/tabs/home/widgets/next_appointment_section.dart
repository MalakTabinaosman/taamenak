import 'package:flutter/material.dart';
import 'package:taamenak/core/widgets/app_card.dart';
import 'package:taamenak/core/widgets/date_badge.dart';
import 'package:taamenak/data/models/appointment_model.dart';

class NextAppointmentSection extends StatelessWidget {
  final AppointmentModel? appointment;
  final VoidCallback? onViewAll;
  final VoidCallback? onTap;

  const NextAppointmentSection({
    super.key,
    this.appointment,
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
              'موعدك القادم',
              style: tt.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.secondary,
              ),
            ),
            if (onViewAll != null)
              GestureDetector(
                onTap: onViewAll,
                child: Text(
                  'كل المواعيد',
                  style: tt.bodyMedium?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        if (appointment == null)
          AppCard(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.event_available, color: cs.primary),
                  const SizedBox(width: 10),
                  Text(
                    'لا توجد مواعيد قادمة حالياً',
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
                DateBadge(
                  day: appointment!.day,
                  month: appointment!.month,
                  width: 58,
                  height: 64,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              appointment!.title,
                              style: tt.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: cs.secondary,
                                fontSize: 15,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        appointment!.subtitle,
                        style: tt.bodySmall?.copyWith(
                          color: cs.secondary.withValues(alpha: 0.7),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            size: 14,
                            color: cs.secondary.withValues(alpha: 0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            appointment!.time,
                            style: tt.bodySmall?.copyWith(
                              color: cs.secondary.withValues(alpha: 0.6),
                              fontSize: 11,
                            ),
                          ),
                          if (appointment!.hospital.isNotEmpty) ...[
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
                                appointment!.hospital,
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
          ),
      ],
    );
  }
}
