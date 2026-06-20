import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/components/app_error_widget.dart';
import 'package:mindecho/core/components/custom_button.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/features/Doctor/domain/entities/doctor_entity.dart';
import 'package:mindecho/features/Doctor/domain/entities/schedule_entity.dart';
import 'package:mindecho/features/Doctor/ui/manager/schedule_cubit.dart';

import '../manager/booking_cubit.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final DoctorProfileEntity doctor;

  const DoctorDetailsScreen({super.key, required this.doctor});

  @override
  State<DoctorDetailsScreen> createState() => _DoctorDetailsScreenState();
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  ScheduleEntity? _selectedSlot;

  static const List<String> _days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  @override
  void initState() {
    super.initState();
    // Fetch doctor schedules
    context.read<ScheduleCubit>().getSchedules(doctorId: widget.doctor.id);
  }

  void _handleBooking() {
    if (_selectedSlot == null) return;
    context.read<BookingCubit>().createBooking(doctorSessionSlotId: _selectedSlot!.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingLoadingState) {
          // Show progress dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(color: AppColors.lavenderColor),
            ),
          );
        } else if (state is BookingErrorState) {
          Navigator.pop(context); // Close loading dialog
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.failure.errors ?? "Failed to book appointment",
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is BookingCreatedState) {
          Navigator.pop(context); // Close loading dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Row(
                children: [
                  Icon(Icons.check_circle_outline, color: Colors.green, size: 30),
                  SizedBox(width: 8),
                  Text("Booking Successful"),
                ],
              ),
              content: Text(
                "Your session with Dr. ${widget.doctor.fullName} has been booked successfully.\nYou can chat with the doctor once they confirm.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close alert dialog
                    Navigator.pop(context); // Pop details screen
                    Navigator.pop(context); // Pop explore screen
                  },
                  child: const Text(
                    "Great!",
                    style: TextStyle(color: AppColors.lavenderColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.gray50,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.gray50,
          foregroundColor: AppColors.blackColor,
          title: const Text("Therapist Profile"),
          centerTitle: true,
        ),
        bottomNavigationBar: _selectedSlot != null
            ? Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Selected Slot:",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
                          ),
                          Text(
                            "${_days[_selectedSlot!.dayOfWeek]} • ${_selectedSlot!.startTime.substring(0, 5)}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.lavenderColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: "Confirm Booking",
                        backgroundColor: AppColors.lavenderColor,
                        width: double.infinity,
                        onPressed: _handleBooking,
                      ),
                    ],
                  ),
                ),
              )
            : null,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Bio Info Card
              _buildDoctorHeader(),
              const SizedBox(height: 24),
              // Available Schedules Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Choose Available Slot",
                  style: AppStyles.bold20Black,
                ),
              ),
              const SizedBox(height: 12),
              _buildSchedulesList(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.lavenderColor.withValues(alpha: 0.15),
            backgroundImage: widget.doctor.profilePicture != null &&
                    widget.doctor.profilePicture!.isNotEmpty
                ? NetworkImage(widget.doctor.profilePicture!)
                : null,
            child: widget.doctor.profilePicture == null ||
                    widget.doctor.profilePicture!.isEmpty
                ? Text(
                    widget.doctor.fullName.isNotEmpty
                        ? widget.doctor.fullName[0].toUpperCase()
                        : 'D',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lavenderColor,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            "Dr. ${widget.doctor.fullName}",
            style: AppStyles.bold22Black,
          ),
          const SizedBox(height: 6),
          Text(
            widget.doctor.specialization ?? "General Wellness",
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.lavenderColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          // Short Bio
          if (widget.doctor.bio != null && widget.doctor.bio!.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.gray50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                widget.doctor.bio!,
                style: const TextStyle(
                  fontSize: 15,
                  color: AppColors.darkGrayColor,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
          ],
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatsCard("Age", "${widget.doctor.age} Yrs", Icons.cake_outlined),
              Container(width: 1, height: 30, color: Colors.grey[200]),
              _buildStatsCard(
                "Gender",
                widget.doctor.gender == 0 ? "Male" : "Female",
                widget.doctor.gender == 0 ? Icons.male : Icons.female,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.blackColor),
        ),
      ],
    );
  }

  Widget _buildSchedulesList() {
    return BlocBuilder<ScheduleCubit, ScheduleState>(
      builder: (context, state) {
        if (state is ScheduleLoadingState) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(color: AppColors.lavenderColor),
            ),
          );
        }

        if (state is ScheduleErrorState) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AppErrorWidget(
              message: state.failure.errors ?? "Failed to load schedules",
              onRetry: () => context.read<ScheduleCubit>().getSchedules(doctorId: widget.doctor.id),
              title: "Connection Problem",
            ),
          );
        }

        if (state is ScheduleListLoadedState) {
          final activeSchedules = state.schedules.where((s) => s.isActive).toList();

          if (activeSchedules.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Icon(Icons.event_busy, size: 48, color: Colors.grey[400]),
                    const SizedBox(height: 12),
                    Text(
                      "No slots available this week.",
                      style: AppStyles.medium16Gray,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: activeSchedules.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final schedule = activeSchedules[index];
              final isSelected = _selectedSlot?.id == schedule.id;

              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.purpleBg : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected ? AppColors.lavenderColor : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      _selectedSlot = isSelected ? null : schedule;
                    });
                  },
                  leading: CircleAvatar(
                    backgroundColor: isSelected ? AppColors.lavenderColor : AppColors.gray50,
                    child: Icon(
                      Icons.access_time_rounded,
                      color: isSelected ? Colors.white : AppColors.lavenderColor,
                    ),
                  ),
                  title: Text(
                    _days[schedule.dayOfWeek],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${schedule.startTime.substring(0, 5)} - ${schedule.endTime.substring(0, 5)}",
                  ),
                  trailing: Icon(
                    isSelected ? Icons.check_circle : Icons.radio_button_off_outlined,
                    color: isSelected ? AppColors.lavenderColor : Colors.grey,
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
