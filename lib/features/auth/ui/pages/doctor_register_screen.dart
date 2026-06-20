import 'package:flutter/material.dart';
import 'package:mindecho/features/auth/ui/widgets/doctor_register_form.dart';

/// Doctor Registration Screen
/// Create account for therapists and counselors
class DoctorRegisterScreen extends StatelessWidget {
  const DoctorRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: DoctorRegisterForm(),
      ),
    );
  }
}
