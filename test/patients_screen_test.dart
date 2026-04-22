import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindecho/features/doctor/patients/pages/patients_screen.dart';
import 'package:mindecho/features/doctor/patients/widgets/patient_card.dart';

void main() {
  testWidgets('PatientsScreen renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: PatientsScreen()));

    // Verify Title
    expect(find.text('Patients List'), findsOneWidget);
    expect(find.text('You have 3 active patients'), findsOneWidget);

    // Verify Patient Cards
    expect(find.byType(PatientCard), findsNWidgets(3));
    expect(find.text('Ahmed Mohamed'), findsOneWidget);
    expect(find.text('Fatima Ali'), findsOneWidget);
    expect(find.text('Mahmoud Hassan'), findsOneWidget);

    // Verify Buttons
    expect(find.text('Contact'), findsNWidgets(3)); // One per card
    expect(find.text('View Details'), findsNWidgets(3)); // One per card
  });
}
