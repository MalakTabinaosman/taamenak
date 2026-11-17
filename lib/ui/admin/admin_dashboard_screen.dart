import 'package:flutter/material.dart';
import 'package:taamenak/data/services/auth_service.dart';

// ========================================================
// شاشة لوحة تحكم الإدارة والموظفين (AdminDashboardScreen)
// تعرض قائمة بجميع المرضى الذين سجلوا وحالتهم 'pending' لمراجعتهم
// وتمكن الموظف أو الأدمن من قبول الحساب أو رفضه
// ========================================================
class AdminDashboardScreen extends StatefulWidget {
  static const String routeName = '/admin';

  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final AuthService _authService = AuthService();

  // قائمة المرضى المعلقين
  List<Map<String, dynamic>> _pendingPatients = [];

  // حالة تحميل البيانات من السيرفر
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // جلب قائمة المرضى فور فتح الشاشة
    _loadPendingPatients();
  }

  /// دالة جلب المرضى الذين ينتظرون الموافقة من Supabase
  Future<void> _loadPendingPatients() async {
    setState(() => _isLoading = true);
    try {
      final list = await _authService.getPendingPatients();
      setState(() {
        _pendingPatients = list;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ في جلب البيانات: $e')),
        );
      }
    }
  }

  /// دالة تحديث حالة المريض (قبول 'approved' أو رفض 'rejected')
  Future<void> _updateStatus(dynamic userId, String newStatus, String patientName) async {
    try {
      await _authService.updatePatientStatus(
        userId: userId,
        newStatus: newStatus,
      );

      if (mounted) {
        final theme = Theme.of(context);
        final isApproved = newStatus == 'approved';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isApproved
                  ? 'تمت الموافقة على حساب $patientName بنجاح ✅'
                  : 'تم رفض طلب حساب $patientName ❌',
            ),
            backgroundColor: isApproved ? theme.colorScheme.primary : theme.colorScheme.error,
          ),
        );
      }

      // إعادة تحميل القائمة لتحديث العناصر على الشاشة
      _loadPendingPatients();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('فشل التحديث: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'لوحة تحكم الإدارة والموظفين',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          actions: [
            // زر تسجيل الخروج
            IconButton(
              icon: const Icon(Icons.logout_rounded),
              tooltip: 'تسجيل الخروج',
              onPressed: () async {
                await _authService.signOut();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          // إمكانية السحب لأسفل لتحديث القائمة (Pull to Refresh)
          onRefresh: _loadPendingPatients,
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _pendingPatients.isEmpty
                  ? Center(
                      // حالة عدم وجود طلبات جديدة
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            size: 70,
                            color: theme.colorScheme.primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'لا توجد طلبات معلقة حالياً 🎉',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'تمت مراجعة جميع حسابات المرضى المسجلين.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.disabledColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _pendingPatients.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final patient = _pendingPatients[index];
                        final name = patient['user_name'] ?? 'مريض غير مسمى';
                        final email = patient['email'] ?? 'بدون بريد';
                        final userId = patient['user_id'];

                        // بطاقة عرض بيانات المريض المعلق
                        return Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color: theme.colorScheme.outline.withValues(alpha: 0.2),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                                      child: Icon(
                                        Icons.person,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            style: theme.textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            email,
                                            style: theme.textTheme.bodySmall?.copyWith(
                                              color: theme.disabledColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // شارة الحالة "قيد المراجعة"
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
                                      ),
                                      child: Text(
                                        'قيد المراجعة',
                                        style: TextStyle(
                                          color: theme.colorScheme.primary,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Divider(height: 1),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    // زر قبول المريض وتفعيل حسابه
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: theme.colorScheme.primary,
                                          foregroundColor: theme.colorScheme.onPrimary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () => _updateStatus(userId, 'approved', name),
                                        icon: const Icon(Icons.check, size: 18),
                                        label: const Text('قبول الحساب'),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // زر رفض المريض
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: theme.colorScheme.error,
                                          side: BorderSide(color: theme.colorScheme.error),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () => _updateStatus(userId, 'rejected', name),
                                        icon: const Icon(Icons.close, size: 18),
                                        label: const Text('رفض'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
