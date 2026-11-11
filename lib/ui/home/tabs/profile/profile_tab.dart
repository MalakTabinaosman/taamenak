import 'package:flutter/material.dart';
import 'package:taamenak/core/widgets/custom_header.dart';
import 'package:taamenak/data/models/user_model.dart';
import 'package:taamenak/ui/home/tabs/profile/widgets/insurance_card_widget.dart';
import 'package:taamenak/ui/home/tabs/profile/widgets/profile_menu_item.dart';

class ProfileTab extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileTab({super.key});

  final UserModel currentUser = const UserModel(
    id: 'user-001',
    name: 'سارة أحمد',
    email: 'sara.ahmed@example.com',
    phone: '01012345678',
    nationalId: '29801011234567',
    insuranceId: 'TM-78945612',
    coveragePercentage: 100,
    validUntil: 'ديسمبر ٢٠٢٦',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Screen Header
              CustomHeader(
                title: 'حسابي',
                trailing: const HeaderBadge(
                  label: 'بطاقة التأمين',
                  icon: Icons.badge_outlined,
                ),
              ),

              const SizedBox(height: 8),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Digital Insurance Card
                      InsuranceCardWidget(user: currentUser),

                      const SizedBox(height: 20),

                      Text(
                        'الخدمات التأمينية',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: cs.secondary,
                        ),
                      ),
                      const SizedBox(height: 10),

                      ProfileMenuItem(
                        icon: Icons.person_outline,
                        title: 'البيانات الشخصية',
                        subtitle: 'الاسم، رقم الهاتف، الرقم القومي',
                        onTap: () {},
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'الإعدادات والدعم',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: cs.secondary,
                        ),
                      ),
                      const SizedBox(height: 10),

                      ProfileMenuItem(
                        icon: Icons.headset_mic_outlined,
                        title: 'المساعدة والدعم الفني',
                        subtitle: 'فريق خدمة العملاء متواجد على مدار الساعة',
                        onTap: () {},
                      ),
                      ProfileMenuItem(
                        icon: Icons.logout,
                        title: 'تسجيل الخروج',
                        iconColor: cs.error,
                        textColor: cs.error,
                        showChevron: false,
                        onTap: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: const Text('تسجيل الخروج'),
                              content: const Text(
                                'هل أنت متأكد من رغبتك في تسجيل الخروج؟',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('إلغاء'),
                                ),
                                FilledButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: cs.error,
                                  ),
                                  child: const Text('خروج'),
                                ),
                              ],
                            ),
                          );

                          if (confirm == true && context.mounted) {
                            Navigator.pushReplacementNamed(context, '/login');
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
