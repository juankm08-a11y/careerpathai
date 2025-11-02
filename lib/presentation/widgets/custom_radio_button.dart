import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final T groupValue;
  final T value;
  final ValueChanged<T?> onChanged;
  final String label;
  const CustomRadioButton({
    super.key,
    required this.groupValue,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      value: value,
      groupValue: groupValue,
      title: Text(label),
      activeColor: AppColors.primary,
    );
  }
}
