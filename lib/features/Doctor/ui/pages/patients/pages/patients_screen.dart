import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../ui/manager/doctor_cubit.dart';

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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: AppColors.gray400),
                  const SizedBox(height: AppTheme.spacingMd),
                  Text(
                    state.error!.errors ?? 'Failed to load patients',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.gray600),
                  ),
                  const SizedBox(height: AppTheme.spacingMd),
                  ElevatedButton(
                    onPressed: () => context.read<DoctorCubit>().getDoctorPatients(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state.patients != null) {
            final patients = state.patients!.doctors;
            if (patients.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_outline, size: 64, color: AppColors.gray300),
                    SizedBox(height: AppTheme.spacingMd),
                    Text('No patients yet', style: TextStyle(color: AppColors.gray500)),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              itemCount: patients.length,
              itemBuilder: (context, index) {
                final patient = patients[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(AppTheme.spacingMd),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.purpleBg,
                      child: Text(
                        patient.fullName.isNotEmpty
                            ? patient.fullName[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.purpleSoft,
                        ),
                      ),
                    ),
                    title: Text(
                      patient.fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.gray800,
                      ),
                    ),
                    subtitle: Text(
                      patient.email ?? 'No email',
                      style: const TextStyle(color: AppColors.gray500, fontSize: 13),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.gray400),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
