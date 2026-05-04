import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindecho/features/doctor/home/pages/doctor_home_screen.dart';
import 'package:mindecho/features/doctor/appointments/pages/appointments_screen.dart';
import 'package:mindecho/features/doctor/messages/pages/messages_screen.dart';
import 'package:mindecho/features/doctor/reports/pages/reports_screen.dart';
import 'package:mindecho/core/theme/app_theme.dart';

void main() {
  // Helper to pump widget with routes
  Future<void> pumpDoctorHome(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        routes: {
          '/': (context) => const DoctorHomeScreen(),
          '/doctor/appointments': (context) => const AppointmentsScreen(),
          '/doctor/messages': (context) => const MessagesScreen(),
          '/doctor/reports': (context) => const ReportsScreen(),
          '/doctor/patients': (context) =>
              const Scaffold(body: Text('Patients')),
        },
      ),
    );
  }

  testWidgets('Appointments button navigates to AppointmentsScreen',
      (WidgetTester tester) async {
    await pumpDoctorHome(tester);

    // Find and Tap "Appointments"
    // Title is 'Appointments'
    final finder = find.text('Appointments');

    // Scroll to it
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();

    await tester.tap(finder);
    await tester.pumpAndSettle();

    expect(find.byType(AppointmentsScreen), findsOneWidget);
  });

  testWidgets('Messages button navigates to MessagesScreen',
      (WidgetTester tester) async {
    await pumpDoctorHome(tester);

    final finder = find.text('Messages');
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();

    await tester.tap(finder);
    await tester.pumpAndSettle();

    expect(find.byType(MessagesScreen), findsOneWidget);
  });

  testWidgets('Reports button navigates to ReportsScreen',
      (WidgetTester tester) async {
    await pumpDoctorHome(tester);

    final finder = find.text('Reports');
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();

    await tester.tap(finder);
    await tester.pumpAndSettle();

    expect(find.byType(ReportsScreen), findsOneWidget);
  });
}
