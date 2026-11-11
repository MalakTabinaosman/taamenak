import 'package:flutter/material.dart';

class DateBadge extends StatelessWidget {
  final String day;
  final String month;
  final double width;
  final double height;

  const DateBadge({
    super.key,
    required this.day,
    required this.month,
    this.width = 64,
    this.height = 72,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: cs.primary.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: tt.headlineMedium?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            month,
            style: tt.bodySmall?.copyWith(
              color: cs.primary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
