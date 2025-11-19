import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(label),
      activeThumbColor: AppColors.primary,
    );
  }
}
