import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/components/app_error_widget.dart';
import 'package:mindecho/core/components/custom_text_field.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/features/Doctor/ui/manager/doctor_cubit.dart';
import 'package:mindecho/features/Doctor/domain/entities/doctor_entity.dart';
import 'doctor_details_screen.dart';

class ExploreDoctorsScreen extends StatefulWidget {
  const ExploreDoctorsScreen({super.key});

  @override
  State<ExploreDoctorsScreen> createState() => _ExploreDoctorsScreenState();
}

class _ExploreDoctorsScreenState extends State<ExploreDoctorsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Fetch all doctors from backend
    context.read<DoctorCubit>().getAllDoctors();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.gray50,
        foregroundColor: AppColors.blackColor,
        title: Text(
          "Explore Therapists",
          style: AppStyles.bold22Black,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Search field
            CustomTextField(
              controller: _searchController,
              hintText: "Search therapist by name or specialty...",
              prefixIcon: const Icon(Icons.search, color: Colors.black54),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.black54),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    )
                  : null,
              onChanged: (v) {
                setState(() => _searchQuery = v.toLowerCase().trim());
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<DoctorCubit, DoctorState>(
                builder: (context, state) {
                  if (state.isLoading && state.allDoctors == null) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.lavenderColor,
                      ),
                    );
                  }

                  if (state.error != null && state.allDoctors == null) {
                    return AppErrorWidget(
                      message: state.error!.errors ?? "Failed to load therapists",
                      onRetry: () => context.read<DoctorCubit>().getAllDoctors(),
                      title: "Connection Problem",
                    );
                  }

                  final doctorList = state.allDoctors;
                  if (doctorList == null || doctorList.doctors.isEmpty) {
                    return Center(
                      child: Text(
                        "No therapists available at the moment.",
                        style: AppStyles.medium17Gray,
                      ),
                    );
                  }

                  // Filter doctors by name or specialty
                  var filteredDoctors = doctorList.doctors;
                  if (_searchQuery.isNotEmpty) {
                    filteredDoctors = filteredDoctors.where((doc) {
                      final name = doc.fullName.toLowerCase();
                      final specialty = (doc.specialization ?? '').toLowerCase();
                      return name.contains(_searchQuery) ||
                          specialty.contains(_searchQuery);
                    }).toList();
                  }

                  if (filteredDoctors.isEmpty) {
                    return Center(
                      child: Text(
                        "No results match your search.",
                        style: AppStyles.medium17Gray,
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredDoctors.length,
                    padding: const EdgeInsets.only(bottom: 20),
                    itemBuilder: (context, index) {
                      final doctor = filteredDoctors[index];
                      return _DoctorCard(doctor: doctor);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  final DoctorProfileEntity doctor;

  const _DoctorCard({required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DoctorDetailsScreen(doctor: doctor),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Avatar
              CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.lavenderColor.withValues(alpha: 0.15),
                backgroundImage: doctor.profilePicture != null &&
                        doctor.profilePicture!.isNotEmpty
                    ? NetworkImage(doctor.profilePicture!)
                    : null,
                child: doctor.profilePicture == null ||
                        doctor.profilePicture!.isEmpty
                    ? Text(
                        doctor.fullName.isNotEmpty
                            ? doctor.fullName[0].toUpperCase()
                            : 'D',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.lavenderColor,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              // Doctor Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. ${doctor.fullName}",
                      style: AppStyles.bold18Black,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor.specialization ?? "General Wellness",
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.lavenderColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (doctor.bio != null && doctor.bio!.isNotEmpty)
                      Text(
                        doctor.bio!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.medium14DarkGray,
                      ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.cake_outlined, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          "${doctor.age} years old",
                          style: AppStyles.medium12DarkGray,
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          doctor.gender == 0 ? Icons.male : Icons.female,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          doctor.gender == 0 ? "Male" : "Female",
                          style: AppStyles.medium12DarkGray,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
