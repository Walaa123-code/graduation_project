import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../models/patient_model.dart';
import '../widgets/patient_card.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final List<Patient> patients = [
      const Patient(
        id: '1',
        name: 'Ahmed Mohamed',
        imageUrl: '', // Placeholder
        lastStatus: 'Sad',
        lastStatusEmoji: '😢',
        lastSeen: '1 hour ago',
      ),
      const Patient(
        id: '2',
        name: 'Fatima Ali',
        imageUrl: '', // Placeholder
        lastStatus: 'Happy',
        lastStatusEmoji: '😊',
        lastSeen: '3 hours ago',
      ),
      const Patient(
        id: '3',
        name: 'Mahmoud Hassan',
        imageUrl: '', // Placeholder
        lastStatus: 'Angry',
        lastStatusEmoji: '😡',
        lastSeen: '5 hours ago',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              'Patients List',
              style: TextStyle(
                color: AppColors.gray800,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'You have 3 active patients',
              style: TextStyle(
                color: AppColors.gray500,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Hide back button if needed
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return PatientCard(
            patient: patient,
            onContact: () {
              // Handle contact
            },
            onViewDetails: () {
              // Handle details
            },
          );
        },
      ),
    );
  }
}
