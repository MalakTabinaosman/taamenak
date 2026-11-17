import 'package:flutter/material.dart';
import 'package:taamenak/core/widgets/custom_header.dart';
import 'package:taamenak/data/services/auth_service.dart';
import 'package:taamenak/data/services/user_session.dart';
import 'package:taamenak/ui/home/tabs/profile/widgets/insurance_card_widget.dart';
import 'package:taamenak/ui/home/tabs/profile/widgets/profile_menu_item.dart';

/// ============================================================================
/// تبويب حسابي والملف الشخصي (ProfileTab)
/// يتيح للمريض:
/// 1. استعراض بطاقة التأمين الطبي الرقمية [InsuranceCardWidget] المربوطة ببيانات المريض المسجل.
/// 2. فتح ورقة البيانات الشخصية (الاسم، البريد، الهاتف، رقم التأمين).
/// 3. التواصل مع الدعم الفني والمساعدة.
/// 4. تسجيل الخروج مع نافذة تأكيد ومسح الجلسة من [UserSession] وتوجيه المستخدم لـ `/login`.
/// ============================================================================
class ProfileTab extends StatelessWidget {
  /// اسم المسار
  static const String routeName = '/profile';

  const ProfileTab({super.key});

  /// إظهار ورقة منبثقة سفلية بالبيانات الشخصية الكاملة للمريض
  void _showPersonalDetails(BuildContext context) {
    final user = UserSession.currentUser;
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // مقبض السحب الرمادي
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // عنوان النافذة
              Text(
                'البيانات الشخصية',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 20),

              // صفوف عرض تفاصيل المريض
              _buildDetailRow(context, Icons.person_outline, 'الاسم بالكامل', user.name),
              const Divider(height: 20),
              _buildDetailRow(context, Icons.email_outlined, 'البريد الإلكتروني', user.email.isNotEmpty ? user.email : 'غير مسجل'),
              const Divider(height: 20),
              _buildDetailRow(context, Icons.phone_outlined, 'رقم الهاتف', user.phone.isNotEmpty ? user.phone : 'غير مسجل'),
              const Divider(height: 20),
              _buildDetailRow(context, Icons.verified_user_outlined, 'رقم التأمين', user.insuranceId.isNotEmpty ? user.insuranceId : 'TM-78945612'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// ودجت مساعدة لبناء صف معلومة شخصية بأيقونة وتسمية وقيمة
  Widget _buildDetailRow(BuildContext context, IconData icon, String label, String value) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, size: 22, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.disabledColor)),
            Text(value, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.secondary)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final user = UserSession.currentUser;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ---------------------------------------------------------------
              // ترويسة التبويب مع شارة بطاقة التأمين
              // ---------------------------------------------------------------
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
                      // -------------------------------------------------------
                      // بطاقة التأمين الرقمية بالاسم ورقم التأمين وتاريخ الانتهاء
                      // -------------------------------------------------------
                      InsuranceCardWidget(user: user),

                      const SizedBox(height: 20),

                      // -------------------------------------------------------
                      // قسم الخدمات التأمينية
                      // -------------------------------------------------------
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
                        subtitle: 'الاسم، رقم الهاتف، رقم التأمين',
                        onTap: () => _showPersonalDetails(context),
                      ),

                      const SizedBox(height: 16),

                      // -------------------------------------------------------
                      // قسم الإعدادات والدعم وتسجيل الخروج
                      // -------------------------------------------------------
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
                          // طلب تأكيد تسجيل الخروج عبر AlertDialog
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
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text('إلغاء'),
                                ),
                                FilledButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: cs.error,
                                  ),
                                  child: const Text('خروج'),
                                ),
                              ],
                            ),
                          );

                          // مسح الجلسة والتوجه لشاشة تسجيل الدخول
                          if (confirm == true && context.mounted) {
                            await AuthService().signOut();
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(context, '/login');
                            }
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
