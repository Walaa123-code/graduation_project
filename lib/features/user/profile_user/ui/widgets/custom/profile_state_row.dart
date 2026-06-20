import 'package:flutter/material.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.flash_on,
            count: "12",
            label: 'Sessions',
            color: const Color(0xFFEDF7FF),
            iconColor: Colors.blue,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            icon: Icons.edit_note,
            count: "5",
            label: 'Journals',
            color: const Color(0xFFEFFFED),
            iconColor: Colors.green,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            icon: Icons.calendar_today,
            count: "8",
            label: 'Days Active',
            color: const Color(0xFFFFEDFA),
            iconColor: Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String count,
    required String label,
    required Color color,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 6),
          Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}