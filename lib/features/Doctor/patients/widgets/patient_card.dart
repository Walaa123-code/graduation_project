import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../models/patient_model.dart';
import '../../../../core/components/custom_button.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback onContact;
  final VoidCallback onViewDetails;

  const PatientCard({
    super.key,
    required this.patient,
    required this.onContact,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar (Right side for RTL context, but Flutter default LTR.
              // Desing shows avatar on right. We will use Row with avatar last or Directionality)
              // The design snippet shows Arabic text, implying RTL layout.
              // However, the current codebase seems English/LTR.
              // The prompt says "Avatar / image placeholder on the right".
              // Let's assume standard LTR for now but layout components to match visual.

              // Text Content (Left/Start)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .end, // Align text to right as per Arabic design?
                  // Wait, prompt says "Patient name", "Last status text".
                  // Design image is Arabic. "Patient Name" is on the right of the text block?
                  // Actually in the image, Avatar is on the far right. Text is to the left of the avatar.
                  // Text alignment seems to be Right-aligned (Arabic).
                  // But the user prompt says "Patient name... Avatar... on the right".
                  // If the app is English, usually Avatar is Left, Text is Right.
                  // Requirement: "Avatar / image placeholder on the right".
                  // So we will put Avatar as the last child of the Row.
                  // And align text to the End (Right).

                  children: [
                    Text(
                      patient.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.gray800,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Last status: ${patient.lastStatus} ${patient.lastStatusEmoji}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.gray600,
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      patient.lastSeen,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.gray400,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppTheme.spacingMd),

              // Avatar
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.gray100,
                  border: Border.all(color: AppColors.gray200),
                ),
                child: patient.imageUrl.isNotEmpty
                    ? ClipOval(
                        child: Image.asset(patient.imageUrl, fit: BoxFit.cover))
                    : const Icon(Icons.person,
                        color: AppColors.gray400, size: 30),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingMd),

          // Buttons
          Row(
            children: [
              // "View Details" (Secondary)
              Expanded(
                child: CustomButton(
                  text: 'View Details',
                  onPressed: onViewDetails,
                  isOutlined: true,
                  backgroundColor: AppColors.white,
                  textColor: AppColors.gray700,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
              const SizedBox(width: AppTheme.spacingSm),
              // "Contact" (Primary)
              Expanded(
                child: CustomButton(
                  text: 'Contact',
                  onPressed: onContact,
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  // Icon? Design shows icon. CustomButton doesn't support icon yet.
                  // Design has icon in button.
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
