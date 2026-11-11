import 'package:flutter/material.dart';
import 'package:taamenak/core/widgets/app_card.dart';
import 'package:taamenak/core/widgets/date_badge.dart';
import 'package:taamenak/core/widgets/status_badge.dart';
import 'package:taamenak/data/models/appointment_model.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;

  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onTap,
    this.onCancel,
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
          // Date Badge
          DateBadge(
            day: appointment.day,
            month: appointment.month,
          ),

          const SizedBox(width: 12),

          // Appointment Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Status
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        appointment.title,
                        style: tt.titleMedium?.copyWith(
                          color: cs.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                ),

                const SizedBox(height: 4),

                // Subtitle
                Text(
                  appointment.subtitle,
                  style: tt.bodySmall?.copyWith(
                    color: cs.secondary.withValues(alpha: 0.7),
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 6),

                // Time and Hospital
                Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      size: 14,
                      color: cs.secondary.withValues(alpha: 0.6),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      appointment.time,
                      style: tt.bodySmall?.copyWith(
                        color: cs.secondary.withValues(alpha: 0.6),
                        fontSize: 11,
                      ),
                    ),
                    if (appointment.hospital.isNotEmpty) ...[
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
                      Icon(
                        Icons.location_on_outlined,
                        size: 14,
                        color: cs.secondary.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 2),
                      Flexible(
                        child: Text(
                          appointment.hospital,
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
