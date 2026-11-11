import 'package:flutter/material.dart';
import 'package:taamenak/core/widgets/app_bottom_sheet.dart';
import 'package:taamenak/data/models/doctor_model.dart';

void showBookingConfirmationSheet({
  required BuildContext context,
  required DoctorModel doctor,
  void Function(String selectedDay, String selectedSlot)? onConfirmed,
}) {
  final cs = Theme.of(context).colorScheme;
  final tt = Theme.of(context).textTheme;

  int selectedDayIndex = 0;
  int selectedSlotIndex = 0;

  showAppModalBottomSheet(
    context: context,
    title: 'تأكيد حجز موعد',
    child: StatefulBuilder(
      builder: (context, setModalState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Summary Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: cs.primary.withValues(alpha: 0.12),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: cs.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: cs.primary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.name,
                          style: tt.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: cs.secondary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          doctor.specialty,
                          style: tt.bodySmall?.copyWith(
                            color: cs.secondary.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          doctor.hospital,
                          style: tt.bodySmall?.copyWith(
                            color: cs.secondary.withValues(alpha: 0.6),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Select Day
            Text(
              'اختر اليوم',
              style: tt.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.secondary,
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(doctor.availableDays.length, (index) {
                  final isSelected = selectedDayIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setModalState(() {
                        selectedDayIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? cs.primary : cs.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? cs.primary
                              : cs.onSurface.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        doctor.availableDays[index],
                        style: tt.bodySmall?.copyWith(
                          color: isSelected ? Colors.white : cs.secondary,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 16),

            // Select Time Slot
            Text(
              'المواعيد المتاحة',
              style: tt.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: cs.secondary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(doctor.availableSlots.length, (index) {
                final isSelected = selectedSlotIndex == index;
                return GestureDetector(
                  onTap: () {
                    setModalState(() {
                      selectedSlotIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? cs.primary.withValues(alpha: 0.12)
                          : cs.surface,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? cs.primary
                            : cs.onSurface.withValues(alpha: 0.1),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Text(
                      doctor.availableSlots[index],
                      style: tt.bodySmall?.copyWith(
                        color: isSelected ? cs.primary : cs.secondary,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  final chosenDay = doctor.availableDays[selectedDayIndex];
                  final chosenSlot = doctor.availableSlots[selectedSlotIndex];

                  onConfirmed?.call(chosenDay, chosenSlot);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: cs.primary,
                      content: Text(
                        'تم تأكيد حجزك مع ${doctor.name} بنجاح!',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
                child: const Text('تأكيد الحجز الآن'),
              ),
            ),
          ],
        );
      },
    ),
  );
}
