import 'package:flutter/material.dart';
import 'package:mindecho/core/utils/app_colors.dart';

/// Toggle بين User و Doctor في شاشة الـ Login
class RoleToggle extends StatelessWidget {
  final bool isDoctorSelected;
  final ValueChanged<bool> onChanged;

  const RoleToggle({
    super.key,
    required this.isDoctorSelected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E8FF),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _RoleTab(
            label: 'User',
            icon: Icons.person_outline,
            isSelected: !isDoctorSelected,
            onTap: () => onChanged(false),
          ),
          _RoleTab(
            label: 'Doctor',
            icon: Icons.medical_services_outlined,
            isSelected: isDoctorSelected,
            onTap: () => onChanged(true),
          ),
        ],
      ),
    );
  }
}

class _RoleTab extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleTab({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 11),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.purpleSoft : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.purpleSoft.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 16,
                  color: isSelected ? Colors.white : AppColors.purpleSoft),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: isSelected ? Colors.white : AppColors.purpleSoft,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
