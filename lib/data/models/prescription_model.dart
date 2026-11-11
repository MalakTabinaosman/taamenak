class PrescriptionModel {
  final String id;
  final String orderNumber;
  final String pharmacyName;
  final String branch;
  final String dateStr;
  final String status;
  final int itemsCount;
  final String notes;

  const PrescriptionModel({
    this.id = '',
    required this.orderNumber,
    required this.pharmacyName,
    required this.branch,
    required this.dateStr,
    required this.status,
    this.itemsCount = 3,
    this.notes = '',
  });

  PrescriptionModel copyWith({
    String? id,
    String? orderNumber,
    String? pharmacyName,
    String? branch,
    String? dateStr,
    String? status,
    int? itemsCount,
    String? notes,
  }) {
    return PrescriptionModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      pharmacyName: pharmacyName ?? this.pharmacyName,
      branch: branch ?? this.branch,
      dateStr: dateStr ?? this.dateStr,
      status: status ?? this.status,
      itemsCount: itemsCount ?? this.itemsCount,
      notes: notes ?? this.notes,
    );
  }

 
}
