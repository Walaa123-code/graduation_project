import 'package:flutter/material.dart';

class EmergencyWarningCard extends StatelessWidget {
  const EmergencyWarningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.red,
            child: Icon(Icons.gpp_maybe, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "In an Emergency?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red),
                ),
                const SizedBox(height: 4),
                Text(
                  "If you are in immediate distress, please access our Emergency Hotlines feature.",
                  style: TextStyle(fontSize: 12, color: Colors.red.shade900),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}