import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mindecho/features/auth/login/ui/pages/login_screen.dart';
import 'package:mindecho/features/doctor/main/pages/doctor_main_screen.dart';
import 'package:mindecho/config/app_routes.dart';
import 'package:mindecho/core/theme/app_theme.dart';

void main() {
  testWidgets('Doctor login navigates to DoctorMainScreen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const LoginScreen(),
        routes: {
          Routes.doctorMain: (context) => const DoctorMainScreen(),
        },
      ),
    );

    // Enter doctor email
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Email Address'), 'doctor@test.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'), 'password123');

    // Tap Login button
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify DoctorMainScreen is displayed
    expect(find.byType(DoctorMainScreen), findsOneWidget);
  });

  testWidgets('User login shows snackbar (mock)', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    // Enter user email
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Email Address'), 'user@test.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'), 'password123');

    // Tap Login button
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Verify SnackBar is displayed
    expect(find.text('Logged in as user (Home not implemented yet)'),
        findsOneWidget);
  });
  testWidgets('Specific doctor email login navigates to DoctorMainScreen',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const LoginScreen(),
        routes: {
          Routes.doctorMain: (context) => const DoctorMainScreen(),
        },
      ),
    );

    // Enter specific doctor email
    await tester.enterText(find.widgetWithText(TextFormField, 'Email Address'),
        'wafaasakr044@gmail.com');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'), 'password123');

    // Tap Login button
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify DoctorMainScreen is displayed
    expect(find.byType(DoctorMainScreen), findsOneWidget);
  });
}
