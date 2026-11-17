import 'package:flutter/material.dart';

/// ============================================================================
/// شريط تبويبات التصفية المجزأة (FilterTabsBar)
/// يُستخدم في أعلى القوائم لتبديل العرض بين حالات محددة (مثل: القادمة / السابقة / الملغاة)،
/// مع إمكانية عرض عداد بجانب كل تبويب وتأثير حركي عند الانتقال.
/// ============================================================================
class FilterTabsBar extends StatelessWidget {
  /// قائمة أسماء التبويبات
  final List<String> tabs;

  /// الفهرس المحدد حالياً
  final int selectedIndex;

  /// دالة الاستدعاء عند اختيار تبويب جديد
  final ValueChanged<int> onTabSelected;

  /// أعداد العناصر لكل تبويب (اختيارية)
  final List<int>? counts;

  const FilterTabsBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.counts,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: cs.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          final count = counts != null && index < counts!.length ? counts![index] : null;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? cs.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // اسم التبويب
                    Text(
                      tabs[index],
                      style: tt.bodyMedium?.copyWith(
                        color: isSelected
                            ? Colors.white
                            : cs.secondary.withValues(alpha: 0.65),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 13,
                      ),
                    ),
                    // شارة العداد الصغير إن وجد
                    if (count != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.25)
                              : cs.secondary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$count',
                          style: tt.labelSmall?.copyWith(
                            color: isSelected
                                ? Colors.white
                                : cs.secondary.withValues(alpha: 0.7),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

/// ============================================================================
/// شريط الشرائح الأفقية القابلة للتمرير (FilterChipBar)
/// يُستخدم لتصنيفات الأطباء أو التخصصات (مثل: الكل، باطنة، أسنان، أطفال)،
/// يتيح التمرير الأفقي بسلاسة مع تمييز العنصر المختار.
/// ============================================================================
class FilterChipBar extends StatelessWidget {
  /// قائمة التصنيفات أو التخصصات
  final List<String> items;

  /// العنصر المحدد حالياً
  final String selectedItem;

  /// دالة الاستدعاء عند اختيار تصنيف
  final ValueChanged<String> onSelected;

  const FilterChipBar({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final tt = theme.textTheme;

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = selectedItem == item;

          return GestureDetector(
            onTap: () => onSelected(item),
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? cs.primary : cs.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? cs.primary
                      : cs.onSurface.withValues(alpha: 0.1),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: cs.primary.withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  item,
                  style: tt.bodySmall?.copyWith(
                    color: isSelected ? Colors.white : cs.secondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
