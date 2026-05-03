// import 'package:flutter/material.dart';
//
// class AppointmentsTab extends StatelessWidget {
//   const AppointmentsTab({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String date;
  final String time;
  final bool isUpcoming;

  const AppointmentCard({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.time,
    required this.isUpcoming,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 26, backgroundColor: Colors.grey[200]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctorName,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600)),
                Text(specialty,
                    style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                const SizedBox(height: 6),
                Text("$date • $time",
                    style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
          if (isUpcoming)
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppColors.gradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text("Join",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            )
        ],
      ),
    );
  }
}
class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xffF6F7FB),
        appBar: AppBar(
          title: const Text("My Appointments"),
          flexibleSpace: Container(decoration: const BoxDecoration(
            gradient: AppColors.gradient,
          )),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Upcoming"),
              Tab(text: "History"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UpcomingTab(),
            HistoryTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const ChooseDoctorScreen()),
            );
          },
          backgroundColor: AppColors.blue,
          label: const Text("Book Appointment"),
        ),
      ),
    );
  }
}
class UpcomingTab extends StatelessWidget {
  const UpcomingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        AppointmentCard(
          doctorName: "Dr. Ahmed Mahmoud",
          specialty: "Psychiatrist",
          date: "Mar 20, 2026",
          time: "10:00 AM",
          isUpcoming: true,
        ),
        AppointmentCard(
          doctorName: "Dr. Sara Ali",
          specialty: "Therapist",
          date: "Mar 25, 2026",
          time: "02:00 PM",
          isUpcoming: true,
        ),
      ],
    );
  }
}
class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        AppointmentCard(
          doctorName: "Dr. Khaled Youssef",
          specialty: "Therapist",
          date: "Jan 10, 2026",
          time: "11:30 AM",
          isUpcoming: false,
        ),
      ],
    );
  }
}
class ChooseDoctorScreen extends StatelessWidget {
  const ChooseDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Doctor"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.gradient),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (_, i) {
          return ListTile(
            leading: const CircleAvatar(),
            title: Text("Dr. Doctor $i"),
            subtitle: const Text("Psychiatrist"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ChooseSlotScreen()),
              );
            },
          );
        },
      ),
    );
  }
}
class ChooseSlotScreen extends StatefulWidget {
  const ChooseSlotScreen({super.key});

  @override
  State<ChooseSlotScreen> createState() => _ChooseSlotScreenState();
}

class _ChooseSlotScreenState extends State<ChooseSlotScreen> {
  int sessionType = 0;
  int? selectedTimeIndex; // ✅ الجديد

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Time"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.gradient,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// session type
            Row(
              children: [
                _typeCard("Online", 0),
                const SizedBox(width: 12),
                _typeCard("Clinic", 1),
              ],
            ),

            const SizedBox(height: 24),

            /// time slots selectable
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                6,
                    (i) => _timeSlot("${9 + i}:00 AM", i),
              ),
            ),

            const Spacer(),

            /// confirm button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(14),
                  backgroundColor: AppColors.blue,
                ),
                onPressed: selectedTimeIndex == null ? null : () {},
                child: const Text("Confirm Appointment"),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// session type card
  Widget _typeCard(String text, int index) {
    final selected = sessionType == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => sessionType = index),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? AppColors.blue : Colors.grey.shade300,
              width: 1.5,
            ),
            color: selected
                ? AppColors.blue.withValues(alpha: .08)
                : Colors.white,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: selected ? AppColors.blue : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// selectable time slot
  Widget _timeSlot(String time, int index) {
    final isSelected = selectedTimeIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTimeIndex = index;
        });
      },
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isSelected
              ? AppColors.blue.withValues(alpha: .08)
              : Colors.white,
          border: Border.all(
            color:
            isSelected ? AppColors.blue : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color:
            isSelected ? AppColors.blue : Colors.black87,
          ),
        ),
      ),
    );
  }
}
