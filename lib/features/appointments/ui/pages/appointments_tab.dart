import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindecho/core/components/custom_text_field.dart';
import 'package:mindecho/core/utils/app_colors.dart';
import 'package:mindecho/core/utils/app_styles.dart';
import 'package:mindecho/di/di.dart';
import 'package:mindecho/features/appointments/ui/manager/booking_cubit.dart';
import 'package:mindecho/features/appointments/ui/widgets/booking_card.dart';
import 'package:mindecho/features/appointments/ui/widgets/booking_empty_state.dart';
import 'package:mindecho/features/appointments/ui/widgets/booking_filter_chip.dart';

class AppointmentsTab extends StatefulWidget {
  const AppointmentsTab({super.key});

  @override
  State<AppointmentsTab> createState() => _AppointmentsTabState();
}

class _AppointmentsTabState extends State<AppointmentsTab> {
  final BookingCubit _bookingCubit = getIt<BookingCubit>();
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilter = 0;
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("My Appointments", style: AppStyles.bold26Black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              CustomTextField(
                controller: _searchController,
                hintText: 'Search about doctor.',
                prefixIcon: const Icon(Icons.search,
                    color: Colors.black54, size: 22),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear,
                            color: Colors.black54, size: 20),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
                onChanged: (v) =>
                    setState(() => _searchQuery = v.toLowerCase().trim()),
              ),

              SizedBox(height: height * 0.02),

              // Filter chips
              Row(
                children: [
                  Expanded(
                    child: BookingFilterChip(
                      label: "All",
                      isSelected: _selectedFilter == 0,
                      onTap: () => setState(() => _selectedFilter = 0),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: BookingFilterChip(
                      label: "Pending",
                      isSelected: _selectedFilter == 1,
                      onTap: () => setState(() => _selectedFilter = 1),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: BookingFilterChip(
                      label: "Confirmed",
                      isSelected: _selectedFilter == 2,
                      onTap: () => setState(() => _selectedFilter = 2),
                    ),
                  ),
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
                      return BookingErrorState(
                        message: state.failures.errors,
                        onRetry: () => _bookingCubit.getAllBookings(),
                      );
                    }

                    if (state is GetAllBookingsSuccessState) {
                      final allItems =
                          state.getAllBookingsResponseEntity.data ?? [];

                      var items = _selectedFilter == 0
                          ? allItems
                          : allItems
                              .where((e) =>
                                  e.bookingStatus == _selectedFilter - 1)
                              .toList();

                      if (_searchQuery.isNotEmpty) {
                        items = items
                            .where((e) => (e.doctorId ?? '')
                                .toLowerCase()
                                .contains(_searchQuery))
                            .toList();
                      }

                      if (items.isEmpty) return const BookingEmptyState();

                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return BookingCard(
                            booking: items[index],
                            onCancel: () => _bookingCubit.changeBookingStatus(
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
}
