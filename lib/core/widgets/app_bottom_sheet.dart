import 'package:flutter/material.dart';

/// ============================================================================
/// دالة مساعدة لفتح ورقة سفلية منبثقة موحدة التصميم (App Modal Bottom Sheet)
/// تُستخدم لعرض تفاصيل الروشتات، تأكيد الحجوزات، أو أي نماذج سفلية.
/// تتضمن شريط سحب علوي، عنوان، وزر إغلاق، وتدعم الـ RTL ورفع الصفحة مع لوحة المفاتيح.
/// ============================================================================
Future<T?> showAppModalBottomSheet<T>({
  required BuildContext context,
  required String title,
  required Widget child,
  Widget? trailing,
  bool isScrollControlled = true,
}) {
  final cs = Theme.of(context).colorScheme;
  final tt = Theme.of(context).textTheme;

  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    backgroundColor: cs.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 14,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // مقبض السحب الرمادي الصغير في أعلى النافذة
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: cs.secondary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // صف العنوان وزر الإغلاق
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: tt.titleLarge?.copyWith(
                      color: cs.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing ??
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: cs.secondary.withValues(alpha: 0.6),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                ],
              ),
              const SizedBox(height: 12),

              // محتوى النافذة الممرر من الصفحة المستدعية
              child,
            ],
          ),
        ),
      );
    },
  );
}
