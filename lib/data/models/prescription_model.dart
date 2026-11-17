// ========================================================
// نموذج بيانات الروشتة الطبية (PrescriptionModel)
// يمثل بيانات الروشتات وصرف الأدوية في شاشة الروشتات
// ========================================================
class PrescriptionModel {
  /// المعرف الفريد للروشتة
  final String id;

  /// رقم الطلب أو الروشتة (مثلاً: #RX-8942)
  final String orderNumber;

  /// اسم الصيدلية (مثلاً: صيدليات العزبي)
  final String pharmacyName;

  /// اسم الفرع (مثلاً: فرع المعادي)
  final String branch;

  /// تاريخ صرف أو كتابة الروشتة
  final String dateStr;

  /// حالة الروشتة (مثلاً: جاهزة للاستلام، قيد التحضير، تم الصرف)
  final String status;

  /// عدد الأصناف أو الأدوية الموجودة بالروشتة
  final int itemsCount;

  /// ملاحظات الصيدلي أو تعليمات الاستخدام
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

  /// دالة لنسخ النموذج مع تعديل بعض القيم
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
