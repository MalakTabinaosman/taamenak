import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taamenak/ui/home/buttom_navigation_bar.dart';

void main() {
  testWidgets('HomeScreen tabs rendering test', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: HomeScreen(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify BottomNavigationBar items exist
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('الرئيسية'), findsOneWidget);
    expect(find.text('احجز'), findsOneWidget);
    expect(find.text('الروشتات'), findsOneWidget);
    expect(find.text('حسابي'), findsOneWidget);
  });
}
