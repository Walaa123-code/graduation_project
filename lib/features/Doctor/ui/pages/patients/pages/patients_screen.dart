import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/theme/app_colors.dart';
import 'package:mindecho/features/Doctor/ui/manager/doctor_cubit.dart';
import 'package:mindecho/features/Doctor/ui/pages/patients/widgets/patient_card.dart';
import 'package:mindecho/features/Doctor/ui/pages/patients/widgets/patients_empty_state.dart';
import 'package:mindecho/features/Doctor/ui/pages/patients/widgets/patients_error_widget.dart';
import 'package:mindecho/core/utils/app_theme.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DoctorCubit>().getDoctorPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: BlocBuilder<DoctorCubit, DoctorState>(
          builder: (context, state) {
            final count = state.patients?.totalCount ?? 0;
            return Column(
              children: [
                const Text(
                  'Patients List',
                  style: TextStyle(
                    color: AppColors.gray800,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'You have $count active patients',
                  style: const TextStyle(
                    color: AppColors.gray500,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            );
          },
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DoctorCubit, DoctorState>(
        builder: (context, state) {
          if (state.isLoading && state.patients == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.patients == null) {
            return PatientsErrorWidget(
              message: state.error!.errors ?? 'Failed to load patients',
              onRetry: () => context.read<DoctorCubit>().getDoctorPatients(),
            );
          }
          if (state.patients != null) {
            final patients = state.patients!.doctors;
            if (patients.isEmpty) {
              return const PatientsEmptyState();
            }
            return ListView.builder(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              itemCount: patients.length,
              itemBuilder: (context, index) {
                return PatientCard(patient: patients[index]);
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
