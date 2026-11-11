import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;
  final bool showIcon;

  const StatusBadge({
    super.key,
    required this.status,
    this.showIcon = true,
  });

  static Color getStatusColor(BuildContext context, String status) {
    final theme = Theme.of(context);
    switch (status.trim()) {
      case 'مؤكد':
      case 'متوفر بالكامل':
      case 'نشط':
        return const Color(0xFF10B981); // Emerald Green
      case 'قيد التأكيد':
      case 'في انتظار الرد':
      case 'معلق':
        return const Color(0xFFF59E0B); // Amber / Orange
      case 'مكتمل':
      case 'تم الرد':
        return theme.colorScheme.primary; // Brand Primary
      case 'متوفر جزئياً':
        return const Color(0xFF0284C7); // Sky Blue / Cyan
      case 'ملغي':
      case 'مرفوض':
        return theme.colorScheme.error; // Red
      default:
        return theme.colorScheme.secondary.withValues(alpha: 0.6);
    }
  }

  static IconData getStatusIcon(String status) {
    switch (status.trim()) {
      case 'مؤكد':
      case 'متوفر بالكامل':
      case 'نشط':
        return Icons.check_circle_outline;
      case 'قيد التأكيد':
      case 'في انتظار الرد':
      case 'معلق':
        return Icons.hourglass_empty_rounded;
      case 'مكتمل':
      case 'تم الرد':
        return Icons.task_alt_rounded;
      case 'متوفر جزئياً':
        return Icons.pie_chart_outline_rounded;
      case 'ملغي':
      case 'مرفوض':
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor(context, status);
    final statusIcon = getStatusIcon(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
          if (showIcon) ...[
            Icon(
              statusIcon,
              size: 12,
              color: statusColor,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
