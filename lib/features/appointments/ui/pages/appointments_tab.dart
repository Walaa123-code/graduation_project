import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/di/di.dart';
import 'package:mindecho/features/appointments/domain/entities/BookingDataEntity.dart';
import 'package:mindecho/features/appointments/ui/manager/booking_cubit.dart';

class AppointmentsTab extends StatefulWidget {
  const AppointmentsTab({super.key});

  @override
  State<AppointmentsTab> createState() => _AppointmentsTabState();
}

class _AppointmentsTabState extends State<AppointmentsTab> {
  final BookingCubit _bookingCubit = getIt<BookingCubit>();
  int _selectedFilter = 0; // 0=All, 1=Pending, 2=Confirmed

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: _bookingCubit..getAllBookings(),
      child: Scaffold(
        backgroundColor: AppColors.gray50,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.gray50,
          title: Text("My Appointments", style: AppStyles.bold26Black),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter chips
              Row(
                children: [
                  Expanded(child: _buildFilterChip("All", 0)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildFilterChip("Pending", 1)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildFilterChip("Confirmed", 2)),
                ],
              ),

              SizedBox(height: height * 0.02),

              Expanded(
                child: BlocBuilder<BookingCubit, BookingState>(
                  builder: (context, state) {
                    if (state is GetAllBookingsLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.lavenderColor),
                      );
                    }

                    if (state is GetAllBookingsErrorState) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 40),
                              const Icon(Icons.cloud_off_rounded,
                                  size: 75, color: AppColors.gray300),
                              const SizedBox(height: 20),
                              Text("Connection Problem",
                                  style: AppStyles.bold20Black),
                              const SizedBox(height: 10),
                              Text(
                                state.failures.errors,
                                textAlign: TextAlign.center,
                                style: AppStyles.medium16DarkGray,
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton.icon(
                                onPressed: () =>
                                    _bookingCubit.getAllBookings(),
                                icon: const Icon(Icons.refresh,
                                    color: Colors.white),
                                label: Text("Try Again",
                                    style: AppStyles.bold20Whit),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.lavenderColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (state is GetAllBookingsSuccessState) {
                      final allItems =
                          state.getAllBookingsResponseEntity.data ?? [];

                      final items = _selectedFilter == 0
                          ? allItems
                          : allItems
                              .where((e) =>
                                  e.bookingStatus == _selectedFilter - 1)
                              .toList();

                      if (items.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: AppColors.purpleBg,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 50,
                                  color: AppColors.lavenderColor,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text("No appointments found",
                                  style: AppStyles.bold20Black),
                              const SizedBox(height: 8),
                              Text(
                                "Your bookings will appear here",
                                style: AppStyles.medium16Gray,
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return _BookingCard(
                            booking: items[index],
                            onCancel: () => _bookingCubit
                                .changeBookingStatus(
                                    items[index].id!.toInt(), 2),
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, int index) {
    final isSelected = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.lavenderColor
              : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.lavenderColor
                : AppColors.gray300,
            width: 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.lavenderColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.gray600,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final BookingDataEntity booking;
  final VoidCallback onCancel;

  const _BookingCard({required this.booking, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    final statusInfo = _getStatus(booking.bookingStatus?.toInt() ?? 0);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowDefault,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // الـ header بالـ gradient
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.lavenderColor.withOpacity(0.08),
                  AppColors.purpleBg,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                // أيقونة الدكتور
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.lavenderColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person_outline,
                      color: AppColors.lavenderColor, size: 28),
                ),
                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Session #${booking.doctorSessionSlotId ?? '-'}",
                        style: AppStyles.bold18Black,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "Doctor: ${_shortId(booking.doctorId)}",
                        style: AppStyles.medium15Gray,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Status badge
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: (statusInfo['color'] as Color).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: (statusInfo['color'] as Color).withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    statusInfo['label'],
                    style: TextStyle(
                      color: statusInfo['color'],
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // التفاصيل
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // التواريخ
                Row(
                  children: [
                    _infoChip(
                      Icons.access_time_outlined,
                      "Requested",
                      _formatDate(booking.requestedAt),
                      AppColors.gray400,
                    ),
                    if (booking.confirmedAt != null) ...[
                      const SizedBox(width: 12),
                      _infoChip(
                        Icons.check_circle_outline,
                        "Confirmed",
                        _formatDate(booking.confirmedAt),
                        Colors.green,
                      ),
                    ],
                  ],
                ),

                // زرار الإلغاء لو Pending
                if (booking.bookingStatus == 0) ...[
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: onCancel,
                      icon: const Icon(Icons.cancel_outlined,
                          color: AppColors.red, size: 18),
                      label: Text("Cancel Booking",
                          style: AppStyles.medium16Red),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: AppColors.red, width: 1.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding:
                            const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(
      IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.07),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(
                          color: color,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                  Text(value,
                      style: AppStyles.medium15Black,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getStatus(int status) {
    switch (status) {
      case 0:
        return {'label': 'Pending', 'color': const Color(0xFFED8936)};
      case 1:
        return {'label': 'Confirmed', 'color': const Color(0xFF38A169)};
      case 2:
        return {'label': 'Cancelled', 'color': AppColors.red};
      case 3:
        return {'label': 'Completed', 'color': AppColors.lavenderColor};
      default:
        return {'label': 'Unknown', 'color': AppColors.gray400};
    }
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';
    try {
      final d = DateTime.parse(date);
      if (d.year < 2000) return 'N/A';
      return "${d.day}/${d.month}/${d.year}";
    } catch (_) {
      return 'N/A';
    }
  }

  String _shortId(String? id) {
    if (id == null || id.length < 8) return id ?? '-';
    return '${id.substring(0, 8)}...';
  }
}
