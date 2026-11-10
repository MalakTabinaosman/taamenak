import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  static const String routeName = '/homepage';

  //شاشه الhome page
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              HomeHeaderSection(),
              SizedBox(height: 20),
              HomeSearchBar(),
              SizedBox(height: 12),
              NextAppointmentSection(),
              SizedBox(height: 12),
              QuickServicesSection(),
              SizedBox(height: 12),
              RecentPrescriptionsSection(),
              SizedBox(height: 12),
              SecurityBanner(),
            ],
          ),
        ),
      ),
    );
  }
}

//العباره الترحيبيه
class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.onSurface.withValues(alpha: 0.1),
            ),
          ),
          child: IconButton(
            icon: Icon(
              Icons.notifications_none_outlined,
              color: colorScheme.secondary,
            ),
            onPressed: () {},
          ),
        ),

        const SizedBox(height: 4),
        Text('أهلاً يا سارة', style: textTheme.displayLarge),
      ],
    );
  }
}

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      decoration: InputDecoration(
        hintText: 'ابحث عن دكتور، تخصص أو مستشفى',
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.secondary.withValues(alpha: 0.4),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: colorScheme.secondary.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

//موعدك القادم

class NextAppointmentSection extends StatelessWidget {
  const NextAppointmentSection({super.key});

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
              'كل المواعيد',
              style: tt.bodyMedium?.copyWith(
                color: cs.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'موعدك القادم',
              style: tt.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.onSurface.withValues(alpha: 0.1)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.centerLeft),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'مؤكد',
                  style: tt.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'د. مني عادل',
                      style: tt.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: cs.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'استشاري قلب وأوعية دموية',
                      style: tt.bodySmall?.copyWith(
                        color: cs.secondary.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'مستشفى النيل • ٠١:٣٠ م',
                          style: tt.bodySmall?.copyWith(
                            color: cs.secondary.withValues(alpha: 0.6),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.access_time_outlined,
                          size: 14,
                          color: cs.secondary.withValues(alpha: 0.6),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '٢٤',
                      style: tt.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: cs.primary,
                      ),
                    ),
                    Text(
                      'يونيو',
                      style: tt.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: cs.primary,
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

//خدمات سريعة
class QuickServicesSection extends StatelessWidget {
  const QuickServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('خدمات سريعة', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const QuickServiceItem(
              icon: Icons.calendar_today_outlined,
              label: 'مواعيدي',
            ),
            const QuickServiceItem(
              icon: Icons.science_outlined,
              label: 'التحاليل والأشعة',
            ),
            const QuickServiceItem(
              icon: Icons.camera_alt_outlined,
              label: 'صور الروشتة',
            ),
            QuickServiceItem(
              icon: Icons.medical_services_outlined,
              label: 'احجز دكتور',
            ),
          ],
        ),
      ],
    );
  }
}

// ايقونات الخدمات السريعه
class QuickServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const QuickServiceItem({super.key, required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
            ),
          ),
          child: Icon(icon, color: theme.colorScheme.primary, size: 26),
        ),
        const SizedBox(height: 3),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}

// اخر الروشتات
class RecentPrescriptionsSection extends StatelessWidget {
  const RecentPrescriptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'عرض الكل',
              style: tt.bodyMedium?.copyWith(
                color: cs.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'آخر طلبات الروشتات',
              style: tt.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.onSurface.withValues(alpha: 0.1)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(alignment: Alignment.centerLeft),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'في انتظار الرد',
                  style: tt.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'طلب #RX-2048',
                      style: tt.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: cs.secondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'صيدلية العزبي • فرع الدقي',
                      style: tt.bodySmall?.copyWith(
                        color: cs.secondary.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'اليوم، ١١:٤٥ ص',
                      style: tt.bodySmall?.copyWith(
                        color: cs.secondary.withValues(alpha: 0.5),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: cs.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.description_outlined,
                  color: cs.primary,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// العبارة الامنيه
class SecurityBanner extends StatelessWidget {
  const SecurityBanner({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Icon(Icons.shield_outlined, size: 18, color: colorScheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'بياناتك الصحية محمية ولا تظهر إلا للجهات المصرح لها',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  color: colorScheme.secondary.withValues(alpha: 0.7),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
