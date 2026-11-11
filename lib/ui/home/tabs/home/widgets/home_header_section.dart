import 'package:flutter/material.dart';

class HomeHeaderSection extends StatelessWidget {
  final String userName;
  final VoidCallback? onNotificationTap;

  const HomeHeaderSection({
    super.key,
    required this.userName,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'أهلاً بك 👋',
              style: tt.bodySmall?.copyWith(
                color: cs.secondary.withValues(alpha: 0.6),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              userName,
              style: tt.displayLarge?.copyWith(
                fontSize: 22,
                color: cs.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        // Notifications Button
        Container(
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: cs.onSurface.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: cs.secondary.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(
              Icons.notifications_none_outlined,
              color: cs.secondary,
            ),
            onPressed: onNotificationTap ?? () {},
          ),
        ),
      ],
    );
  }
}
