import 'package:flutter/material.dart';

class QuickServicesSection extends StatelessWidget {
  final ValueChanged<int>? onServiceTap;

  const QuickServicesSection({super.key, this.onServiceTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'خدمات سريعة',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: QuickServiceItem(
                icon: Icons.calendar_today_outlined,
                label: 'مواعيدي',
                onTap: () => onServiceTap?.call(3),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: QuickServiceItem(
                icon: Icons.science_outlined,
                label: 'التحاليل والأشعة',
                onTap: () => onServiceTap?.call(1),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: QuickServiceItem(
                icon: Icons.camera_alt_outlined,
                label: 'صور الروشتة',
                onTap: () => onServiceTap?.call(2),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: QuickServiceItem(
                icon: Icons.medical_services_outlined,
                label: 'احجز دكتور',
                onTap: () => onServiceTap?.call(1),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class QuickServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const QuickServiceItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: cs.onSurface.withValues(alpha: 0.08),
              ),
              boxShadow: [
                BoxShadow(
                  color: cs.secondary.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: cs.primary, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: cs.secondary,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
