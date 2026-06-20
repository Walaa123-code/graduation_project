import 'package:flutter/material.dart';
import 'package:mindecho/core/theme/app_colors.dart';

import 'package:mindecho/core/utils/app_colors.dart';

class GenderDropdown extends StatefulWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const GenderDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: _current,
      decoration: InputDecoration(
        labelText: 'Gender',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      items: const [
        DropdownMenuItem(value: 0, child: Text('Male')),
        DropdownMenuItem(value: 1, child: Text('Female')),
      ],
      onChanged: (value) {
        if (value != null) {
          setState(() => _current = value);
          widget.onChanged(value);
        }
      },
    );
  }
}
