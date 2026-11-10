import 'package:flutter/material.dart';
import 'package:taamenak/core/modal/appointment_modal.dart';

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

  Color _getStatusColor(BuildContext context, String status) {
    final theme = Theme.of(context);
    switch (status.trim()) {
      case 'مؤكد':
        return const Color(0xFF10B981); // Emerald Green
      case 'قيد التأكيد':
        return const Color(0xFFF59E0B); // Amber / Orange
      case 'مكتمل':
        return theme.colorScheme.primary; // Brand Primary
      case 'ملغي':
        return theme.colorScheme.error; // Theme Error Red
      default:
        return theme.colorScheme.secondary.withValues(alpha: 0.6);
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.trim()) {
      case 'مؤكد':
        return Icons.check_circle_outline;
      case 'قيد التأكيد':
        return Icons.hourglass_empty_rounded;
      case 'مكتمل':
        return Icons.task_alt_rounded;
      case 'ملغي':
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final status = appointment.status;
    final statusColor = _getStatusColor(context, status);
    final statusIcon = _getStatusIcon(status);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: colorScheme.onSurface.withValues(alpha: 0.08),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.secondary.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Date Box (مربع التاريخ متناسق مع هوية التطبيق)
            Container(
              width: 64,
              height: 72,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appointment.day,
                    style: textTheme.headlineMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    appointment.month,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Appointment Details (بيانات الحجز)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row: Title and Status Badge
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          appointment.title,
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
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
                            Icon(
                              statusIcon,
                              size: 12,
                              color: statusColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              status,
                              style: textTheme.labelSmall?.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Subtitle (التخصص أو نوع الفحص)
                  Text(
                    appointment.subtitle,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.secondary.withValues(alpha: 0.7),
                      fontSize: 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 6),

                  // Time and Hospital row
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        size: 14,
                        color: colorScheme.secondary.withValues(alpha: 0.6),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        appointment.time,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.secondary.withValues(alpha: 0.6),
                          fontSize: 11,
                        ),
                      ),
                      if (appointment.hospital.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text(
                            '•',
                            style: TextStyle(
                              color: colorScheme.secondary.withValues(alpha: 0.4),
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: colorScheme.secondary.withValues(alpha: 0.6),
                        ),
                        const SizedBox(width: 2),
                        Flexible(
                          child: Text(
                            appointment.hospital,
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.secondary.withValues(alpha: 0.6),
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
    );
  }
}
