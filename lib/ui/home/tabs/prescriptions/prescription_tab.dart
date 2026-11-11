import 'package:flutter/material.dart';
import 'package:taamenak/core/widgets/custom_header.dart';
import 'package:taamenak/core/widgets/empty_state_widget.dart';
import 'package:taamenak/data/models/prescription_model.dart';
import 'package:taamenak/ui/home/tabs/prescriptions/widgets/prescription_card.dart';
import 'package:taamenak/ui/home/tabs/prescriptions/widgets/prescription_details_sheet.dart';

class PrescriptionTab extends StatelessWidget {
  static const String routeName = '/prescriptions';

  const PrescriptionTab({super.key});

  static const List<PrescriptionModel> _prescriptions = [
    PrescriptionModel(
      id: 'rx-1',
      orderNumber: '#RX-2048',
      pharmacyName: 'صيدلية العزبي',
      branch: 'فرع الدقي',
      dateStr: 'اليوم، ١١:٤٥ ص',
      status: 'في انتظار الرد',
      itemsCount: 3,
      notes: 'أدوية ضغط وڤيتامينات شهرية',
    ),
    PrescriptionModel(
      id: 'rx-2',
      orderNumber: '#RX-1980',
      pharmacyName: 'صيدليات سيف',
      branch: 'فرع المهندسين',
      dateStr: 'أمس، ٠٤:١٥ م',
      status: 'متوفر بالكامل',
      itemsCount: 2,
      notes: 'مضاد حيوي ومسكن معتمد',
    ),
    PrescriptionModel(
      id: 'rx-3',
      orderNumber: '#RX-1823',
      pharmacyName: 'صيدلية رشدي',
      branch: 'فرع المعادي',
      dateStr: '١٢ يونيو، ٠٢:٠٠ م',
      status: 'متوفر جزئياً',
      itemsCount: 4,
      notes: 'بديل دوائي متوفر ومطابق للتأمين',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                title: 'الروشتات',
                trailing: const HeaderBadge(
                  label: 'الطلبات',
                  icon: Icons.description_outlined,
                ),
              ),

              const SizedBox(height: 8),

              // List or Empty State
              Expanded(
                child: _prescriptions.isEmpty
                    ? const EmptyStateWidget(
                        icon: Icons.receipt_long_outlined,
                        title: 'لا توجد روشتات',
                      
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        itemCount: _prescriptions.length,
                        itemBuilder: (context, index) {
                          final prescription = _prescriptions[index];
                          return PrescriptionCard(
                            prescription: prescription,
                            onTap: () => showPrescriptionDetailsSheet(
                              context,
                              prescription,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
