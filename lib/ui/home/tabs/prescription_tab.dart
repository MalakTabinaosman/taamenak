import 'package:flutter/material.dart';

class PrescriptionTab extends StatefulWidget {
  const PrescriptionTab({super.key});

  @override
  State<PrescriptionTab> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionTab> {
  String selectedTab = 'الكل';

  final List<Map<String, dynamic>> prescriptions = [
    {
      'status': 'في انتظار الرد',
      'bg': Color(0xFFFFF3CD),
      'fg': Color(0xFF856404),
    },
    {
      'status': 'متوفر بالكامل',
      'bg': Color(0xFFD4EDDA),
      'fg': Color(0xFF155724),
    },
    {
      'status': 'متوفر جزئياً',
      'bg': Color(0xFFD1ECF1),
      'fg': Color(0xFF0C5460),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: theme.surface,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,

          title: Text(
            'الروشتات',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // التابات
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: ['الكل', 'منتظر', 'تم الرد'].map((tab) {
                  bool isSelected = selectedTab == tab;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = tab;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected
                                ? Color(0xFF009688)
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        tab,
                        style: TextStyle(
                          color: isSelected ? Color(0xFF009688) : Colors.grey,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: 12),

            // الكروت
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: prescriptions.length,
                itemBuilder: (context, index) {
                  var item = prescriptions[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFE8F6F3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.description_outlined,
                            color: Color(0xFF009688),
                            size: 26,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'طلب #RX-2048',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'صيدلية العزبي • فرع الدقي',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'اليوم، 11:45 ص',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: item['bg'],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item['status'],
                            style: TextStyle(
                              color: item['fg'],
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
