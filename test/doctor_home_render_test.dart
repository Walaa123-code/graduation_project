import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindecho/features/doctor/home/pages/doctor_home_screen.dart';

void main() {
  testWidgets('DoctorHomeScreen renders correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: DoctorHomeScreen(),
      ),
    );

    expect(find.byType(DoctorHomeScreen), findsOneWidget);
    expect(find.text('Patients'), findsNWidgets(2)); // Stats and Action
    expect(find.byIcon(Icons.people_alt), findsOneWidget); // Action Icon
  });
}
