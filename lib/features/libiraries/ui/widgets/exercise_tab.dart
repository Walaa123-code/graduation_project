import 'package:flutter/material.dart';

import 'exercize_card.dart';

class ExerciseTab extends StatelessWidget {
  const ExerciseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ExerciseCard(
          title: "Breathing Exercise",
          description: "Reduce stress and calm your mind",
          duration: "5 min",
        ),
        ExerciseCard(
          title: "Mindfulness Practice",
          description: "Stay present and focused",
          duration: "10 min",
        ),
        ExerciseCard(
          title: "Body Scan",
          description: "Release physical tension",
          duration: "8 min",
        ),
      ],
    );
  }
}
